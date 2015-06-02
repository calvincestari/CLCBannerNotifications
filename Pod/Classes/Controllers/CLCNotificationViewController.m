//
//  CLCNotificationViewController.m
//  CLCBannerNotifications
//
//  Created by Calvin Cestari on 2015-04-14.
//  Copyright (c) 2015 Calvin Cestari. All rights reserved.
//

#import "CLCNotificationViewController.h"
#import "CLCNotificationBannerView.h"

CGFloat const kCLCNotificationViewControllerPresentDuration = 0.35f;
CGFloat const kCLCNotificationViewControllerDismissDuration = 0.15f;

@interface CLCNotificationViewController ()

@property (nonatomic, strong) CLCNotificationBannerView *bannerView;
@property (nonatomic, copy) CLCNotificationCompletion completionBlock;

@end

@implementation CLCNotificationViewController

- (void)setBannerView:(CLCNotificationBannerView *)bannerView {
    _bannerView = bannerView;

    self.view.window.userInteractionEnabled = (bannerView ? YES : NO);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];
}

- (void)displayNotification:(CLCBannerNotification *)notification completion:(CLCNotificationCompletion)completion {
    NSParameterAssert(notification);

    CGRect rect = CGRectMake(0, -CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    CLCNotificationBannerView *view = [[CLCNotificationBannerView alloc] initWithFrame:rect];
    view.messageLabel.text = notification.message;
    [view.dismissButton addTarget:self action:@selector(userWillDismissNotification:) forControlEvents:UIControlEventTouchUpInside];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userWillInteractNotification:)]];

    [self.view addSubview:view];
    self.bannerView = view;

    [self.view layoutIfNeeded];
    rect.origin.y = 0;

    [UIView animateWithDuration:kCLCNotificationViewControllerPresentDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.frame = rect;

    } completion:^(BOOL finished) {
        __weak __typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(notification.displayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong __typeof(self) strongSelf = weakSelf;

            if (strongSelf.bannerView) {
                [strongSelf dismissBannerView:CLCNotificationDisplayTimeElapsed];
            }
        });
    }];

    self.completionBlock = completion;
}

- (void)userWillDismissNotification:(id)sender {
    [self dismissBannerView:CLCNotificationUserDismiss];
}

- (void)userWillInteractNotification:(id)sender {
    [self dismissBannerView:CLCNotificationUserInteraction];
}

- (void)dismissBannerView:(CLCNotificationResult)result {
    CGRect rect = self.bannerView.frame;
    rect.origin.y = -CGRectGetHeight(rect);

    [UIView animateWithDuration:kCLCNotificationViewControllerDismissDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
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
