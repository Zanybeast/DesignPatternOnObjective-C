//
//  DeleteScribbleCommand.m
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import "DeleteScribbleCommand.h"
#import "CoordinatingController.h"
#import "CanvasViewController.h"


@implementation DeleteScribbleCommand

- (void) execute
{
  // get a hold of the current
  // CanvasViewController from
  // the CoordinatingController
  CoordinatingController *coordinatingController = [CoordinatingController sharedInstance];
  CanvasViewController *canvasViewController = [coordinatingController canvasViewController];
  
  // create a new scribble for
  // canvasViewController
  Scribble *newScribble = [[Scribble alloc] init];
  [canvasViewController setScribble:newScribble];
}

@end
