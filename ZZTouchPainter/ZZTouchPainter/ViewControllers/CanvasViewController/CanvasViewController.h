//
//  CanvasViewController.h
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scribble.h"
#import "CanvasView.h"
#import "CanvasViewGenerator.h"
#import "CommandBarButton.h"
#import "NSMutableArray+Stack.h"

NS_ASSUME_NONNULL_BEGIN

@interface CanvasViewController : UIViewController
{
    @private
    Scribble *scribble_;
    CanvasView *canvasView_;
    
    CGPoint startPoint_;
    UIColor *strokeColor_;
    CGFloat strokeSize_;
}

@property (nonatomic, retain) CanvasView *canvasView;
@property (nonatomic, retain) Scribble *scribble;
@property (nonatomic, retain) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeSize;

- (void) loadCanvasViewWithGenerator: (CanvasViewGenerator *)generator;

- (IBAction)onBarButtonHit:(id)button;

- (NSInvocation *) drawScribbleInvocation;
- (NSInvocation *) undrawScribbleInvocation;

- (void) executeInvocation: (NSInvocation *)invocation withUndoInvocation: (NSInvocation *)undoInvocation;
- (void) unexecuteInvocation: (NSInvocation *)invocation withRedoInvocation: (NSInvocation *)redoInvocation;
@end

NS_ASSUME_NONNULL_END
