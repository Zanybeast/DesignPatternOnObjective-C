//
//  ScribbleThumbnailViewImageProxy.m
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import "ScribbleThumbnailViewImageProxy.h"

@interface ScribbleThumbnailViewImageProxy ()

- (void) forwardImageLoadingThread;

@end

@implementation ScribbleThumbnailViewImageProxy

@synthesize touchCommand=touchCommand_;
@dynamic imagePath;
@dynamic scribblePath;


- (Scribble *) scribble
{
  if (scribble_ == nil)
  {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *scribbleData = [fileManager contentsAtPath:scribblePath_];
    ScribbleMemento *scribbleMemento = [ScribbleMemento mementoWithData:scribbleData];
    scribble_ = [Scribble scribbleWithMemento:scribbleMemento];
  }
  
  return scribble_;
}

- (UIImage *) image
{
  if (realImage_ == nil)
  {
    realImage_ = [[UIImage alloc] initWithContentsOfFile:imagePath_];
  }
  
  return realImage_;
}

- (void)drawRect:(CGRect)rect
{
  // if is no real image available
  // from realImageView_,
  // then just draw a blank frame
  // as a placeholder image
  if (realImage_ == nil)
  {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // draw a placeholder frame
    // with a 10-user-space-unit-long painted
    // segment and a 3-user-space-unit-long
    // unpainted segment of a dash line
    CGContextSetLineWidth(context, 10.0);
    const CGFloat dashLengths[2] = {10,3};
    CGContextSetLineDash (context, 3, dashLengths, 2);
    CGContextSetStrokeColorWithColor(context, [[UIColor darkGrayColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // launch a thread to load the real
    // payload if it hasn't done yet
    if (!loadingThreadHasLaunched_)
    {
      [self performSelectorInBackground:@selector(forwardImageLoadingThread)
                             withObject:nil];
      loadingThreadHasLaunched_ = YES;
    }
  }
  // otherwise pass the draw*: message
  // along to realImage_ and let it
  // draw the real image
  else
  {
    [realImage_ drawInRect:rect];
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  [touchCommand_ execute];
}

- (void) forwardImageLoadingThread
{
  
  // forward the message to load
  // the real image payload
  [self image];
  
  // redraw itself with the newly loaded image
  [self performSelectorInBackground:@selector(setNeedsDisplay) withObject:nil];
  

}

@end
