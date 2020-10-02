//
//  Scribble.m
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import "Scribble.h"
#import "ScribbleMemento+Friend.h"
#import "Stroke.h"

@interface Scribble()

@property (nonatomic, retain) id<Mark> mark;

@end

@implementation Scribble

@synthesize mark = parentMark_;

- (id) init {
    if (self = [super init]) {
        parentMark_ = [[Stroke alloc] init];
    }
    
    return self;
}

#pragma mark - Methods for Mark management
- (void)addMark:(id<Mark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark {
    [self willChangeValueForKey: @"mark"];
    
    if (shouldAddToPreviousMark) {
        [[parentMark_ lastChild] addMark: aMark];
    } else {
        [parentMark_ addMark: aMark];
        incrementalMark_ = aMark;
    }
    
    [self didChangeValueForKey:@"mark"];
}

- (void)removeMark:(id<Mark>)aMark {
    if (aMark == parentMark_) {
        return;
    }
    
    [self willChangeValueForKey: @"mark"];
    
    [parentMark_ removeMark: aMark];
    if (aMark == incrementalMark_) {
        incrementalMark_ = nil;
    }
    
    [self didChangeValueForKey: @"mark"];
}

#pragma mark - Methods for memento
- (id)initWithMemento:(ScribbleMemento *)aMemento {
    if (self = [super init]) {
        if ([aMemento hasCompleteSnapshot]) {
            [self setMark:[aMemento mark]];
        } else {
            parentMark_ = [[Stroke alloc] init];
            [self attachStateFromMemento:aMemento];
        }
    }
    
    return self;
}

- (void)attachStateFromMemento:(ScribbleMemento *)memento {
    [self addMark:[memento mark] shouldAddToPreviousMark:NO];
}

- (ScribbleMemento *)scribbleMementoWithCompleteSnapshot:(BOOL)hasCompleteSnapshot {
    id<Mark> mementoMark = incrementalMark_;
    
    if (hasCompleteSnapshot) {
        mementoMark = parentMark_;
    } else if (mementoMark == nil) {
        return nil;
    }
    
    ScribbleMemento *memento = [[ScribbleMemento alloc] initWithMark:mementoMark];
    [memento setHasCompleteSnapshot:hasCompleteSnapshot];
    
    return memento;
}

- (ScribbleMemento *)scribbleMemento {
    return [self scribbleMementoWithCompleteSnapshot:YES];
}

+ (Scribble *)scribbleWithMemento:(ScribbleMemento *)aMemento {
    Scribble *scribble = [[Scribble alloc] initWithMemento:aMemento];
    return scribble;
}

@end
