//
//  MicroBlogOauthKey.h
//  NetEaseMicroBlog
//
//  Created by wuzhikun on 11-4-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MicroBlogOauthKey : NSObject {
	NSString *consumerKey;
	NSString *consumerSecret;
	NSString *tokenKey;
	NSString *tokenSecret;
	NSString *verify;
	NSString *callbackUrl;
}
@property (nonatomic, copy) NSString *consumerKey;
@property (nonatomic, copy) NSString *consumerSecret;
@property (nonatomic, copy) NSString *tokenKey;
@property (nonatomic, copy) NSString *tokenSecret;
@property (nonatomic, copy) NSString *verify;
@property (nonatomic, copy) NSString *callbackUrl;

@end
