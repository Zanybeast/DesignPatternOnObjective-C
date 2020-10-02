//
//  Dot.h
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import "Vertex.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MarkVisitor;

@interface Dot : Vertex
{
    @private
    UIColor *color_;
    CGFloat size_;
}

@property (nonatomic, retain) UIColor *color;
@property (nonatomic, assign) CGFloat size;

- (void)acceptMarkVisitor:(id<MarkVisitor>)visitor;

- (id)copyWithZone:(nullable NSZone *)zone;

- (id)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;

@end

NS_ASSUME_NONNULL_END
