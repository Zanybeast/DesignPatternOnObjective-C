//
//  Stroke.m
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import "Stroke.h"
#import "MarkEnumerator+Internal.h"

@implementation Stroke

@synthesize color = color_, size = size_;
@dynamic location;

- (id) init {
    if (self = [super init]) {
        children_ = [[NSMutableArray alloc] initWithCapacity:5];
    }
    return self;
}

- (void)setLocation:(CGPoint)aPoint {
    //it doesn't set any arbitrary location
}

- (CGPoint) location {
    if ([children_ count] > 0) {
        id<Mark> first = [children_ objectAtIndex:0];
        return [first location];
    }
    
    return CGPointZero;
}

- (void)addMark:(id<Mark>)mark {
    [children_ addObject:mark];
}

- (void)removeMark:(id<Mark>)mark {
    if ([children_ containsObject:mark]) {
        [children_ removeObject:mark];
    } else {
        [children_ makeObjectsPerformSelector:@selector(removeMark:) withObject:mark];
    }
}

- (id<Mark>)childMarkAtIndex:(NSUInteger)index {
    if (index >= [children_ count]) return nil;
    
    return [children_ objectAtIndex:index];
}

- (id<Mark>)lastChild {
    return [children_ lastObject];
}

- (NSUInteger)count {
    return [children_ count];
}

- (void)acceptMarkVisitor:(id<MarkVisitor>)visitor {
    for (id<Mark> dot in children_) {
        [dot acceptMarkVisitor: visitor];
    }
    
    [visitor visitStroke:self];
}

- (id)copyWithZone:(NSZone *)zone {
    Stroke *strokeCopy = [[[self class] allocWithZone:zone] init];
    
    [strokeCopy setColor:[UIColor colorWithCGColor:[color_ CGColor]]];
    
    [strokeCopy setSize:size_];
    
    for (id<Mark> child in children_) {
        id<Mark> childCopy = [child copy];
        [strokeCopy addMark:childCopy];
    }
    
    return strokeCopy;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        color_ = [coder decodeObjectForKey:@"StrokeColor"];
        size_ = [coder decodeFloatForKey:@"StrokeSize"];
        children_ = [coder decodeObjectForKey:@"StrokeChildren"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:color_ forKey:@"StrokeColor"];
    [coder encodeFloat:size_ forKey:@"StrokeSize"];
    [coder encodeObject:children_ forKey:@"StrokeChildren"];
}

#pragma mark - Enumerator methods
- (NSEnumerator *)enumerator {
    return [[MarkEnumerator alloc] initWithMark:self];
}

- (void)enumerateMarksUsingBlock:(void (^)(id<Mark> item, BOOL * stop))block {
    BOOL stop = NO;
    NSEnumerator *enumerator = [self enumerator];
    for (id<Mark> mark in enumerator) {
        block(mark, &stop);
        if (stop) {
            break;
        }
    }
}

- (void)drawWithContext:(CGContextRef)context {
    CGContextMoveToPoint(context, self.location.x, self.location.y);
    for (id<Mark> mark in children_) {
        [mark drawWithContext:context];
    }
    
    CGContextSetLineWidth(context, self.size);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, [self.color CGColor]);
    CGContextStrokePath(context);
}
@end
