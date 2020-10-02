//
//  ScribbleThumbnailCell.m
//  ZZTouchPainter
//
//  Created by carl on 2020/10/1.
//  Copyright © 2020 carl. All rights reserved.
//

#import "ScribbleThumbnailCell.h"

@implementation ScribbleThumbnailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}

+ (NSInteger)numberOfPlaceHolders {
    return 3;
}

- (void)addThumbnailView:(UIView *)thumbnailView atIndex:(NSInteger)index {
    if (index == 0) {
        for (UIView *view in [[self contentView] subviews]) {
            [view removeFromSuperview];
        }
    }
    
    if (index < [ScribbleThumbnailCell numberOfPlaceHolders])
    {
      CGFloat x = index *90 + (index + 1) *12;
      CGFloat y = 10;
      CGFloat width = 90;
      CGFloat height = 130;
      
      [thumbnailView setFrame:CGRectMake(x, y, width, height)];
      
      [self.contentView addSubview:thumbnailView];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
