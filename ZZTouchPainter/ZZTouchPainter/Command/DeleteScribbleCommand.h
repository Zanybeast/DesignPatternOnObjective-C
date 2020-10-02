//
//  DeleteScribbleCommand.h
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import "Command.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeleteScribbleCommand : Command
{

}

- (void) execute;

@end

NS_ASSUME_NONNULL_END
