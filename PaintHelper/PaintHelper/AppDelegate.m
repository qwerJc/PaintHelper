//
//  AppDelegate.m
//  PaintHelper
//
//  Created by 贾辰 on 18/8/9.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "AppDelegate.h"


#import "Measure/MeasureViewController.h"
#import "Projects/ProjectsViewController.h"
#import "Tools/ToolsViewController.h"

@interface AppDelegate ()
@property (strong, nonatomic) ProjectsViewController *projectsVC;
@property (strong, nonatomic) MeasureViewController *measureVC;
@property (strong, nonatomic) ToolsViewController *toolsVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _projectsVC = [[ProjectsViewController alloc] init];
    _projectsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Projects" image:nil tag:0];
    
    _measureVC = [[MeasureViewController alloc] init];
    _measureVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Measure" image:nil tag:1];
    
    _toolsVC = [[ToolsViewController alloc] init];
    _toolsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Tools" image:nil tag:2];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController addChildViewController:_projectsVC];
    [tabBarController addChildViewController:_measureVC];
    [tabBarController addChildViewController:_toolsVC];

    self.window = [[UIWindow alloc] init];
    [self.window makeKeyWindow];
    [self.window setFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tabBarController;
    return YES;
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
