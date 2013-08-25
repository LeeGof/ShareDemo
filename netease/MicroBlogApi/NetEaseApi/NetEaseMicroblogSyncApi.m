//
//  NetEaseMicroblogSyncApi.m
//  MicroBlogShare
//
//  Created by wuzhikun on 11-4-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NetEaseMicroblogSyncApi.h"
#import "MicroBlogOauthKey.h"
#import "MicroBlogRequest.h"


@implementation NetEaseMicroblogSyncApi
+ (NSString *)getRequestTokenWithConsumerKey:(NSString *)aConsumerKey 
							  consumerSecret:(NSString *)aConsumerSecret {
	
	NSString *url = @"http://api.t.163.com/oauth/request_token";//for example
	
	MicroBlogOauthKey *oauthKey = [[MicroBlogOauthKey alloc] init];
	oauthKey.consumerKey = aConsumerKey;
	oauthKey.consumerSecret = aConsumerSecret;
	oauthKey.callbackUrl = @"http://m.ifeng.com";//for example
	
	
	MicroBlogRequest *request = [[MicroBlogRequest alloc] init];
	NSString *retString = [request syncRequestWithUrl:url httpMethod:@"GET" oauthKey:oauthKey parameters:nil files:nil];
	
	[request release];
	[oauthKey release];
	return retString;
}

+ (NSString *)getAccessTokenWithConsumerKey:(NSString *)aConsumerKey 
							 consumerSecret:(NSString *)aConsumerSecret 
							requestTokenKey:(NSString *)aRequestTokenKey
						 requestTokenSecret:(NSString *)aRequestTokenSecret 
									 verify:(NSString *)aVerify {
	
	NSString *url = @"http://api.t.163.com/oauth/access_token";
	
	MicroBlogOauthKey *oauthKey = [[MicroBlogOauthKey alloc] init];
	oauthKey.consumerKey = aConsumerKey;
	oauthKey.consumerSecret = aConsumerSecret;
	oauthKey.tokenKey = aRequestTokenKey;
	oauthKey.tokenSecret= aRequestTokenSecret;
	oauthKey.verify = aVerify;
	
	MicroBlogRequest *request = [[MicroBlogRequest alloc] init];
	NSString *retString = [request syncRequestWithUrl:url httpMethod:@"GET" oauthKey:oauthKey parameters:nil files:nil];
	
	[request release];
	[oauthKey release];
	return retString;
}

+ (NSString*)getRequestUserInfoWithConsumerKey:(NSString *)aConsumerKey 
                                consumerSecret:(NSString *)aConsumerSecret
{
    NSString *url = @"http://api.t.163.com/account/verify_credentials.json";//
    
    MicroBlogOauthKey *oauthKey = [[MicroBlogOauthKey alloc] init];
    oauthKey.consumerKey = aConsumerKey;
    oauthKey.consumerSecret = aConsumerSecret;
    
    MicroBlogRequest *request = [[MicroBlogRequest alloc] init];
    NSString *retString = [request syncRequestWithUrl:url httpMethod:@"GET" oauthKey:oauthKey parameters:nil files:nil];
    [request release];
    [oauthKey release];
    
    return retString;
}


+ (NSString*)getRequestSendWeiboWithConsumerKey:(NSString *)aConsumerKey 
                                 consumerSecret:(NSString *)aConsumerSecret 
                                       sendInfo:(NSString*)weiboInfo 
                                        sendPic:(UIImage*)aPic
{
    NSString *picUrl = nil;
    if (aPic) {
        NSString *url = @"http://api.t.163.com/statuses/upload.json";
        MicroBlogOauthKey *oauthKey = [[MicroBlogOauthKey alloc] init];
        oauthKey.consumerKey = aConsumerKey;
        oauthKey.consumerSecret = aConsumerSecret;
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:UIImagePNGRepresentation(aPic) forKey:@"pic"];
        
        MicroBlogRequest *request = [[MicroBlogRequest alloc] init];
        NSString *retString = [request syncRequestWithUrl:url httpMethod:@"POST" oauthKey:oauthKey parameters:parameters files:nil];
        [request release];
        [oauthKey release];
        picUrl = [(NSDictionary *)retString objectForKey:@"upload_image_url"];
        
    }
    NSString *url = @"http://api.t.163.com/statuses/update.json";//
    
    MicroBlogOauthKey *oauthKey = [[MicroBlogOauthKey alloc] init];
    oauthKey.consumerKey = aConsumerKey;
    oauthKey.consumerSecret = aConsumerSecret;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[weiboInfo stringByAppendingFormat:@"  %@",picUrl] forKey:@"status"];
    
    MicroBlogRequest *request = [[MicroBlogRequest alloc] init];
    NSString *retString = [request syncRequestWithUrl:url httpMethod:@"POST" oauthKey:oauthKey parameters:parameters files:nil];
    [request release];
    [oauthKey release];
    
    return retString;
}

@end
