//
//  NeteaseEngine.h
//  NeteaseTest_001
//
//  Created by 治伟 龙 on 12-3-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBNeteaseAuthorizeWebView.h"
#import "MicroBlogCommon.h"
#import "NetEaseMicroblogSyncApi.h"
#import "NSURL+Additions.h"
#import "SBJsonParser.h"
#import "NetEaseMicroBlogPublishMessage.h"

@class NeteaseEngine;

@protocol NeteaseEngineDelegate <NSObject>

// Log in successfully.
- (void)engineDidLogIn:(NeteaseEngine *)engine;

// Failed to log in.
// Possible reasons are:
// 1) Either username or password is wrong;
// 2) Your app has not been authorized by Sina yet.
- (void)engine:(NeteaseEngine *)engine didFailToLogInWithError:(NSError *)error;


//发送微博
- (void)engine:(NeteaseEngine *)engine requestDidFailWithError:(NSError *)error;
- (void)engine:(NeteaseEngine *)engine requestDidSucceedWithResult:(id)result;




@end


@interface NeteaseEngine : NSObject<WBNeteaseAuthorizeWebViewDelegate>
{
    NSString *appKey;
    NSString *appSecret;
    
    NSString *tokenKey;
    NSString *tokenSecret;
    
    NSString *userID;

    NetEaseMicroBlogPublishMessage *publishMessage;
    WBNeteaseAuthorizeWebView *authorizeWebView;
    id<NeteaseEngineDelegate> delegate;
}

@property (nonatomic, retain) NSString *appKey;
@property (nonatomic, retain) NSString *appSecret;

@property (nonatomic, retain) NSString *tokenKey;
@property (nonatomic, retain) NSString *tokenSecret;

@property (nonatomic, retain) NSString *userID;
@property (nonatomic, assign) id<NeteaseEngineDelegate> delegate;

- (id)initWithAppKey:(NSString *)theAppKey appSecret:(NSString *)theAppSecret;

- (void)logIn;


// Send a Weibo, to which you can attach an image.
- (void)sendWeiBoWithText:(NSString *)text image:(UIImage *)image;


@end
