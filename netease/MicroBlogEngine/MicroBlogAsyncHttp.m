//
//  MicroBlogAsyncHttp.m
//  NetEaseMicroBlog
//
//  Created by wuzhikun on 11-4-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MicroBlogAsyncHttp.h"
#import "MicroBlogMutableURLRequest.h"

@implementation MicroBlogAsyncHttp
- (NSURLConnection *)httpGet:(NSString *)aUrl queryString:(NSString *)aQueryString delegate:(id)aDelegare {
	
	NSMutableURLRequest *request = [MicroBlogMutableURLRequest requestGet:aUrl queryString:aQueryString];
	return [NSURLConnection connectionWithRequest:request delegate:aDelegare]; 
	
}

- (NSURLConnection *)httpPost:(NSString *)aUrl queryString:(NSString *)aQueryString delegate:(id)aDelegare {
	
	NSMutableURLRequest *request = [MicroBlogMutableURLRequest requestPost:aUrl queryString:aQueryString];
	return [NSURLConnection connectionWithRequest:request delegate:aDelegare];
}

- (NSURLConnection *)httpPostWithFile:(NSDictionary *)files url:(NSString *)aUrl queryString:(NSString *)aQueryString delegate:(id)aDelegare {
	
	NSMutableURLRequest *request = [MicroBlogMutableURLRequest requestPostWithFile:files url:aUrl queryString:aQueryString];
	return [NSURLConnection connectionWithRequest:request delegate:aDelegare];
}

@end
