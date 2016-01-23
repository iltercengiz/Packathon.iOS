//
//  TransitioningDelegate.m
//  Transitioning
//
//  Created by Ilter Cengiz on 09/11/14.
//  Copyright (c) 2014 Ilter Cengiz. All rights reserved.
//

#import "PopupTransitioningDelegate.h"
#import "PopupPresentationController.h"
#import "PopupAnimationController.h"

@interface PopupTransitioningDelegate ()

@property (nonatomic) PopupAnimationController *presented;
@property (nonatomic) PopupAnimationController *dismissed;

@end

@implementation PopupTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[PopupPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.presented;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissed;
}

#pragma mark - Getter

- (PopupAnimationController *)presented {
    if (!_presented) {
        _presented = [PopupAnimationController new];
        _presented.presentation = YES;
    }
    return _presented;
}

- (PopupAnimationController *)dismissed {
    if (!_dismissed) {
        _dismissed = [PopupAnimationController new];
        _dismissed.presentation = NO;
    }
    return _dismissed;
}

@end
