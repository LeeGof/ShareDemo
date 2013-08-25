//
//  WeiXinViewController.m
//  ShareDemo
//
//  Created by ligf on 13-2-26.
//  Copyright (c) 2013年 ligf. All rights reserved.
//

#import "WeiXinViewController.h"
#import "Constants.h"

@interface WeiXinViewController ()

@end

@implementation WeiXinViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"分享到微信";
    
    shareToWXFriendButton = [self buttonWithFrame:CGRectMake(20, 100, 280, 40) action:@selector(btnClicked:) withTag:1000];
    [shareToWXFriendButton setTitle:@"分享给微信好友" forState:UIControlStateNormal];
    
    shareToFriendsButton = [self buttonWithFrame:CGRectMake(20, 150, 280, 40) action:@selector(btnClicked:) withTag:1001];
    [shareToFriendsButton setTitle:@"分享到朋友圈" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

/*******************************************************************************
 * 方法名称：onReq:
 * 功能描述：收到一个来自微信的请求，处理完后调用sendResp
        收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * 输入参数：
    req:具体请求内容，是自动释放的
 * 输出参数：
 ******************************************************************************/
- (void)onReq:(BaseReq *)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        
    }
    
}

/*******************************************************************************
 * 方法名称：onResp:
 * 功能描述：发送一个sendReq后，收到微信的回应
        收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * 输入参数：
    resp:具体的回应内容，是自动释放的
 * 输出参数：
 ******************************************************************************/
- (void)onResp:(BaseResp *)resp
{
    //可以省略
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        
    }
    else if([resp isKindOfClass:[SendAuthResp class]])
    {
        
    }
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2)
    {
        NSString *weiXinLink = @"itms-apps://itunes.apple.com/cn/app/wei-xin/id414478124?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weiXinLink]];
    }
}

#pragma mark - 自定义方法

- (void)btnClicked:(id)sender
{
    UIButton *btnSender = (UIButton *)sender;
    
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi])
    {
        switch (btnSender.tag)
        {
            case 1000:  // 分享给微信好友
            {
                WXMediaMessage *message = [WXMediaMessage message];
                [message setThumbImage:[UIImage imageNamed:@"compose#.png"]];
//                UIImage *image = [UIImage imageWithContentsOfFile:[DOCUMENTS_FOLDER stringByAppendingPathComponent:@"new.png"]];
//                [message setThumbImage:image];
                WXImageObject *ext = [WXImageObject object];
//                NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"png"];
//                ext.imageData = [NSData dataWithContentsOfFile:filePath] ;
                ext.imageData = [NSData dataWithContentsOfFile:[DOCUMENTS_FOLDER stringByAppendingPathComponent:@"new.png"]];
                message.mediaObject = ext;
                
                SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
                req.bText = NO;
//                req.text = @"步步惊奇";  //发表文件信息时使用，并且bText设置为yes
                req.message = message;
                req.scene = WXSceneSession;  // 默认值为WXSceneSession，分享给微信好友;WXSceneTimeline,分享到朋友圈
                [WXApi sendReq:req];
                break;
            }
            case 1001:  // 分享到朋友圈
            {
                WXMediaMessage *message = [WXMediaMessage message];
                message.title = @"今天天气不错";
//                message.description = @"昨天下雪了，园区景色很好";
//                [message setThumbImage:[UIImage imageNamed:@"res3.jpg"]];
                [message setThumbImage:[UIImage imageNamed:@"compose#.png"]];
//                [message setThumbImage:[UIImage imageWithContentsOfFile:[DOCUMENTS_FOLDER stringByAppendingPathComponent:@"new.png"]]];
                WXImageObject *ext = [WXImageObject object];
//                NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res3" ofType:@"jpg"];
//                ext.imageData = [NSData dataWithContentsOfFile:filePath] ;
                ext.imageData = [NSData dataWithContentsOfFile:[DOCUMENTS_FOLDER stringByAppendingPathComponent:@"new.png"]];
                message.mediaObject = ext;
                
                SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
                req.bText = NO;
                req.message = message;
                req.scene = WXSceneTimeline;  // 默认值为WXSceneSession，分享给微信好友;WXSceneTimeline,分享到朋友圈
                [WXApi sendReq:req];
                break;
            }
            default:
                break;
        }
    }
    else
    {
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"你的iPhone上还没有安装微信,无法使用此功能，使用微信可以方便的把你喜欢的作品分享给好友。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
        [alView show];
        [alView release];
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
