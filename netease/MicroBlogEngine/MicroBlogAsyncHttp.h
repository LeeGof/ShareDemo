//
//  MicroBlogAsyncHttp.h
//  NetEaseMicroBlog
//
//  Created by wuzhikun on 11-4-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MicroBlogAsyncHttp : NSObject {
    
}
//Start a connection fro http get method and return it to delegate.
- (NSURLConnection *)httpGet:(NSString *)aUrl queryString:(NSString *)aQueryString delegate:(id)aDelegare;

//Start a connection fro http post method and return it to delegate.
- (NSURLConnection *)httpPost:(NSString *)aUrl queryString:(NSString *)aQueryString delegate:(id)aDelegare;

//Start a connection fro http multi-part method and return it to delegate.
- (NSURLConnection *)httpPostWithFile:(NSDictionary *)files url:(NSString *)aUrl queryString:(NSString *)aQueryString delegate:(id)aDelegare;

@end
