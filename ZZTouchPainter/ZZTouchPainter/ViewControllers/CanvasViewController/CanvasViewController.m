//
//  CanvasViewController.m
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import "CanvasViewController.h"
#import "Dot.h"
#import "Stroke.h"

@interface CanvasViewController ()

@end

@implementation CanvasViewController

@synthesize canvasView=canvasView_;
@synthesize scribble=scribble_;
@synthesize strokeColor=strokeColor_;
@synthesize strokeSize=strokeSize_;

- (void) setScribble:(Scribble * _Nonnull)aScribble {
    if (scribble_ != aScribble) {
        scribble_ = aScribble;
        
        [scribble_ addObserver:self forKeyPath:@"mark" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CanvasViewGenerator *defaultGenerator = [[CanvasViewGenerator alloc] init];
    [self loadCanvasViewWithGenerator: defaultGenerator];
    
    Scribble *scribble = [[Scribble alloc] init];
    [self setScribble: scribble];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CGFloat redValue = [userDefaults floatForKey:@"red"];
    CGFloat greenValue = [userDefaults floatForKey:@"green"];
    CGFloat blueValue = [userDefaults floatForKey:@"blue"];
    CGFloat sizeValue = [userDefaults floatForKey:@"size"];
    
    [self setStrokeSize:sizeValue];
    [self setStrokeColor:[UIColor colorWithRed:redValue
                                         green:greenValue
                                          blue:blueValue
                                         alpha:1.0]];
}

- (void)setStrokeSize:(CGFloat)aSize {
    if (aSize < 5.0) {
        strokeSize_ = 5.0;
    } else {
        strokeSize_ = aSize;
    }
}
- (IBAction)onCustomBarButtonHit:(CommandBarButton *)sender {
    [[sender command] execute];
}

- (void)onBarButtonHit:(id)button {
    UIBarButtonItem *barButton = button;
    
    if ([barButton tag] == 4) {
        [self.undoManager undo];
    } else if ([barButton tag] == 5) {
        [self.undoManager redo];
    }
}

#pragma mark - Loading a canvasview from a CanvasViewGenerator
- (void)loadCanvasViewWithGenerator:(CanvasViewGenerator *)generator {
    [canvasView_ removeFromSuperview];
    CGRect aFrame = CGRectMake(0, 0,
                               self.view.frame.size.width,
                               self.view.frame.size.height);
    CanvasView *aCanvasView = [generator canvasViewWithFrame:aFrame];
    [self setCanvasView:aCanvasView];
    NSInteger viewIndex = [[[self view] subviews] count] - 1;
    [[self view] insertSubview:canvasView_ atIndex:viewIndex];
}

#pragma mark - Touches event handlers
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    startPoint_ = [[touches anyObject] locationInView:canvasView_];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint lastPoint = [[touches anyObject] previousLocationInView:canvasView_];
    
    if (CGPointEqualToPoint(lastPoint, startPoint_)) {
        id<Mark> newStroke = [[Stroke alloc] init];
        [newStroke setColor:strokeColor_];
        [newStroke setSize:strokeSize_];
        
        NSInvocation *drawInvocation = [self drawScribbleInvocation];
        [drawInvocation setArgument:&newStroke atIndex:2];
        
        NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
        [undrawInvocation setArgument:&newStroke atIndex:2];
        
        [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
    }
    
    CGPoint thisPoint = [[touches anyObject] locationInView:canvasView_];
    Vertex *vertex = [[Vertex alloc] initWithLocation:thisPoint];
    
    [scribble_ addMark:vertex shouldAddToPreviousMark:YES];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint lastPoint = [[touches anyObject] previousLocationInView:canvasView_];
    CGPoint thisPoint = [[touches anyObject] locationInView:canvasView_];
    
    if (CGPointEqualToPoint(lastPoint, thisPoint)) {
        Dot *singleDot = [[Dot alloc] initWithLocation:thisPoint];
        [singleDot setColor:strokeColor_];
        [singleDot setSize:strokeSize_];
        
        NSInvocation *drawInvocation = [self drawScribbleInvocation];
        [drawInvocation setArgument:&singleDot atIndex:2];
        
        NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
        [undrawInvocation setArgument:&singleDot atIndex:2];
        
        [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
    }
    
    startPoint_ = CGPointZero;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    startPoint_ = CGPointZero;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[Scribble class]] && [keyPath isEqualToString:@"mark"]) {
        id<Mark> mark = [change objectForKey:NSKeyValueChangeNewKey];
        [canvasView_ setMark:mark];
        [canvasView_ setNeedsDisplay];
    }
}

#pragma mark - Draw Scribble Invocation Methods
- (NSInvocation *)drawScribbleInvocation {
    NSMethodSignature *executeMethodSignature = [scribble_ methodSignatureForSelector:@selector(addMark:shouldAddToPreviousMark:)];
    
    NSInvocation *drawInvocation = [NSInvocation invocationWithMethodSignature:executeMethodSignature];
    
    [drawInvocation setTarget:scribble_];
    [drawInvocation setSelector:@selector(addMark:shouldAddToPreviousMark:)];
    BOOL attachToPreviousMark = NO;
    [drawInvocation setArgument:&attachToPreviousMark atIndex:3];
    
    return drawInvocation;
}

- (NSInvocation *)undrawScribbleInvocation {
    NSMethodSignature *unexecuteMethodSignature = [scribble_
                                                   methodSignatureForSelector:
                                                   @selector(removeMark:)];
    NSInvocation *undrawInvocation = [NSInvocation
                                      invocationWithMethodSignature:
                                      unexecuteMethodSignature];
    [undrawInvocation setTarget:scribble_];
    [undrawInvocation setSelector:@selector(removeMark:)];
    
    return undrawInvocation;
}

- (void)executeInvocation:(NSInvocation *)invocation
       withUndoInvocation:(NSInvocation *)undoInvocation {
    [invocation retainArguments];

    [[self.undoManager prepareWithInvocationTarget:self]
     unexecuteInvocation:undoInvocation
     withRedoInvocation:invocation];
    
    [invocation invoke];
}

- (void)unexecuteInvocation:(NSInvocation *)invocation
         withRedoInvocation:(NSInvocation *)redoInvocation {
    [[self.undoManager prepareWithInvocationTarget:self]
     executeInvocation:redoInvocation
     withUndoInvocation:invocation];
    
    [invocation invoke];
}

@end
