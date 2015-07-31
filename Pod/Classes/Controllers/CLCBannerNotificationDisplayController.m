//
//  CLCBannerNotificationDisplayController.m
//  CLCBannerNotifications
//
//  Created by Calvin Cestari on 2015-04-14.
//  Copyright (c) 2015 Calvin Cestari. All rights reserved.
//

#import "CLCBannerNotificationDisplayController.h"
#import "CLCBannerNotificationView.h"

CGFloat const kCLCBannerNotificationViewControllerPresentDuration = 0.35f;
CGFloat const kCLCBannerNotificationViewControllerDismissDuration = 0.15f;

@interface CLCBannerNotificationDisplayController ()

@property (nonatomic, strong) CLCBannerNotificationView *bannerView;
@property (nonatomic, copy) CLCBannerNotificationCompletion completionBlock;

@end

@implementation CLCBannerNotificationDisplayController

+ (UIWindow *)window {
    static UIWindow *window;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
        window.userInteractionEnabled = YES;
        window.windowLevel = UIWindowLevelAlert;
        window.hidden = YES;
    });

    return window;
}

- (void)setBannerView:(CLCBannerNotificationView *)bannerView {
    _bannerView = bannerView;

    [CLCBannerNotificationDisplayController window].userInteractionEnabled = !([CLCBannerNotificationDisplayController window].hidden = (bannerView ? NO : YES));
}

- (void)displayNotification:(CLCBannerNotification *)notification completion:(CLCBannerNotificationCompletion)completion {
    NSParameterAssert(notification);

    UIWindow *window = [CLCBannerNotificationDisplayController window];

    CGRect displayRect = CGRectMake(0, -CGRectGetHeight(window.bounds), CGRectGetWidth(window.bounds), CGRectGetHeight(window.bounds));

    self.bannerView = ({
        CLCBannerNotificationView *view = [[CLCBannerNotificationView alloc] initWithFrame:displayRect];
        view.messageLabel.text = notification.message;
        view.leftImageView.image = notification.image;

        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userWillInteractNotification:)]];

        view;
    });

    self.completionBlock = completion;

    [window addSubview:self.bannerView];
    [window layoutIfNeeded];

    displayRect.origin.y = 0;

    [UIView animateWithDuration:kCLCBannerNotificationViewControllerPresentDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bannerView.frame = displayRect;

    } completion:^(BOOL finished) {
        __weak __typeof(self) weakSelf = self;

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(notification.displayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong __typeof(self) strongSelf = weakSelf;

            if (strongSelf.bannerView) {
                [strongSelf dismissBannerView:CLCBannerNotificationDisplayTimeElapsed];
            }
        });
    }];
}

- (void)userWillInteractNotification:(id)sender {
    [self dismissBannerView:CLCBannerNotificationUserInteraction];
}

- (void)dismissBannerView:(CLCBannerNotificationResult)result {
    CGRect rect = self.bannerView.frame;
    rect.origin.y = -CGRectGetHeight(rect);

    [UIView animateWithDuration:kCLCBannerNotificationViewControllerDismissDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bannerView.frame = rect;

    } completion:^(BOOL finished) {
        [self.bannerView removeFromSuperview];
        self.bannerView = nil;

        if (self.completionBlock) {
            self.completionBlock(result);
        }
    }];
}

@end
