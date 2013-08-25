//
//  ShareDemoAppDelegate.m
//  ShareDemo
//
//  Created by ligf on 13-2-21.
//  Copyright (c) 2013年 ligf. All rights reserved.
//

#import "ShareDemoAppDelegate.h"
#import "RootViewController.h"
#import "SinaWeiboViewController.h"
#import "SinaWeibo.h"
#import "Constants.h"

@implementation ShareDemoAppDelegate
@synthesize navController = _navController;
@synthesize viewController = _viewController;
@synthesize sinaweibo;

- (void)dealloc
{
    [_window release];
    [_navController release];
    [_viewController release];
    [sinaweibo release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    RootViewController *rootViewController = [[RootViewController alloc] init];
    _navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    [rootViewController release];
    [self.window addSubview:_navController.view];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.viewController = [[[SinaWeiboViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:_viewController];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    
    [WXApi registerApp:@"wxb475b17ff5faced6"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self.sinaweibo applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([[url scheme] isEqualToString:@"wxb475b17ff5faced6"])
    {
        return  [WXApi handleOpenURL:url delegate:self];
    }
    else
    {
        return [self.sinaweibo handleOpenURL:url];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[url scheme] isEqualToString:@"wxb475b17ff5faced6"])
    {
        return  [WXApi handleOpenURL:url delegate:self];
    }
    else
    {
        return [self.sinaweibo handleOpenURL:url];
    }
}

@end
