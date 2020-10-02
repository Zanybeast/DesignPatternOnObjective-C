//
//  CoordinatingController.h
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CanvasViewController.h"
#import "ThumbnailViewController.h"
#import "PalleteViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    kButtonTagDone,
    kButtonTagOpenPalleteView,
    kButtonTagOpenThumbnailView,
} ButtonTag;

@interface CoordinatingController : NSObject
{
    @private
    CanvasViewController *canvasViewController_;
    UIViewController *activeViewController_;
}

@property(nonatomic, readonly) UIViewController *activeViewController;
@property(nonatomic, readonly) CanvasViewController *canvasViewController;

+ (CoordinatingController *) sharedInstance;

- (IBAction) requestViewChangeByObject:(id)object;

@end

NS_ASSUME_NONNULL_END
