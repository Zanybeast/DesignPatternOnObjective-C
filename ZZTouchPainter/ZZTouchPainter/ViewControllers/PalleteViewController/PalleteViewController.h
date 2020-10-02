//
//  PalleteViewController.h
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommandBarButton.h"
#import "CommandSlider.h"
#import "SetStrokeColorCommand.h"
#import "SetStrokeSizeCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface PalleteViewController : UIViewController
{
    @private
    IBOutlet CommandSlider *redSlider_;
    IBOutlet CommandSlider *greenSlider_;
    IBOutlet CommandSlider *blueSlider_;
    IBOutlet CommandSlider *sizeSlider_;
    IBOutlet UIView *paletteView_;
}

- (IBAction) onCommandSliderValueChanged:(CommandSlider *)slider;

@end

NS_ASSUME_NONNULL_END
