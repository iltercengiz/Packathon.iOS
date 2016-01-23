//
//  AnimationController.h
//  Transitioning
//
//  Created by Ilter Cengiz on 09/11/14.
//  Copyright (c) 2014 Ilter Cengiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PopupAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) BOOL presentation;

@end
