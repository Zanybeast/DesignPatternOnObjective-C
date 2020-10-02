//
//  Mark.h
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarkVisitor.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Mark <NSObject, NSCopying, NSCoding>

@property (nonatomic, retain) UIColor *color;
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) id<Mark> lastChild;

- (id) copy;
- (void) addMark: (id<Mark>) mark;
- (void) removeMark: (id<Mark>) mark;
- (id<Mark>) childMarkAtIndex: (NSUInteger) index;

//for visitor pattern
- (void) acceptMarkVisitor: (id<MarkVisitor>) visitor;

//for the iterator pattern
- (NSEnumerator *) enumerator;

//for internal iterator implementation
- (void) enumerateMarksUsingBlock: (void (^)(id<Mark> item, BOOL *stop)) block;

//for a bad example
- (void) drawWithContext: (CGContextRef) context;

@end

NS_ASSUME_NONNULL_END
