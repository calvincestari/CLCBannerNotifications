//
//  CLCBannerNotificationManager.h
//  CLCBannerNotifications
//
//  Created by Calvin Cestari on 2015-04-14.
//  Copyright (c) 2015 Calvin Cestari. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLCBannerNotification.h"

// This class provides an internal (foreground) notification system.
@interface CLCBannerNotificationManager : NSObject

// A shared singleton instance of the notification manager.
+ (instancetype)sharedManager;

/*
 * Adds the notification to the end of the notification queue. Notifications will be displayed in the order in which they are added; FIFO.
 *
 * @param notification The notification to be queued and displayed.
 */
- (void)enqueueNotification:(CLCBannerNotification *)notification;

@end
