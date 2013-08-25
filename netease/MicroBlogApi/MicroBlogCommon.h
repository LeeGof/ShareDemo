//
//  MicroBlogCommon.h
//  MicroBlogShare
//
//  Created by wuzhikun on 11-4-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _ResultType {
	
	RESULTTYPE_XML, RESULTTYPE_JSON
	
}ResultType;

typedef enum _PageFlag {
	
	PAGEFLAG_FIRST, 
	PAGEFLAG_NEXT, 
	PAGEFLAG_LAST
	
}PageFlag;

enum{
    MicroBlog_NetEase,
    MicroBlog_Max
};

#define VERIFY_URL_NETEASE  @"http://api.t.163.com/oauth/authorize?oauth_token="

#define KEY_NETEASE @"ieeahv7i6fJmvoz5"
#define SECRETKEY_NETEASE  @"7OIQH3PDeMZkfKgVJp8sl7uQdrMzfjbM"

@class BaseAsyncParser;
@protocol MicroBlogDelegate <NSObject>
@optional
- (void)microBlogFinished:(BaseAsyncParser*)parser;
- (void)microBlogFinished:(BaseAsyncParser *)parser withError:(NSError*)error;
@end



@interface MicroBlogCommon : NSObject
{
    
}

+ (void)saveMicroBlogInfo:(NSDictionary *)parars blogId:(NSUInteger)blogid;
+ (void)deleteMicroBlogInfo:(NSUInteger)blogid;
+ (BOOL)checkHasBindingById:(NSUInteger)blogId;
+ (NSDictionary*)getBlogInfo:(NSInteger)blogId;
@end























