//
//  ThumbnailViewController.m
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import "ThumbnailViewController.h"

@interface ThumbnailViewController ()

@end

@implementation ThumbnailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *backgroundColor = [UIColor colorWithPatternImage:
                                [UIImage imageNamed:@"background_texture"]];
    [[self view] setBackgroundColor:backgroundColor];
    
    scribbleManager_ = [[ScribbleManager alloc] init];
    NSInteger numberOfScribbles = [scribbleManager_ numberOfScribbles];
    [navItem_ setTitle:[NSString stringWithFormat:
                        numberOfScribbles > 1 ? @"%ld items" : @"%ld item",
                        (long)numberOfScribbles]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  CGFloat numberOfPlaceholders = [ScribbleThumbnailCell numberOfPlaceHolders];
  NSInteger numberOfScribbles = [scribbleManager_ numberOfScribbles];
  NSInteger numberOfRows = ceil(numberOfScribbles / numberOfPlaceholders);
  return numberOfRows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  static NSString *CellIdentifier = @"Cell";
  
  ScribbleThumbnailCell *cell = (ScribbleThumbnailCell *)[tableView
                                                          dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil)
  {
    cell = [[ScribbleThumbnailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  }
  
  // Configure the cell...
  
  // populate  thumbnails in each cell
  
  // get max number of thumbnail a thumbnail
  // cell can support
  NSInteger numberOfSupportedThumbnails = [ScribbleThumbnailCell numberOfPlaceHolders];
  
  // we can only add max numberOfSupportedThumbnails
  // at a time in each cell
  // e.g. numberOfSupportedThumbnails = 3
  // thumbnail index in the scribble manager is (row index *3) +0, +1, +2
  NSUInteger rowIndex = [indexPath row];
  NSInteger thumbnailIndex = rowIndex *numberOfSupportedThumbnails;
  NSInteger numberOfScribbles = [scribbleManager_ numberOfScribbles];
  for (NSInteger i = 0; i < numberOfSupportedThumbnails &&
       (thumbnailIndex + i) < numberOfScribbles; ++i)
  {
    UIView *scribbleThumbnail = [scribbleManager_ scribbleThumbnailViewAtIndex:
                                            thumbnailIndex + i];
    [cell addThumbnailView:scribbleThumbnail atIndex:i];
  }
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 150;
}

@end
