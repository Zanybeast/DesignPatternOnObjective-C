//
//  ThumbnailViewController.h
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScribbleThumbnailCell.h"
#import "ScribbleManager.h"
#import "CommandBarButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThumbnailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    @private
    IBOutlet UINavigationItem *navItem_;
    ScribbleManager *scribbleManager_;
}
@end

NS_ASSUME_NONNULL_END
