//
//  Dot.m
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import "Dot.h"

@implementation Dot

@synthesize size = size_, color = color_;

- (void)acceptMarkVisitor:(id<MarkVisitor>)visitor {
    [visitor visitDot:self];
}

- (id)copyWithZone:(NSZone *)zone {
    Dot *dotCopy = [[self class] allocWithZone: zone];
    
    [dotCopy setColor:[UIColor colorWithCGColor:[color_ CGColor]]];
    [dotCopy setSize:size_];
    
    return dotCopy;
}

- (id)initWithCoder:(NSCoder *)coder
{
  if (self = [super initWithCoder:coder])
  {
    color_ = [coder decodeObjectForKey:@"DotColor"];
    size_ = [coder decodeFloatForKey:@"DotSize"];
  }
  
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
  [super encodeWithCoder:coder];
  [coder encodeObject:color_ forKey:@"DotColor"];
  [coder encodeFloat:size_ forKey:@"DotSize"];
}

- (void)drawWithContext:(CGContextRef)context {
    CGFloat x = self.location.x;
    CGFloat y = self.location.y;
    CGFloat frameSize = self.size;
    CGRect frame = CGRectMake(x - frameSize / 2.0,
                              y - frameSize / 2.0,
                              frameSize, frameSize);
    CGContextSetFillColorWithColor(context, [self.color CGColor]);
    CGContextFillEllipseInRect(context, frame);
}

@end
