//
//  CLCNotificationBannerView.h
//  CLCBannerNotifications
//
//  Created by Calvin Cestari on 2015-04-14.
//  Copyright (c) 2015 Calvin Cestari. All rights reserved.
//

#import <UIKit/UIKit.h>

// This class is not meant to be instantiated in your app. It is used by the notification manager.
@interface CLCBannerNotificationView : UIView

@property (nonatomic, strong) UILabel *messageLabel; // the label used to display the message.
@property (nonatomic, strong) UIImageView *leftImageView; // the image that will be displayed to the left of the message.

@end
