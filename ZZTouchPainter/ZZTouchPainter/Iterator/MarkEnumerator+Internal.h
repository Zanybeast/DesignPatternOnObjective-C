//
//  MarkEnumerator+Internal.h
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarkEnumerator ()

- (id) initWithMark: (id<Mark>) mark;
- (void) traverseAndBuildStackWithMark: (id<Mark>)mark;

@end
