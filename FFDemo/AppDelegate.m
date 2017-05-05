//
//  AppDelegate.m
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "AppDelegate.h"

#import "SSTabBarView.h"

#import "FFBaseShareCenter.h"

#import "FFBaseRequest.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    SSTabBarView *tabBar = [SSTabBarView createTabBarView];
    [self.window addSubview:tabBar];
    self.window.rootViewController = tabBar.tabBarController;
    [SSTabBarView selectedIndex:0];
    
    tabBar.tabBarController.view.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        tabBar.tabBarController.view.alpha = 1;
    }];
    
    
    NSDictionary *appIdDict = @{QQAppIdKey : @"自己申请",
                                SinaAppIdKey : @"2107117237",
                                WeChatAppIdKey : @"自己申请"};
    NSDictionary *appSecret = @{WeChatAppSecretKey : @"自己申请"};
    NSDictionary *redirectURIDict = @{SinaRedirectURIKey : @"https://api.weibo.com/oauth2/default.html"};
    [FFBaseShareCenter setAppId:appIdDict appSecret:appSecret redirectURI:redirectURIDict];
    
    [FFBaseRequest starNetWorkReachability];

    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    NSLog(@"------>>> %@",url);
    
#warning Attention
    return [FFBaseShareCenter handlerOpenURL:url sourceApplication:sourceApplication];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
