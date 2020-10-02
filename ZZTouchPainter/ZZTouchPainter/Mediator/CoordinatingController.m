//
//  CoordinatingController.m
//  ZZTouchPainter
//
//  Created by carl on 2020/9/30.
//  Copyright © 2020 carl. All rights reserved.
//

#import "CoordinatingController.h"

@interface CoordinatingController()

- (void) initialize;

@end

@implementation CoordinatingController

@synthesize activeViewController = activeViewController_;
@synthesize canvasViewController = canvasViewController_;

static CoordinatingController *sharedCoordinator = nil;

- (void) initialize {
    canvasViewController_ = [[CanvasViewController alloc] init];
    activeViewController_ = canvasViewController_;
}

#pragma mark -
#pragma mark CoordinatingController Singleton Implemention

+ (CoordinatingController *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedCoordinator == nil) {
            sharedCoordinator = [[super allocWithZone: NULL] init];
        
            [sharedCoordinator initialize];
        }
    });
    return sharedCoordinator;
}


- (IBAction)requestViewChangeByObject:(id)object {
    NSLog(@"something clicked.");
    if ([object isKindOfClass:[UIBarButtonItem class]]) {
        switch ([(UIBarButtonItem *)object tag]) {
            case kButtonTagOpenPalleteView:
            {
                NSLog(@"pallete open button clicked, %d", kButtonTagOpenPalleteView);
                PalleteViewController *controller = [[PalleteViewController alloc] init];
                [canvasViewController_ presentViewController:controller animated:YES completion:nil];
                activeViewController_ = controller;
            }
                break;
            case kButtonTagOpenThumbnailView:
            {
                NSLog(@"thumbnail open button clicked, %d", kButtonTagOpenThumbnailView);
                ThumbnailViewController *controller = [[ThumbnailViewController alloc] init];
                [canvasViewController_ presentViewController:controller animated:YES completion:nil];
                activeViewController_ = controller;
            }
                break;
            default:
            {
                [canvasViewController_ dismissViewControllerAnimated:YES completion:nil];
                activeViewController_ = canvasViewController_;
            }
                break;
        }
    } else {
        [canvasViewController_ dismissViewControllerAnimated:YES completion:nil];
        activeViewController_ = canvasViewController_;
    }
}


@end
