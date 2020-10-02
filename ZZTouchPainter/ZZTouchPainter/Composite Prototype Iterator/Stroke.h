//
//  Stroke.h
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"
#import "MarkEnumerator.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MarkVisitor;

@interface Stroke : NSObject<Mark>
{
    @private
    UIColor *color_;
    CGFloat size_;
    NSMutableArray *children_;
}

@property (nonatomic, retain) UIColor *color;
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) id<Mark> lastChild;

- (void) addMark:(id <Mark>) mark;
- (void) removeMark:(id <Mark>) mark;
- (id <Mark>) childMarkAtIndex:(NSUInteger) index;

//for the visitor apttern
- (void) acceptMarkVisitor:(id<MarkVisitor>)visitor;

- (id)copyWithZone: (nullable NSZone *)zone;

- (NSEnumerator *) enumerator;

- (void) enumerateMarksUsingBlock:(void (^)(id<Mark> item, BOOL * stop))block;

//for the memento pattern
- (id) initWithCoder:(NSCoder *)coder;
- (void) encodeWithCoder: (NSCoder *)coder;

@end

NS_ASSUME_NONNULL_END
