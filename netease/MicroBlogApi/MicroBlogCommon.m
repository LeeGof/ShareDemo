//
//  MicroBlogCommon.m
//  MicroBlogShare
//
//  Created by wuzhikun on 11-4-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MicroBlogCommon.h"

@interface MicroBlogCommon()
+ (NSDictionary*)getStaticDictionaryById:(NSUInteger)blogId;    
@end


#define FileName_NetEase @"netEaseUser"
static NSDictionary* staticNetEaseInfo;

@implementation MicroBlogCommon

+ (void)saveMicroBlogInfo:(NSDictionary *)parars blogId:(NSUInteger)blogid
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	switch (blogid) {
        case MicroBlog_NetEase:
        {
            NSString *infoFile = [[paths objectAtIndex:0] stringByAppendingPathComponent:FileName_NetEase];
			[parars writeToFile:infoFile atomically:YES];
        }
            break;
		default:
			break;
	}
}

+ (void)deleteMicroBlogInfo:(NSUInteger)blogid
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *infoFile;
	switch (blogid) {
        case MicroBlog_NetEase:
        {
            infoFile = [[paths objectAtIndex:0] stringByAppendingPathComponent:FileName_NetEase];
        }
            break;
		default:
			break;
	}
    [[NSFileManager defaultManager] removeItemAtPath:infoFile error:nil];
}
+ (NSDictionary*)getStaticDictionaryById:(NSUInteger)blogId
{
    switch (blogId) {
        case MicroBlog_NetEase:
            return staticNetEaseInfo;
            break;
        default:
            break;
    }
    return nil;
}

+ (BOOL)checkHasBindingById:(NSUInteger)blogId
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *infoFile;
    switch (blogId) {
        case MicroBlog_NetEase:
            infoFile = [[paths objectAtIndex:0] stringByAppendingPathComponent:FileName_NetEase];
            break;
        default:
            break;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:infoFile] == NO) {
        return NO;
    }
    return YES;
}

+ (NSDictionary*)getBlogInfo:(NSInteger)blogId
{
    NSDictionary *dict = [MicroBlogCommon getStaticDictionaryById:blogId];
    if (dict != nil) {
        return dict;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *infoFile;
    switch (blogId) {
        case MicroBlog_NetEase:
            infoFile = [[paths objectAtIndex:0] stringByAppendingPathComponent:FileName_NetEase];
            break;
        default:
            break;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:infoFile] == NO) {
        return nil;
    }
    dict = [NSDictionary dictionaryWithContentsOfFile:infoFile];
    return dict;
}

@end





















