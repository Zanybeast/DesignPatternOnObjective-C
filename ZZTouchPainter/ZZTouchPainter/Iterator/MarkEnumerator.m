//
//  MarkEnumerator.m
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import "MarkEnumerator.h"
#import "MarkEnumerator+Internal.h"

@implementation MarkEnumerator

- (NSArray *)allObjects {
    return [[stack_ reverseObjectEnumerator] allObjects];
}

- (id)nextObject {
    return [stack_ pop];
}

- (id)initWithMark:(id<Mark>)aMark {
    if (self = [super init]) {
        stack_ = [[NSMutableArray alloc] initWithCapacity:[aMark count]];
        [self traverseAndBuildStackWithMark:aMark];
    }
    return self;
}

- (void)traverseAndBuildStackWithMark:(id<Mark>)mark {
    if (mark == nil) {
        return;
    }
    
    [stack_ push:mark];
    
    NSUInteger index = [mark count];
    id<Mark> childMark;
    while ((childMark = [mark childMarkAtIndex:--index])) {
        [self traverseAndBuildStackWithMark:childMark];
    }
}

@end
