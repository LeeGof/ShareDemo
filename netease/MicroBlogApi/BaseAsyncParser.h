//
//  BaseXMLParser.h
//  MicroBlogShare
//
//  Created by wuzhikun on 11-4-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MicroBlogCommon.h"
#import "JSON.h"

@interface BaseAsyncParser : NSObject 
{
    id <MicroBlogDelegate> delegate;
    BOOL isNetWorking;
    NSURLConnection *connection;
    NSUInteger retryTime;
    NSMutableData *jsonData;
    
}
@property (nonatomic, assign) id<MicroBlogDelegate>delegate;
@property (nonatomic, readonly, assign) BOOL isNetWorking;
@property (nonatomic, retain)NSURLConnection *connection;

- (void)initializeAndGetData;
- (void)getData;
- (void)decodeData;
@end
