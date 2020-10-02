//
//  CanvasView.h
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Mark;

@interface CanvasView : UIView
{
    @private
    id<Mark> mark_;
}

@property (nonatomic, retain) id<Mark> mark;

@end

NS_ASSUME_NONNULL_END
