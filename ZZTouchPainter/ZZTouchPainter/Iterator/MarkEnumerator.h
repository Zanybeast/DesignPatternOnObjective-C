//
//  MarkEnumerator.h
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableArray+Stack.h"
#import "Mark.h"

NS_ASSUME_NONNULL_BEGIN

@interface MarkEnumerator : NSEnumerator
{
    @private
    NSMutableArray *stack_;
}

- (NSArray *)allObjects;
- (id)nextObject;

@end

NS_ASSUME_NONNULL_END
