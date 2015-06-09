//
//  CLCNotificationBannerView.h
//  CLCBannerNotifications
//
//  Created by Calvin Cestari on 2015-04-14.
//  Copyright (c) 2015 Calvin Cestari. All rights reserved.
//

#import <UIKit/UIKit.h>

// This class is not meant to be instantiated in your app. It is used by the notification manager.
@interface CLCNotificationBannerView : UIView

@property (nonatomic, strong) UILabel *messageLabel; // the label used to display the message.
@property (nonatomic, strong) UIButton *dismissButton; // the button that allows the user to dismiss the banner view.

/*
 * Use this set the default background color to be used for all banner notifications.
 *
 * @param backgroundColor The default background color to be used for all banner notifications.
 */
+ (void)setBackgroundColor:(UIColor *)backgroundColor;

/*
 * Use this set the default text color to be used for all banner notifications.
 *
 * @param textColor The default text color to be used for all banner notifications.
 */
+ (void)setTextColor:(UIColor *)textColor;

/*
 * Use this set the default font to be used for all banner notifications.
 *
 * @param font The default font to be used for all banner notifications.
 */
+ (void)setFont:(UIFont *)font;

@end
