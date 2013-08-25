//
//  NeteaseEngine.m
//  NeteaseTest_001
//
//  Created by 治伟 龙 on 12-3-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NeteaseEngine.h"

@interface NeteaseEngine(Private)

- (void)userAuthorize;

@end


@implementation NeteaseEngine
@synthesize appKey;
@synthesize appSecret;
@synthesize tokenKey;
@synthesize tokenSecret;
@synthesize userID;
@synthesize delegate;

- (id)initWithAppKey:(NSString *)theAppKey appSecret:(NSString *)theAppSecret
{
    self = [super init];
    if (self) {
        self.appKey = theAppKey;
        self.appSecret = theAppSecret;
        
        NSString *retString = [NetEaseMicroblogSyncApi getRequestTokenWithConsumerKey:self.appKey consumerSecret:self.appSecret];
        NSDictionary *params = [NSURL parseURLQueryString:retString];
        self.tokenKey = [params objectForKey:@"oauth_token"];
        self.tokenSecret = [params objectForKey:@"oauth_token_secret"];
        
    }
    return self;
}

- (void)dealloc
{
    [appKey release];
    [appSecret release];
    [tokenKey release];
    [tokenSecret release];
    [userID release];
    [authorizeWebView release];
    [publishMessage release];
    [super dealloc];
}

- (void)logIn
{
    if ([MicroBlogCommon checkHasBindingById:MicroBlog_NetEase])
    {//已绑定用户
        
        NSDictionary *dictionary = [MicroBlogCommon getBlogInfo:MicroBlog_NetEase];
        if (dictionary) {
            self.userID = [dictionary objectForKey:@"screen_name"];
        }
        if (delegate && [delegate respondsToSelector:@selector(engineDidLogIn:)]) {
            
            [(NSObject*)delegate performSelector:@selector(engineDidLogIn:) withObject:self afterDelay:0.0f];
        }
        
        
    }
    else
    {
        NSString *url = [NSString stringWithFormat:@"%@%@", VERIFY_URL_NETEASE, self.tokenKey];
        authorizeWebView = [[WBNeteaseAuthorizeWebView alloc] init];
        [authorizeWebView setDelegate:self];
        [authorizeWebView loadRequestWithURL:[NSURL URLWithString:url]];
        [authorizeWebView show:YES];
    }
}


// Send a Weibo, to which you can attach an image.
- (void)sendWeiBoWithText:(NSString *)text image:(UIImage *)image
{
    if (!publishMessage)
    {
        publishMessage = [[NetEaseMicroBlogPublishMessage alloc] init];
    }
    [publishMessage publishMessage:text aDelegate:self];
}

- (void)userAuthorize
{
    UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"请输入授权码:" 
                                                     message:@"\n\n" 
                                                    delegate:self 
                                           cancelButtonTitle:@"取消授权" 
                                           otherButtonTitles:@"确定", nil];
    
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(27.0, 60.0, 230.0, 25.0)]; 
    textField.tag = 100;
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField setPlaceholder:@"授权码"];
    [prompt addSubview:textField];
    [textField release];
    [prompt show];
    [prompt release];
}

- (void)microBlogFinished:(BaseAsyncParser*)parser
{
    if (delegate && [delegate respondsToSelector:@selector(engine:requestDidSucceedWithResult:)]) {
        [delegate engine:self requestDidSucceedWithResult:publishMessage];
    }
}

- (void)microBlogFinished:(BaseAsyncParser *)parser withError:(NSError*)error
{
    if (delegate && [delegate respondsToSelector:@selector(engine:requestDidFailWithError:)])
    {
        [delegate engine:self requestDidFailWithError:error];
    }
}


- (void)authorizeWebView:(WBNeteaseAuthorizeWebView *)webView didReceiveAuthorizeCode:(NSString *)code
{
    [self performSelectorOnMainThread:@selector(userAuthorize) withObject:nil waitUntilDone:NO];
}


- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != -1)
    {
        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
        if ([title isEqualToString:@"取消授权"])
        {

            [authorizeWebView hide:YES];
            if (delegate && [delegate respondsToSelector:@selector(engine:didFailToLogInWithError:)])
            {
                [delegate engine:self didFailToLogInWithError:nil];
            }
            
        }
        else if ([title isEqualToString:@"确定"])
        {
            NSString *verifier = [NSString stringWithString:[(UITextField*)[alertView viewWithTag:100] text]];
            NSString *retString = [NetEaseMicroblogSyncApi getAccessTokenWithConsumerKey:KEY_NETEASE 
                                                                          consumerSecret:SECRETKEY_NETEASE 
                                                                         requestTokenKey:tokenKey 
                                                                      requestTokenSecret:tokenSecret 
                                                                                  verify:verifier];
            NSDictionary *params = [NSURL parseURLQueryString:retString];
            
            if ([params valueForKey:@"oauth_token"] != nil)
            {
                //关闭授权UI
                [authorizeWebView hide:YES];
                
                self.tokenKey = [params valueForKey:@"oauth_token"];
                self.tokenSecret = [params valueForKey:@"oauth_token_secret"];
                
                //获取用户信息
                retString = [NetEaseMicroblogSyncApi getRequestUserInfoWithConsumerKey:self.tokenKey consumerSecret:self.tokenSecret];
                
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                id jsonObject = [parser objectWithString:retString];
                [parser release];
                NSDictionary *dictionary = (NSDictionary*)jsonObject;
                if (dictionary) {
                    //存储用户ID
                    self.userID = [dictionary objectForKey:@"screen_name"];
                    
                }
                //将用户ID存储到本地
                NSMutableDictionary *saveDict = [NSMutableDictionary dictionary];
                [saveDict setObject:self.userID forKey:@"screen_name"];
                [saveDict setObject:self.tokenKey forKey:@"oauth_token"];
                [saveDict setObject:self.tokenSecret forKey:@"oauth_token_secret"];
                [MicroBlogCommon saveMicroBlogInfo:saveDict blogId:MicroBlog_NetEase];
                
                if (delegate && [delegate respondsToSelector:@selector(engineDidLogIn:)]) {
                    
                    [delegate engineDidLogIn:self];
                }
                
                
            }
            else
            {
                [authorizeWebView hide:YES];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"授权失败，请稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                [alert release];
                if (delegate && [delegate respondsToSelector:@selector(engine:didFailToLogInWithError:)])
                {
                    [delegate engine:self didFailToLogInWithError:nil];
                }
            }
        }
    }
    
}


@end
