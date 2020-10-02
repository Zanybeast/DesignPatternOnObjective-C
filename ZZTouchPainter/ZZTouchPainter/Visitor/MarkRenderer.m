//
//  MarkRenderer.m
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import "MarkRenderer.h"

@implementation MarkRenderer

- (id)initWithCGContext:(CGContextRef)context {
    if (self = [super init]) {
        context_ = context;
        shouldMoveContextToDot_ = YES;
    }
    return self;
}

- (void)visitMark:(id<Mark>)mark {
    
}

- (void)visitDot:(Dot *)dot {
    CGFloat x = [dot location].x;
    CGFloat y = [dot location].y;
    CGFloat frameSize = [dot size];
    CGRect frame = CGRectMake(x - frameSize / 2.0,
                              y - frameSize / 2.0,
                              frameSize,
                              frameSize);
    
    CGContextSetFillColorWithColor (context_,[[dot color] CGColor]);
    CGContextFillEllipseInRect(context_, frame);
}

- (void)visitVertex:(Vertex *)vertex {
    CGFloat x = [vertex location].x;
    CGFloat y = [vertex location].y;
    
    if (shouldMoveContextToDot_)
    {
      CGContextMoveToPoint(context_, x, y);
      shouldMoveContextToDot_ = NO;
    }
    else
    {
      CGContextAddLineToPoint(context_, x, y);
    }
}

- (void)visitStroke:(Stroke *)stroke {
    CGContextSetStrokeColorWithColor (context_,[[stroke color] CGColor]);
    CGContextSetLineWidth(context_, [stroke size]);
    CGContextSetLineCap(context_, kCGLineCapRound);
    CGContextStrokePath(context_);
    shouldMoveContextToDot_ = YES;
}

@end
