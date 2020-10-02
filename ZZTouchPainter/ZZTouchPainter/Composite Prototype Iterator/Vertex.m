//
//  Vertex.m
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import "Vertex.h"

@implementation Vertex

@synthesize location = location_;
@dynamic color, size;

- (id)initWithLocation:(CGPoint)location {
    if (self = [super init]) {
        [self setLocation: location];
    }
    
    return self;
}

#pragma mark - Default property do nothing
- (void) setColor:(UIColor *)color {}
- (UIColor *) color { return nil; }
- (void) setSize:(CGFloat)size {}
- (CGFloat) size { return 0.0; }

#pragma mark - Mark operation do nothing
- (void) addMark:(id <Mark>) mark {}
- (void) removeMark:(id <Mark>) mark {}
- (id <Mark>) childMarkAtIndex:(NSUInteger) index { return nil; }
- (id <Mark>) lastChild { return nil; }
- (NSUInteger) count { return 0; }
- (NSEnumerator *) enumerator { return nil; }

- (void)acceptMarkVisitor:(id<MarkVisitor>)visitor {
    [visitor visitVertex:self];
}

#pragma mark - NSCopying method
- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        location_ = [(NSValue *)[coder decodeObjectForKey:@"VertexLocation"] CGPointValue];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:[NSValue valueWithCGPoint:location_] forKey:@"VertexLoaction"];
}

- (void)enumerateMarksUsingBlock:(void (^)(id<Mark> _Nonnull, BOOL * _Nonnull))block {
    
}

- (void)drawWithContext:(CGContextRef)context {
    CGFloat x = self.location.x;
    CGFloat y = self.location.y;
    
    CGContextAddLineToPoint(context, x, y);
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    Vertex *vertexCopy = [[[self class] allocWithZone:zone] initWithLocation:location_];
    
    return vertexCopy;
}

@end
