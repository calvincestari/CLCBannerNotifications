//
//  CLCNotificationBannerView.m
//  CLCBannerNotifications
//
//  Created by Calvin Cestari on 2015-04-14.
//  Copyright (c) 2015 Calvin Cestari. All rights reserved.
//

#import <objc/runtime.h>

#import "CLCBannerNotificationView.h"

static NSString * const CLCBannerNotificationViewLeftImageObserverKeyPath = @"leftImageView.image";
static void *CLCBannerNotificationViewLeftImageObserverContext = &CLCBannerNotificationViewLeftImageObserverContext;
static CGFloat const CLCBannerNotificationViewImageViewWidth = 44.0f;
static CGFloat const CLCBannerNotificationViewLabelPadding = 15.0f;

@interface CLCBannerNotificationView ()

@property (nonatomic, strong) NSLayoutConstraint *leftImageViewWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *messageLabelLeadingConstraint;

@end

@implementation CLCBannerNotificationView

- (void)dealloc {
    [self removeObserver:self forKeyPath:CLCBannerNotificationViewLeftImageObserverKeyPath context:CLCBannerNotificationViewLeftImageObserverContext];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) {
        return nil;
    }

    [self configureView];

    return self;
}

- (void)configureView {
    self.backgroundColor = [UIColor colorWithRed:0.6980392157f green:0.6980392157f blue:0.6980392157f alpha:1];
    self.clipsToBounds = YES;

    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.numberOfLines = 2;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];

    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];

    [self addSubview:label];
    self.messageLabel = label;

    UIImageView *imageView = [UIImageView new];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeCenter;
    imageView.backgroundColor = [UIColor clearColor];

    [self addSubview:imageView];
    self.leftImageView = imageView;

    NSDictionary *layoutViews = NSDictionaryOfVariableBindings(label, imageView);
    NSMutableArray *layoutConstraints = [NSMutableArray array];

    [layoutConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView][label]-15-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:layoutViews]];
    [layoutConstraints addObjectsFromArray:@[ [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeCenterY multiplier:1 constant:0] ]];
    [layoutConstraints addObjectsFromArray:@[ [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0] ]];
    [layoutConstraints addObjectsFromArray:@[ [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeWidth multiplier:1 constant:0] ]];
    [layoutConstraints addObject:(self.leftImageViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.leftImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:CLCBannerNotificationViewImageViewWidth])];
    [layoutConstraints addObject:(self.messageLabelLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.leftImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.messageLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:0])];

    [self addConstraints:layoutConstraints];

    [self addObserver:self forKeyPath:CLCBannerNotificationViewLeftImageObserverKeyPath options:NSKeyValueObservingOptionNew context:CLCBannerNotificationViewLeftImageObserverContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(__unused id)object change:(NSDictionary *)change context:(void *)context {
    if (context == CLCBannerNotificationViewLeftImageObserverContext) {
        if ([change[NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
            self.leftImageViewWidthConstraint.constant = 0;
            self.messageLabelLeadingConstraint.constant = -CLCBannerNotificationViewLabelPadding;

        } else {
            self.leftImageViewWidthConstraint.constant = CLCBannerNotificationViewImageViewWidth;
            self.messageLabelLeadingConstraint.constant = 0;
        }

        [self setNeedsUpdateConstraints];

    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
