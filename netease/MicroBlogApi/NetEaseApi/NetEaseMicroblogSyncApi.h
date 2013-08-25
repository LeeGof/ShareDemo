//
//  NetEaseMicroblogSyncApi.h
//  MicroBlogShare
//
//  Created by wuzhikun on 11-4-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NetEaseMicroblogSyncApi : NSObject
{
    
}

+ (NSString *)getRequestTokenWithConsumerKey:(NSString *)aConsumerKey 
							  consumerSecret:(NSString *)aConsumerSecret;

//Get access token
+ (NSString *)getAccessTokenWithConsumerKey:(NSString *)aConsumerKey 
							 consumerSecret:(NSString *)aConsumerSecret 
							requestTokenKey:(NSString *)aRequestTokenKey
						 requestTokenSecret:(NSString *)aRequestTokenSecret 
									 verify:(NSString *)aVerify;


+ (NSString*)getRequestUserInfoWithConsumerKey:(NSString *)aConsumerKey 
                                consumerSecret:(NSString *)aConsumerSecret;

+ (NSString*)getRequestSendWeiboWithConsumerKey:(NSString *)aConsumerKey 
                                 consumerSecret:(NSString *)aConsumerSecret 
                                       sendInfo:(NSString*)weiboInfo 
                                        sendPic:(UIImage*)aPic;

@end
