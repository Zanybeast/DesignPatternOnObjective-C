//
//  Scribble.h
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"
#import "ScribbleMemento.h"

NS_ASSUME_NONNULL_BEGIN

@interface Scribble : NSObject
{
    @private
    id<Mark> parentMark_;
    id<Mark> incrementalMark_;
}

//Methods for mark management
- (void) addMark: (id<Mark>)aMark shouldAddToPreviousMark: (BOOL)shouldAddToPreviousMark;
- (void) removeMark: (id<Mark>)aMark;

//Methods for memento
- (id) initWithMemento: (ScribbleMemento *)aMemento;
+ (Scribble *) scribbleWithMemento: (ScribbleMemento *) aMemento;
- (ScribbleMemento *) scribbleMemento;
- (ScribbleMemento *) scribbleMementoWithCompleteSnapshot: (BOOL)hasCompleteSnapshot;
- (void) attachStateFromMemento: (ScribbleMemento *)memento;
@end

NS_ASSUME_NONNULL_END
