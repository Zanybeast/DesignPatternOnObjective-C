//
//  SetStrokeSizeCommand.h
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Command.h"

NS_ASSUME_NONNULL_BEGIN

@class SetStrokeSizeCommand;

@protocol SetStrokeSizeCommandDelegate

- (void) command:(SetStrokeSizeCommand *)command didRequestForStrokeSize:(CGFloat*)size;

@end

@interface SetStrokeSizeCommand : Command

@property (nonatomic, weak) id <SetStrokeSizeCommandDelegate> delegate;

- (void) execute;

@end

NS_ASSUME_NONNULL_END
