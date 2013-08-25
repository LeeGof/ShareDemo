//
//  BaseXMLParser.m
//  MicroBlogShare
//
//  Created by wuzhikun on 11-4-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BaseAsyncParser.h"
#define MAX_RETRYTIMES  3

@interface BaseAsyncParser()
@property (nonatomic, retain)NSMutableData *jsonData;

@end

@implementation BaseAsyncParser
@synthesize delegate, isNetWorking, jsonData, connection;

- (id)init{
    self = [super init];
    if (self) {
        isNetWorking = NO;
    }
    return self;
}

- (void)dealloc{
    [connection cancel];
    [connection release];
    [jsonData release];
    [super dealloc];
}

- (void)cancel{
    [self.connection cancel];
    self.connection = nil;
    self.jsonData = nil;
    isNetWorking = NO;
}

- (void)initializeAndGetData{
    retryTime = 0;
    if (isNetWorking) {//避免重复联网
        [self cancel];
    }

}

- (void)getData{
    
}
- (void)downloadDidStart{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES ;
}

- (void)downloadDidFinished{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)notifyDownloadError:(NSError *)error{
    [self performSelectorOnMainThread:@selector(downloadDidFinished) withObject:nil waitUntilDone:YES];
    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(microBlogFinished:withError:)]) {
        [self.delegate microBlogFinished:self withError:error];
    }
}

- (void)notifyDownloadComplete{
    if (self.delegate && [self.delegate respondsToSelector:@selector(microBlogFinished:)]) {
        [self.delegate microBlogFinished:self];
    }
}

#pragma NSURLConnection delegate
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	if (self.jsonData) {
		self.jsonData = nil;
	}
	jsonData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    retryTime ++;
    if (retryTime >= MAX_RETRYTIMES) {
        [self performSelectorOnMainThread:@selector(notifyMainThreadDownloadError:) withObject:error waitUntilDone:NO];
    }else{
        [self getData];
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [jsonData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    isNetWorking = NO;
#if 0
    NSString *string = [NSString stringWithUTF8String:[jsonData bytes]];
    NSLog(@"%@", string);
#endif
	
    [self decodeData];
    
	[jsonData release];
	jsonData = nil;
	self.connection = nil;
	[self performSelectorOnMainThread:@selector(downloadDidFinished) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(notifyDownloadComplete) withObject:nil waitUntilDone:YES];
}

- (void)decodeData{
    
}
@end

































































