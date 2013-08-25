//
//  MicroBlogMutableURLRequest.h
//  NetEaseMicroBlog
//
//  Created by wuzhikun on 11-4-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MicroBlogMutableURLRequest : NSObject {
    
}
//Return a request for http get method
+ (NSMutableURLRequest *)requestGet:(NSString *)aUrl queryString:(NSString *)aQueryString;

//Return a request for http post method
+ (NSMutableURLRequest *)requestPost:(NSString *)aUrl queryString:(NSString *)aQueryString;

//Return a request for http post with multi-part method
+ (NSMutableURLRequest *)requestPostWithFile:(NSDictionary *)files url:(NSString *)aUrl queryString:(NSString *)aQueryString;

+ (NSMutableURLRequest *)phoenixRequestPost:(NSString *)aUrl queryString:(NSString *)aQueryString;

@end
