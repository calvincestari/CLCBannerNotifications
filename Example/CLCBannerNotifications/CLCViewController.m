//
//  CLCViewController.m
//  CLCBannerNotifications
//
//  Created by Calvin Cestari on 06/02/2015.
//  Copyright (c) 2014 Calvin Cestari. All rights reserved.
//

#import <CLCBannerNotifications/CLCBannerNotificationManager.h>

#import "CLCViewController.h"

@interface CLCViewController ()

@end

@implementation CLCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    CLCBannerNotification *notification = [CLCBannerNotification notificationWithMessage:@"Thanks for using CLCBannerNotifications!" completion:nil];
    [[CLCBannerNotificationManager sharedManager] enqueueNotification:notification];
}

@end
