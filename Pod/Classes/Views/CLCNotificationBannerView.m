//
//  CLCNotificationBannerView.m
//  CLCBannerNotifications
//
//  Created by Calvin Cestari on 2015-04-14.
//  Copyright (c) 2015 Calvin Cestari. All rights reserved.
//

#import <objc/runtime.h>

#import "CLCNotificationBannerView.h"

static void *CLCNotificationBannerViewBackgroundColorKey;
static void *CLCNotificationBannerViewTextColorKey;
static void *CLCNotificationBannerViewFontKey;

@interface CLCNotificationBannerView ()

@property (nonatomic, readonly) UIColor *defaultBackgroundColor;
@property (nonatomic, readonly) UIColor *defaultTextColor;
@property (nonatomic, readonly) UIFont *defaultFont;

@end

@implementation CLCNotificationBannerView

+ (void)setBackgroundColor:(UIColor *)backgroundColor {
    objc_setAssociatedObject([self class], &CLCNotificationBannerViewBackgroundColorKey, backgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)setTextColor:(UIColor *)textColor {
    objc_setAssociatedObject([self class], &CLCNotificationBannerViewTextColorKey, textColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)setFont:(UIFont *)font {
    objc_setAssociatedObject([self class], &CLCNotificationBannerViewFontKey, font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)defaultBackgroundColor {
    id obj = objc_getAssociatedObject([self class], &CLCNotificationBannerViewBackgroundColorKey);

    if (obj && [obj isKindOfClass:[UIColor class]]) {
        return obj;

    } else {
        return [UIColor colorWithWhite:0.21176470588235f alpha:0.98f];
    }
}

- (UIColor *)defaultTextColor {
    id obj = objc_getAssociatedObject([self class], &CLCNotificationBannerViewTextColorKey);

    if (obj && [obj isKindOfClass:[UIColor class]]) {
        return obj;

    } else {
        return [UIColor whiteColor];
    }
}

- (UIFont *)defaultFont {
    id obj = objc_getAssociatedObject([self class], &CLCNotificationBannerViewFontKey);

    if (obj && [obj isKindOfClass:[UIFont class]]) {
        return obj;

    } else {
        return [UIFont systemFontOfSize:16];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) {
        return nil;
    }

    [self configureView];

    return self;
}

- (void)configureView {
    self.backgroundColor = self.defaultBackgroundColor;
    self.clipsToBounds = YES;

    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.numberOfLines = 2;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = self.defaultFont;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = self.defaultTextColor;

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
