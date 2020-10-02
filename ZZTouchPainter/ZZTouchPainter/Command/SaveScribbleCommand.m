//
//  SaveScribbleCommand.m
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import "SaveScribbleCommand.h"
#import "ScribbleManager.h"
#import "CoordinatingController.h"
#import "UIView+UIImage.h"


@implementation SaveScribbleCommand

- (void) execute
{
  // get a hold of all necessary information
  // from an instance of CanvasViewController
  // for saving its Scribble
  CoordinatingController *coordinatingController = [CoordinatingController sharedInstance];
  CanvasViewController *canvasViewController = [coordinatingController canvasViewController];
  UIImage *canvasViewImage = [[canvasViewController canvasView] image];
  Scribble *scribble = [canvasViewController scribble];
  
  // use an instance of ScribbleManager
  // to save the scribble and its thumbnail
  ScribbleManager *scribbleManager = [[ScribbleManager alloc] init];
  [scribbleManager saveScribble:scribble thumbnail:canvasViewImage];
  
  // finally show an alertbox that says
  // after the scribble is saved
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Great!" message:@"Your scribble is saved." preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle: @"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:action];
    [canvasViewController presentViewController:alertController animated:YES completion:nil];
  
}

@end
