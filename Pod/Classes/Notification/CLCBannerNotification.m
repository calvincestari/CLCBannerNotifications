//
//  CLCBannerNotification.m
//  CLCBannerNotifications
//
//  Created by Calvin Cestari on 2015-04-14.
//  Copyright (c) 2015 Calvin Cestari. All rights reserved.
//

#import "CLCBannerNotification.h"

NSTimeInterval const kCLCBannerNotificationDefaultDisplayTime = 6; // I think this matches the default iOS notification display time

@interface CLCBannerNotification ()

@property (nonatomic, strong, readwrite) NSString *message;
@property (nonatomic, strong, readwrite) UIImage *image;
@property (nonatomic, assign, readwrite) NSTimeInterval displayTime;
@property (nonatomic, copy, readwrite) CLCBannerNotificationCompletion completion;

@end

@implementation CLCBannerNotification

+ (instancetype)notificationWithMessage:(NSString *)message completion:(CLCBannerNotificationCompletion)completion {
    return [self notificationWithMessage:message image:nil displayTime:kCLCBannerNotificationDefaultDisplayTime completion:completion];
}

+ (instancetype)notificationWithMessage:(NSString *)message image:(UIImage *)image displayTime:(NSTimeInterval)displayTime completion:(CLCBannerNotificationCompletion)completion {
    return [[CLCBannerNotification alloc] initWithMessage:message image:image displayTime:displayTime completion:completion];
}

- (instancetype)initWithMessage:(NSString *)message completion:(CLCBannerNotificationCompletion)completion {
    return [self initWithMessage:message image:nil displayTime:kCLCBannerNotificationDefaultDisplayTime completion:completion];
}

- (instancetype)initWithMessage:(NSString *)message image:(UIImage *)image displayTime:(NSTimeInterval)displayTime completion:(CLCBannerNotificationCompletion)completion {
    if (!(self = [super init])) {
        return nil;
    }

    _message = message;
    _image = image;
    _displayTime = displayTime;
    _completion = completion;

    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, message:\"%@\", image:%@ displayTime:%@, completion:%@>", NSStringFromClass([self class]), self, self.message, self.image, @(self.displayTime), self.completion];
}

@end
