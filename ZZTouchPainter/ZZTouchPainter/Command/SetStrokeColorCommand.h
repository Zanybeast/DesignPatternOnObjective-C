//
//  SetStrokeColorCommand.h
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import "Command.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^RGBValuesProvider)(CGFloat *red, CGFloat *green, CGFloat *blue);
typedef void (^PostColorUpdateProvider)(UIColor *color);

@class SetStrokeColorCommand;

@protocol SetStrokeColorCommandDelegate

- (void) command:(SetStrokeColorCommand *) command
                didRequestColorComponentsForRed:(CGFloat *) red
                                          green:(CGFloat *) green
                                           blue:(CGFloat *) blue;

- (void) command:(SetStrokeColorCommand *) command
                didFinishColorUpdateWithColor:(UIColor *) color;

@end


@interface SetStrokeColorCommand : Command
{
  @private
  RGBValuesProvider RGBValuesProvider_;
  PostColorUpdateProvider postColorUpdateProvider_;
}

@property (nonatomic, weak) id <SetStrokeColorCommandDelegate> delegate;
@property (nonatomic, copy) RGBValuesProvider RGBValuesProvider;
@property (nonatomic, copy) PostColorUpdateProvider postColorUpdateProvider;

- (void) execute;

@end

NS_ASSUME_NONNULL_END
