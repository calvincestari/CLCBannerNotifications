//
//  CLCNotificationBannerView.m
//  CLCBannerNotifications
//
//  Created by Calvin Cestari on 2015-04-14.
//  Copyright (c) 2015 Calvin Cestari. All rights reserved.
//

#import "CLCNotificationBannerView.h"

@implementation CLCNotificationBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) {
        return nil;
    }

    [self configureView];

    return self;
}

- (void)configureView {
    self.backgroundColor = [UIColor colorWithWhite:0.21176470588235f alpha:0.98f];
    self.clipsToBounds = YES;

    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.numberOfLines = 2;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:18];
    label.minimumScaleFactor = 0.888f; // minimum font size 16
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];

    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];

    [self addSubview:label];
    self.messageLabel = label;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.translatesAutoresizingMaskIntoConstraints = NO;

    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CLCBannerNotifications" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    [button setImage:[[UIImage imageNamed:@"icon-cancel-white" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];

    [self addSubview:button];
    self.dismissButton = button;

    NSDictionary *layoutViews = NSDictionaryOfVariableBindings(label, button);
    NSMutableArray *layoutConstraints = [NSMutableArray array];

    [layoutConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[label][button(44)]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:layoutViews]];
    [layoutConstraints addObjectsFromArray:@[ [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeCenterY multiplier:1 constant:0] ]];
    [layoutConstraints addObjectsFromArray:@[ [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeCenterY multiplier:1 constant:0] ]];
    [layoutConstraints addObjectsFromArray:@[ [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeWidth multiplier:1 constant:0] ]];

    [self addConstraints:layoutConstraints];
}

@end
