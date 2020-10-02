//
//  NSMutableArray+Stack.h
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (Stack)

- (void) push: (id)object;
- (id) pop;
- (void) dropBottom;

@end

NS_ASSUME_NONNULL_END
