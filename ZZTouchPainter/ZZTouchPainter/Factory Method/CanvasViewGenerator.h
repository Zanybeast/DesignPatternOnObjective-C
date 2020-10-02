//
//  CanvasViewGenerator.h
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CanvasView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CanvasViewGenerator : NSObject


- (CanvasView *) canvasViewWithFrame:(CGRect) aFrame;

@end

NS_ASSUME_NONNULL_END
