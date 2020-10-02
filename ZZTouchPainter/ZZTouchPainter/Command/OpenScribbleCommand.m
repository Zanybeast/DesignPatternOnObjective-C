//
//  OpenScribbleCommand.m
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import "OpenScribbleCommand.h"
#import "CoordinatingController.h"
#import "CanvasViewController.h"

@implementation OpenScribbleCommand

@synthesize scribbleSource=scribbleSource_;

- (id) initWithScribbleSource:(id <ScribbleSource>) aScribbleSource
{
  if (self = [super init])
  {
    [self setScribbleSource:aScribbleSource];
  }
  
  return self;
}

- (void) execute
{
  // get a scribble from the scribbleSource_
  Scribble *scribble = [scribbleSource_ scribble];
  
  // set it to the current CanvasViewController
  CoordinatingController *coordinator = [CoordinatingController sharedInstance];
  CanvasViewController *controller = [coordinator canvasViewController];
  [controller setScribble:scribble];
  
  // then tell the coordinator to change views
  [coordinator requestViewChangeByObject:self];
}

@end
