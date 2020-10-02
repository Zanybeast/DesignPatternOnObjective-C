//
//  ScribbleMemento.m
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import "ScribbleMemento.h"
#import "ScribbleMemento+Friend.h"

@implementation ScribbleMemento

@synthesize mark = mark_;
@synthesize hasCompleteSnapshot = hasCompleteSnapshot_;

- (id)initWithMark:(id<Mark>)aMark {
    if (self = [super init]) {
        [self setMark:aMark];
    }
    return self;
}

- (NSData *)data {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mark_ requiringSecureCoding:NO error:nil];
    return data;
}

+ (ScribbleMemento *)mementoWithData:(NSData *)data {
    id<Mark> retoreMark = (id<Mark>)[NSKeyedUnarchiver unarchivedObjectOfClass: [NSObject class] fromData:data error:nil];
    ScribbleMemento *memento = [[ScribbleMemento alloc] initWithMark:retoreMark];
    return memento;
}

@end
