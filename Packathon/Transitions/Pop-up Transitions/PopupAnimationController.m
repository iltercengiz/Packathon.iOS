//
//  AnimationController.m
//  Transitioning
//
//  Created by Ilter Cengiz on 09/11/14.
//  Copyright (c) 2014 Ilter Cengiz. All rights reserved.
//

#import "PopupAnimationController.h"

@interface PopupAnimationController ()

@end

@implementation PopupAnimationController

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    UIView *containerView = [transitionContext containerView];
    
    if (self.presentation) {
        [containerView addSubview:toView];
        CGRect initialFrame;
        CGRect finalFrame;
        initialFrame = [transitionContext finalFrameForViewController:toViewController];
        initialFrame.origin.y = CGRectGetHeight(containerView.frame);
        finalFrame = [transitionContext finalFrameForViewController:toViewController];
        toView.frame = initialFrame;
        toView.layer.cornerRadius = 8.0;
        toView.layer.masksToBounds = YES;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.0
             usingSpringWithDamping:1.0
              initialSpringVelocity:0.5
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             toView.frame = finalFrame;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    } else {
        CGRect finalFrame;
        finalFrame = [transitionContext finalFrameForViewController:fromViewController];
        finalFrame.origin.y += CGRectGetHeight(containerView.frame);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] * 2
                              delay:0.0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             fromView.frame = finalFrame;
                             fromView.transform = CGAffineTransformRotate(fromView.transform, M_PI_4);
                         } completion:^(BOOL finished) {
                             [fromView removeFromSuperview];
                             [transitionContext completeTransition:YES];
                         }];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
