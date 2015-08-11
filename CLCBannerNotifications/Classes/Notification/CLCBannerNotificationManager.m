//
//  CLCBannerNotificationManager.m
//  CLCBannerNotifications
//
//  Created by Calvin Cestari on 2015-04-14.
//  Copyright (c) 2015 Calvin Cestari. All rights reserved.
//

#import "CLCBannerNotificationManager.h"
#import "CLCBannerNotificationDisplayController.h"

CGFloat const kCLCBannerNotificationViewPresentDuration = 0.35f;
CGFloat const kCLCBannerNotificationViewDismissDuration = 0.15f;

@interface CLCBannerNotificationManager ()

@property (nonatomic, strong) NSMutableArray *notificationQueue;
@property (nonatomic, strong) dispatch_semaphore_t processSemaphore;
@property (nonatomic, readonly) CLCBannerNotificationDisplayController *displayController;

@end

@implementation CLCBannerNotificationManager

+ (instancetype)sharedManager {
    static CLCBannerNotificationManager *obj;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        obj = [CLCBannerNotificationManager new];
    });

    return obj;
}

- (CLCBannerNotificationDisplayController *)displayController {
    static CLCBannerNotificationDisplayController *obj;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        obj = [CLCBannerNotificationDisplayController new];
    });

    return obj;
}

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }

    _notificationQueue = [NSMutableArray array];
    _processSemaphore = dispatch_semaphore_create(1); // a dispatch semaphore with a count of 1 is probably overkill..

    return self;
}

- (void)enqueueNotification:(CLCBannerNotification *)notification {
    NSParameterAssert(notification);

    if (notification) {
        [self.notificationQueue addObject:notification];

        [self processNotificationQueue];
    }
}

// Sequentially processes all banner notifications and displays each until the display time has elapsed or the user taps the banner view.
- (void)processNotificationQueue {
    if (dispatch_semaphore_wait(self.processSemaphore, DISPATCH_TIME_NOW) == 0) { // only process the queue if we're not busy with a notification already
        CLCBannerNotification *notification = self.notificationQueue.firstObject;

        if (notification) {
            [self.notificationQueue removeObject:notification];

            [self.displayController displayNotification:notification completion:^(CLCBannerNotificationResult result) {
                if (notification.completion) {
                    notification.completion(result);
                }

                dispatch_semaphore_signal(self.processSemaphore); // release semaphore so we can display the next queued notification

                if (self.notificationQueue.count) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self processNotificationQueue];
                    });
                }
            }];

        } else {
            dispatch_semaphore_signal(self.processSemaphore); // release semaphore so we can display the next queued notification
        }
    }
}

@end
