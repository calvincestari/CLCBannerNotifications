//
//  CLCBannerNotificationManager.m
//  CLCBannerNotifications
//
//  Created by Calvin Cestari on 2015-04-14.
//  Copyright (c) 2015 Calvin Cestari. All rights reserved.
//

#import "CLCBannerNotificationManager.h"
#import "CLCNotificationViewController.h"

NSTimeInterval const kCLCDefaultNotificationDisplayTime = 6; // I think this matches the default iOS notification display time

@interface CLCBannerNotificationManager ()

@property (nonatomic, strong) NSMutableArray *notificationQueue;
@property (nonatomic, strong) dispatch_semaphore_t processSemaphore;

@end

@implementation CLCBannerNotificationManager

+ (instancetype)sharedManager {
    static CLCBannerNotificationManager *instance;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        instance = [[CLCBannerNotificationManager alloc] init];
    });

    return instance;
}

// Creates a window and view controller in which to display the banner notification.
+ (CLCNotificationViewController *)viewController {
    static CLCNotificationViewController *viewController;
    static UIWindow *window;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
        window.userInteractionEnabled = YES;
        window.windowLevel = UIWindowLevelAlert;
        window.rootViewController = viewController = [CLCNotificationViewController new];

        [window makeKeyAndVisible];

        viewController.view.frame = window.bounds;
    });

    return viewController;
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

    [self.notificationQueue addObject:notification];

    [self processNotificationQueue];
}

// Sequentially processes all banner notifications and displays each until the display time has elapsed or the user taps the banner view.
- (void)processNotificationQueue {
    if (dispatch_semaphore_wait(self.processSemaphore, DISPATCH_TIME_NOW) == 0) { // only process the queue if we're not busy with a notification already
        CLCBannerNotification *notification = self.notificationQueue.firstObject;

        if (notification) {
            [self.notificationQueue removeObject:notification];

            [[CLCBannerNotificationManager viewController] displayNotification:notification completion:^(CLCNotificationResult result) {
                if (notification.completion) {
                    notification.completion(result);
                }

                dispatch_semaphore_signal(self.processSemaphore); // release semaphore so we can display the next queued notification

                dispatch_async(dispatch_get_main_queue(), ^{
                    [self processNotificationQueue];
                });
            }];

        } else {
            dispatch_semaphore_signal(self.processSemaphore); // release semaphore so we can display the next queued notification
        }
    }
}

@end
