//
//  ScribbleSource.h
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scribble.h"

@protocol ScribbleSource

- (Scribble *) scribble;

@end
