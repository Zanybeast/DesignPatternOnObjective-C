//
//  MarkVisitor.h
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Mark;
@class Dot, Vertex, Stroke;

@protocol MarkVisitor <NSObject>

- (void) visitMark: (id <Mark>)mark;
- (void) visitDot: (Dot *)dot;
- (void) visitVertex: (Vertex *)vertex;
- (void) visitStroke: (Stroke *)stroke;

@end

NS_ASSUME_NONNULL_END

