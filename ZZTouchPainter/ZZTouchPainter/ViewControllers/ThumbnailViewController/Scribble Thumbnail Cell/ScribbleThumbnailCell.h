//
//  ScribbleThumbnailCell.h
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScribbleThumbnailView.h"


NS_ASSUME_NONNULL_BEGIN

@interface ScribbleThumbnailCell : UITableViewCell
{
    
}
+ (NSInteger) numberOfPlaceHolders;
- (void) addThumbnailView:(UIView *)thumbnailView
                     atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
