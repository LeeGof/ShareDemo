//
//  NetEaseMicroBlogAsyncApi.m
//  MicroBlogShare
//
//  Created by wuzhikun on 11-4-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NetEaseMicroBlogAsyncApi.h"
#import "MicroBlogOauthKey.h"
#import "MicroBlogRequest.h"

@implementation NetEaseMicroBlogAsyncApi

+ (void)initializeOauthKey:(MicroBlogOauthKey *)oauthKey
{
    NSDictionary *info = [MicroBlogCommon getBlogInfo:MicroBlog_NetEase];
	oauthKey.consumerKey = KEY_NETEASE;
	oauthKey.consumerSecret = SECRETKEY_NETEASE;
	oauthKey.tokenKey = [info objectForKey:@"oauth_token"];
	oauthKey.tokenSecret= [info objectForKey:@"oauth_token_secret"];
}

+ (NSURLConnection *)publishMsgWithContent:(NSString *)aContent 
                                 imageFile:(NSString *)aImageFile 
                                resultType:(ResultType)aResultType 
                                  delegate:(id)aDelegate
{
	NSMutableDictionary *files = [NSMutableDictionary dictionary];
	NSString *url;
	if (aResultType == RESULTTYPE_XML) {
        url = @"http://api.t.163.com/statuses/update.xml";
    }else{
        url = @"http://api.t.163.com/statuses/update.json";
    }
	
	MicroBlogOauthKey *oauthKey = [[MicroBlogOauthKey alloc] init];
	[NetEaseMicroBlogAsyncApi initializeOauthKey:oauthKey];
	
	
	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
	[parameters setObject:aContent forKey:@"status"];
	
	
	MicroBlogRequest *request = [[MicroBlogRequest alloc] init];
	NSURLConnection *connection = [request asyncRequestWithUrl:url httpMethod:@"POST" oauthKey:oauthKey parameters:parameters files:files delegate:aDelegate];
	
	[request release];
	[oauthKey release];
	return connection;
}

+ (NSURLConnection *)GetHomeLineWithResultType:(ResultType)aResultType 
                                      delegate:(id)aDelegate
{
	NSString *url;
	if (aResultType == RESULTTYPE_XML) {
        url = @"http://api.t.163.com/statuses/home_timeline.xml";
    }else{
        url = @"http://api.t.163.com/statuses/home_timeline.json";
    }
	
	MicroBlogOauthKey *oauthKey = [[MicroBlogOauthKey alloc] init];
    [NetEaseMicroBlogAsyncApi initializeOauthKey:oauthKey];	
	
	
	MicroBlogRequest *request = [[MicroBlogRequest alloc] init];
	NSURLConnection *connection = [request asyncRequestWithUrl:url 
                                                    httpMethod:@"GET" 
                                                      oauthKey:oauthKey 
                                                    parameters:nil 
                                                         files:nil 
                                                      delegate:aDelegate];
	
	[request release];
	[oauthKey release];
	return connection;    
}
@end










































