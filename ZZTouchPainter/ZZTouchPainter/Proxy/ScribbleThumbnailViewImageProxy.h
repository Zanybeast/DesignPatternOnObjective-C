//
//  ScribbleThumbnailViewImageProxy.h
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import "ScribbleThumbnailView.h"
#import "ScribbleThumbnailView.h"
#import "Command.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScribbleThumbnailViewImageProxy : ScribbleThumbnailView
{
  @private
  Scribble *scribble_;
  Command *touchCommand_;
  UIImage *realImage_;
  BOOL loadingThreadHasLaunched_;
}

@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) Scribble *scribble;
@property (nonatomic, retain) Command *touchCommand;

@end

NS_ASSUME_NONNULL_END
