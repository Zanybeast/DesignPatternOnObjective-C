//
//  Command.h
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Command : NSObject
{
    @protected
    NSDictionary *userInfo_;
}

@property (nonatomic, retain) NSDictionary *userInfo;

- (void)execute;
- (void)undo;

@end

NS_ASSUME_NONNULL_END
