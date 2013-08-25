//
//  DataType.h
//  Demo2
//
//  Created by wuzhikun on 11-4-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StatusClass : NSObject {
    NSString *statusId;
    NSString *description;
}
@property (nonatomic, retain) NSString *statusId;
@property (nonatomic, retain) NSString *description;


@end
