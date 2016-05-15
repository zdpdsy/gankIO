//
//  AppDelegate.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/14.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "AppDelegate.h"
#import "GkTabBarController.h"
#import "GkLeftMenuControlller.h"
#import "REFrostedViewController.h"

#import "DKNightVersionManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
   
      GkTabBarController * tabbar = [[GkTabBarController alloc] initWithType:@"all" titleName:@"干货"];
    
       GkLeftMenuControlller *menuController = [[GkLeftMenuControlller alloc] init];
    
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:tabbar menuViewController:menuController];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur = YES;

    self.window.rootViewController = frostedViewController;
    

    [self.window makeKeyAndVisible];
    
    NSArray * arr =@[@"all",@"福利",@"Android", @"iOS",@"休息视频", @"拓展资源", @"前端",@"瞎推荐",@"App",@"订阅"];
    for (NSString * item in arr) {
        [GkUserDefaults setObject:nil forKey: [NSString stringWithFormat:@"currentPage_%@",item]];
    }
    [GkUserDefaults synchronize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NightStyleChange) name:DKNightVersionThemeChangingNotificaiton object:nil];
    return YES;
}
-(void)NightStyleChange{
  //改变颜色
    GkLog(@"改变颜色");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
