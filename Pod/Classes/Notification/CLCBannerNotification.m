//
//  CLCBannerNotification.m
//  CLCBannerNotifications
//
//  Created by Calvin Cestari on 2015-04-14.
//  Copyright (c) 2015 Calvin Cestari. All rights reserved.
//

#import "CLCBannerNotification.h"

@interface CLCBannerNotification ()

@property (nonatomic, strong, readwrite) NSString *message;
@property (nonatomic, assign, readwrite) NSTimeInterval displayTime;
@property (nonatomic, copy, readwrite) CLCNotificationCompletion completion;

@end

@implementation CLCBannerNotification

+ (instancetype)notificationWithMessage:(NSString *)message displayTime:(NSTimeInterval)displayTime completion:(CLCNotificationCompletion)completion {
    return [[CLCBannerNotification alloc] initWithMessage:message displayTime:displayTime completion:completion];
}

- (instancetype)initWithMessage:(NSString *)message displayTime:(NSTimeInterval)displayTime completion:(CLCNotificationCompletion)completion {
    if (!(self = [super init])) {
        return nil;
    }

    _message = message;
    _displayTime = displayTime;
    _completion = completion;

    return self;
}

@end