//
//  WYWeiboViewController.h
//  ShareDemo
//
//  Created by ligf on 13-2-28.
//  Copyright (c) 2013年 ligf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeteaseEngine.h"

@interface WYWeiboViewController : UIViewController<NeteaseEngineDelegate>
{
    NeteaseEngine               *weiboEngine;
    
    UIButton                    *loginButton;
    UIButton                    *logoutButton;
    UIButton                    *postStatusButton;
    UIButton                    *postImageStatusButton;
}

@property (nonatomic, retain) NeteaseEngine   *weiboEngine;

@end
