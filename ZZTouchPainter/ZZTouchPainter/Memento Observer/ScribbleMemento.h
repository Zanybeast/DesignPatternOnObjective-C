//
//  ScribbleMemento.h
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScribbleMemento : NSObject
{
    @private
    id<Mark> mark_;
    BOOL hasCompleteSnapshot_;
}

+ (ScribbleMemento *) mementoWithData: (NSData *)data;
- (NSData *) data;

@end

NS_ASSUME_NONNULL_END
