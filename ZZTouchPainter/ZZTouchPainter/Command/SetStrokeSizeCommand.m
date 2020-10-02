//
//  SetStrokeSizeCommand.m
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import "SetStrokeSizeCommand.h"
#import "CoordinatingController.h"
#import "CanvasViewController.h"

@implementation SetStrokeSizeCommand

- (void) execute
{
    // get the current stroke size
    // from whatever it's my delegate
    CGFloat strokeSize = 1;
    [self.delegate command:self didRequestForStrokeSize:&strokeSize];
  
    // get a hold of the current
    // canvasViewController from
    // the coordinatingController
    // (see the Mediator pattern chapte
    // for details)
    CoordinatingController *coordinator = [CoordinatingController sharedInstance];
    CanvasViewController *controller = [coordinator canvasViewController];

    // assign the stroke size to
    // the canvasViewController
    [controller setStrokeSize:strokeSize];
}

@end
