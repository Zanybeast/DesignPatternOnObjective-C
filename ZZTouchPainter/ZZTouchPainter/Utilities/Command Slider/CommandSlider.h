//
//  CommandSlider.h
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Command.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommandSlider : UISlider
{
    @protected
    Command *command_;
}

@property (nonatomic, retain) IBOutlet Command *command;

@end

NS_ASSUME_NONNULL_END
