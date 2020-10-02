//
//  ScribbleThumbnailView.h
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scribble.h"
#import "ScribbleSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScribbleThumbnailView : UIView<ScribbleSource>
{
  @protected
  NSString *imagePath_;
  NSString *scribblePath_;
}

@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) Scribble *scribble;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *scribblePath;

@end

NS_ASSUME_NONNULL_END
