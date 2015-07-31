//
//  CLCBannerNotificationDisplayController.h
//  CLCBannerNotifications
//
//  Created by Calvin Cestari on 2015-04-14.
//  Copyright (c) 2015 Calvin Cestari. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CLCBannerNotification.h"

// This class is not meant to be instantiated in your app. It is used by the notification manager.
@interface CLCBannerNotificationDisplayController : NSObject

/*
 * Used to display a banner notification.
 *
 * @param notification The banner notification to display.
 * @param completion The block to be called on completion of displaying the banner notification.
 */
- (void)displayNotification:(CLCBannerNotification *)notification completion:(CLCBannerNotificationCompletion)completion;

@end
