//
//  OpenScribbleCommand.h
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import "Command.h"
#import "ScribbleSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface OpenScribbleCommand : Command
{
  @private
  id <ScribbleSource> scribbleSource_;
}

@property (nonatomic, retain) id <ScribbleSource> scribbleSource;

- (id) initWithScribbleSource:(id <ScribbleSource>) aScribbleSource;
- (void) execute;

@end

NS_ASSUME_NONNULL_END
