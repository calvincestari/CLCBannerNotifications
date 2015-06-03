//
//  CLCBannerNotification.h
//  CLCBannerNotifications
//
//  Created by Calvin Cestari on 2015-04-14.
//  Copyright (c) 2015 Calvin Cestari. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CLCNotificationResult) {
    CLCNotificationUserDismiss, // when the user taps the X button to dismiss
    CLCNotificationUserInteraction, // when the user taps the banner view; can be used to assume dismissal too
    CLCNotificationDisplayTimeElapsed // when the banner notification is automatically dismissed after the display time has elapsed
};

extern NSTimeInterval const kCLCDefaultBannerNotificationDisplayTime;

typedef void (^CLCNotificationCompletion)(CLCNotificationResult result);

// This class encapsulates a banner notification that is queued with the notification manager.
@interface CLCBannerNotification : NSObject

@property (nonatomic, strong, readonly) NSString *message; // the message to display
@property (nonatomic, assign, readonly) NSTimeInterval displayTime; // how long the banner notification will be displayed for
@property (nonatomic, copy, readonly) CLCNotificationCompletion completion; // called when the user taps the banner notification or the display time elapses

/*
 * Convenience method to allocate and initialize a banner notification in one step. Default display time will be used.
 *
 * @return A fully initialized banner notification object.
 *
 * @param message The text to display.
 * @param completion A block that will be called once the banner notification is dismissed.
 */
+ (instancetype)notificationWithMessage:(NSString *)message completion:(CLCNotificationCompletion)completion;

/*
 * Convenience method to allocate and initialize a banner notification in one step.
 *
 * @return A fully initialized banner notification object.
 *
 * @param message The text to display.
 * @param displayTime The duration to display the banner notification for.
 * @param completion A block that will be called once the banner notification is dismissed.
 */
+ (instancetype)notificationWithMessage:(NSString *)message displayTime:(NSTimeInterval)displayTime completion:(CLCNotificationCompletion)completion;

/*
 * Initializes a banner notification. Default display time will be used.
 *
 * @return A fully initialized banner notification object.
 *
 * @param message The text to display.
 * @param completion A block that will be called once the banner notification is dismissed.
 */
- (instancetype)initWithMessage:(NSString *)message completion:(CLCNotificationCompletion)completion;

/*
 * Initializes a banner notification.
 *
 * @return A fully initialized banner notification object.
 *
 * @param message The text to display.
 * @param displayTime The duration to display the banner notification for.
 * @param completion A block that will be called once the banner notification is dismissed.
 */
- (instancetype)initWithMessage:(NSString *)message displayTime:(NSTimeInterval)displayTime completion:(CLCNotificationCompletion)completion;

@end
