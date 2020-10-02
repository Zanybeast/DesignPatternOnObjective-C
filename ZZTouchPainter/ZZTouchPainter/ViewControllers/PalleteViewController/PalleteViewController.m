//
//  PalleteViewController.m
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import "PalleteViewController.h"

@interface PalleteViewController ()

@end

@implementation PalleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // initialize the RGB sliders with
    // a StrokeColorCommand
    SetStrokeColorCommand *colorCommand = (SetStrokeColorCommand *)[redSlider_ command];
    
    // set each color component provider
    // to the color command
    [colorCommand setRGBValuesProvider: ^(CGFloat *red, CGFloat *green, CGFloat *blue)
     {
        *red = [self->redSlider_ value];
        *green = [self->greenSlider_ value];
        *blue = [self->blueSlider_ value];
     }];
    
    // set a post-update provider to the command
    // for any callback after a new color is set
    [colorCommand setPostColorUpdateProvider: ^(UIColor *color)
     {
        [self->paletteView_ setBackgroundColor:color];
     }];
    
    
    // restore the original values of the sliders
    // and the color of the small palette view
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CGFloat redValue = [userDefaults floatForKey:@"red"];
    CGFloat greenValue = [userDefaults floatForKey:@"green"];
    CGFloat blueValue = [userDefaults floatForKey:@"blue"];
    CGFloat sizeValue = [userDefaults floatForKey:@"size"];
    
    [redSlider_ setValue:redValue];
    [greenSlider_ setValue:greenValue];
    [blueSlider_ setValue:blueValue];
    [sizeSlider_ setValue:sizeValue];
    
    UIColor *color = [UIColor colorWithRed:redValue
                                     green:greenValue
                                      blue:blueValue
                                     alpha:1.0];
    
    [paletteView_ setBackgroundColor:color];
}

- (void)viewDidDisappear:(BOOL)animated {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setFloat:[redSlider_ value] forKey:@"red"];
    [userDefaults setFloat:[greenSlider_ value] forKey:@"green"];
    [userDefaults setFloat:[blueSlider_ value] forKey:@"blue"];
    [userDefaults setFloat:[sizeSlider_ value] forKey:@"size"];
}

- (void) command:(SetStrokeColorCommand *) command
                didRequestColorComponentsForRed:(CGFloat *) red
                                          green:(CGFloat *) green
                                           blue:(CGFloat *) blue
{
  *red = [redSlider_ value];
  *green = [greenSlider_ value];
  *blue = [blueSlider_ value];
}

- (void) command:(SetStrokeColorCommand *) command
                didFinishColorUpdateWithColor:(UIColor *) color
{
  [paletteView_ setBackgroundColor:color];
}

#pragma mark SetStrokeSizeCommandDelegate method

- (void) command:(SetStrokeSizeCommand *)command
                didRequestForStrokeSize:(CGFloat *)size
{
  *size = [sizeSlider_ value];
}

- (IBAction) onCommandSliderValueChanged:(CommandSlider *)slider
{
  [[slider command] execute];
}

@end
