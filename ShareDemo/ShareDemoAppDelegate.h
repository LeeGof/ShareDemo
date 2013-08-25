//
//  ShareDemoAppDelegate.h
//  ShareDemo
//
//  Created by ligf on 13-2-21.
//  Copyright (c) 2013年 ligf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@class SinaWeibo;
@class SinaWeiboViewController;
@interface ShareDemoAppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
{
    UINavigationController          *_navController;
    SinaWeibo                       *sinaweibo;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navController;
@property (readonly, nonatomic) SinaWeibo *sinaweibo;
@property (strong, nonatomic) SinaWeiboViewController *viewController;

@end
