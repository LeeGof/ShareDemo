//
//  WeiXinViewController.h
//  ShareDemo
//
//  Created by ligf on 13-2-26.
//  Copyright (c) 2013年 ligf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApiObject.h"
#import "WXApi.h"

@interface WeiXinViewController : UIViewController<WXApiDelegate>
{
    UIButton                    *shareToWXFriendButton;
    UIButton                    *shareToFriendsButton;
}

@end
