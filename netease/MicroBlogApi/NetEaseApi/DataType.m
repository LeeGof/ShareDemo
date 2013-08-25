//
//  DataType.m
//  Demo2
//
//  Created by wuzhikun on 11-4-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DataType.h"


@implementation StatusClass
@synthesize statusId, description;
- (void)dealloc{
    [statusId release];
    [description release];
    [super dealloc];
}
@end
