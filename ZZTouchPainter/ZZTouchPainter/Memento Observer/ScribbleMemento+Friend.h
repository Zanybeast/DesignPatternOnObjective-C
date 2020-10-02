//
//  ScribbleMemento+Friend.h
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import "ScribbleMemento.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScribbleMemento ()

- (id) initWithMark: (id<Mark>)aMark;

@property (nonatomic, copy) id<Mark> mark;
@property (nonatomic, assign) BOOL hasCompleteSnapshot;

@end

NS_ASSUME_NONNULL_END
