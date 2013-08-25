//
//  NetEaseMicroBlogPublishMessage.m
//  MicroBlogShare
//
//  Created by wuzhikun on 11-4-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NetEaseMicroBlogPublishMessage.h"
#import "NetEaseMicroBlogAsyncApi.h"

@implementation NetEaseMicroBlogPublishMessage
@synthesize statusId, content;

- (void)dealloc{
    [content release];
    [statusId release];
    [super dealloc];
}

- (void)publishMessage:(NSString *)msg aDelegate:(id)aDelegate
{
    [super initializeAndGetData];
    self.statusId = nil;
    self.content = msg;
    self.delegate = aDelegate;
    [self getData];
}

- (void)getData{
    self.connection = [NetEaseMicroBlogAsyncApi publishMsgWithContent:self.content 
                                                            imageFile:nil 
                                                           resultType:RESULTTYPE_JSON 
                                                             delegate:self];
}

- (void)decodeData{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSString *jsonString = [NSString stringWithUTF8String:[jsonData bytes]];
    NSLog(@"String:%@", jsonString);
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    id jsonObject = [parser objectWithString:jsonString];
    self.statusId = (NSString *)[jsonObject objectForKey:@"id"];
    NSLog(@"%@", statusId);
    [parser release];
    [pool release];
}
@end

































