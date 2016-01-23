//
//  PresentationController.m
//  Transitioning
//
//  Created by Ilter Cengiz on 09/11/14.
//  Copyright (c) 2014 Ilter Cengiz. All rights reserved.
//

#import "PopupPresentationController.h"

@implementation PopupPresentationController

#pragma mark - Init

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        _overlayView = [UIView new];
        _overlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.32];
    }
    return self;
}

#pragma mark - Size and Layout

- (CGRect)frameOfPresentedViewInContainerView {
    CGRect presentedViewFrame = CGRectZero;
    CGRect containerViewBounds = self.containerView.bounds;
    
    presentedViewFrame.size = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    presentedViewFrame.origin = CGPointMake((CGRectGetWidth(containerViewBounds) - CGRectGetWidth(presentedViewFrame)) / 2.0, (CGRectGetHeight(containerViewBounds) - CGRectGetHeight(presentedViewFrame)) / 2.0);
    
    return presentedViewFrame;
}

- (void)containerViewWillLayoutSubviews {
    self.overlayView.frame = self.containerView.bounds;
    self.presentedView.frame = [self frameOfPresentedViewInContainerView];
}

#pragma mark - Tracking the transition

- (void)presentationTransitionWillBegin {
    UIView *containerView = self.containerView;
    UIViewController *presentedViewController = self.presentedViewController;
    
    self.overlayView.frame = containerView.bounds;
    self.overlayView.alpha = 0.0;
    
    [containerView insertSubview:self.overlayView atIndex:0];
    
    if (presentedViewController.transitionCoordinator) {
        [presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            self.overlayView.alpha = 1.0;
        } completion:nil];
    } else {
        self.overlayView.alpha = 1.0;
    }
}

- (void)dismissalTransitionWillBegin {
    UIViewController *presentedViewController = self.presentedViewController;
    
    if (presentedViewController.transitionCoordinator) {
        [presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            self.overlayView.alpha = 0.0;
        } completion:nil];
    } else {
        self.overlayView.alpha = 0.0;
    }
}

#pragma mark - Content container

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    return CGSizeMake(parentSize.width * 0.8, parentSize.height * 0.7);
}

@end
