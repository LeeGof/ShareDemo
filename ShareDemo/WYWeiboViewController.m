//
//  WYWeiboViewController.m
//  ShareDemo
//
//  Created by ligf on 13-2-28.
//  Copyright (c) 2013年 ligf. All rights reserved.
//

#import "WYWeiboViewController.h"

@interface WYWeiboViewController ()

@end

@implementation WYWeiboViewController
@synthesize weiboEngine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NeteaseEngine *engine = [[[NeteaseEngine alloc] initWithAppKey:KEY_NETEASE appSecret:SECRETKEY_NETEASE] autorelease];
    [engine setDelegate:self];
    self.weiboEngine = engine;
    
    self.title = @"网易微博";
    
    loginButton = [self buttonWithFrame:CGRectMake(20, 100, 280, 40) action:@selector(btnClicked:) withTag:1000];
    [loginButton setTitle:@"绑定帐号" forState:UIControlStateNormal];
    
    logoutButton = [self buttonWithFrame:CGRectMake(20, 150, 280, 40) action:@selector(btnClicked:) withTag:1001];
    [logoutButton setTitle:@"取消帐号绑定" forState:UIControlStateNormal];
    
    postStatusButton = [self buttonWithFrame:CGRectMake(20, 200, 280, 40) action:@selector(btnClicked:) withTag:1002];
    [postStatusButton setTitle:@"发表文字微博" forState:UIControlStateNormal];
    
    postImageStatusButton = [self buttonWithFrame:CGRectMake(20, 250, 280, 40) action:@selector(btnClicked:) withTag:1003];
    [postImageStatusButton setTitle:@"发表图片微博" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [weiboEngine release],weiboEngine = nil;
    
    [super dealloc];
}

#pragma mark - NeteaseEngineDelegate

- (void)engineDidLogIn:(NeteaseEngine *)engine
{
    NSLog(@"%@",engine.JSONRepresentation);
}

// Failed to log in.
// Possible reasons are:
// 1) Either username or password is wrong;
// 2) Your app has not been authorized by Sina yet.
- (void)engine:(NeteaseEngine *)engine didFailToLogInWithError:(NSError *)error
{
    
}

//发送微博
- (void)engine:(NeteaseEngine *)engine requestDidFailWithError:(NSError *)error
{
    
}

- (void)engine:(NeteaseEngine *)engine requestDidSucceedWithResult:(id)result
{
    
}

#pragma mark - 自定义方法

- (void)btnClicked:(id)sender
{
    UIButton *btnSender = (UIButton *)sender;
    
    switch (btnSender.tag)
    {
        case 1000:  // 绑定帐号
        {
//            self.weiboEngine.tokenKey = @"b05ca5424cbe366c81cb2ba755b9318b";
//            self.weiboEngine.tokenSecret = @"aeca930e92e97efea3f24302a40bf849";
            [weiboEngine logIn];
            break;
        }
        case 1001:  // 取消帐号绑定
        {
            
            break;
        }
        case 1002:  // 发表文字微博
        {
            [weiboEngine sendWeiBoWithText:@"微博测试" image:[UIImage imageNamed:@"res3.jpg"]];
            break;
        }
        case 1003:  // 发表图片微博
        {
            
            break;
        }
        default:
            break;
    }
}

/*******************************************************************************
 * 方法名称：buttonWithFrame:action:
 * 功能描述：初始化页面按钮，并添加到页面视图
 * 输入参数：
 * 输出参数：
 ******************************************************************************/
- (UIButton *)buttonWithFrame:(CGRect)frame action:(SEL)action withTag:(int)tag
{
    UIImage *buttonBackgroundImage = [[UIImage imageNamed:@"button_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    UIImage *disabledButtonBackgroundImage = [[UIImage imageNamed:@"button_background_disabled.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:disabledButtonBackgroundImage forState:UIControlStateDisabled];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    [self.view addSubview:button];
    
    return button;
}

@end
