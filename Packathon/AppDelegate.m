//
//  AppDelegate.m
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[[Crashlytics class]]];
    UIColor *tintColor = [UIColor colorWithRed:0.247 green:0.317 blue:0.709 alpha:1];
    [[UINavigationBar appearance] setBarTintColor:tintColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UITabBar appearance] setBarTintColor:tintColor];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    return YES;
}

@end
