//
//  NetEaseMicroBlogPublishMessage.h
//  MicroBlogShare
//
//  Created by wuzhikun on 11-4-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAsyncParser.h"

@interface NetEaseMicroBlogPublishMessage : BaseAsyncParser {
    NSString *statusId;
    NSString *content;
}
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *statusId;

- (void)publishMessage:(NSString *)msg aDelegate:(id)aDelegate;

@end
