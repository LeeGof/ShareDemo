//
//  NetEaseMicroBlogAsyncApi.h
//  MicroBlogShare
//
//  Created by wuzhikun on 11-4-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MicroBlogCommon.h"
@class MicroBlogOauthKey;

@interface NetEaseMicroBlogAsyncApi : NSObject {
    
}

+ (void)initializeOauthKey:(MicroBlogOauthKey *)oauthKey;
+ (NSURLConnection *)publishMsgWithContent:(NSString *)aContent 
                                 imageFile:(NSString *)aImageFile 
                                resultType:(ResultType)aResultType 
                                  delegate:(id)aDelegate;

+ (NSURLConnection *)GetHomeLineWithResultType:(ResultType)aResultType 
                                      delegate:(id)aDelegate;
/*
+ (NSURLConnection *)getSelfUserInfoWithResultType:(ResultType)aResultType 
                                          delegate:(id)aDelegate;
 */
@end
