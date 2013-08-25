/*******************************************************************************
 * 版权所有 (C)2012用友软件股份有限公司
 *
 * 文件名称： TCWeiboViewController
 * 内容摘要： 腾讯微博使用示例文件。
 * 当前版本： v1.0
 * 作   者： 李高峰
 * 完成日期： 2013年2月21日
 * 说   明：
 
 * 修改日期：
 * 版 本 号：
 * 修 改 人：
 * 修改内容：
 ******************************************************************************/

#import "TCWeiboViewController.h"
#import <CoreText/CoreText.h>
#import "Constants.h"
#import "Toast+UIView.h"

@interface TCWeiboViewController ()

@end

@implementation TCWeiboViewController
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
    TCWBEngine *engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:REDIRECTURI];
    [engine setRootViewController:self];
    self.weiboEngine = engine;
    
    self.title = @"腾讯微博";
    
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

#pragma mark - 绑定帐号的回调事件

//登录成功回调
- (void)onSuccessLogin
{
    [self.view makeToast:@"绑定帐号成功"];
}

//登录失败回调
- (void)onFailureLogin:(NSError *)error
{
    [self.view makeToast:[NSString stringWithFormat:@"绑定帐号失败:%@",[NSNumber numberWithInteger:[error code]]]];
}

#pragma mark - 发表微博的回调事件

- (void)successCallBack:(id)result
{
    [self.view makeToast:@"发表微博成功"];
}

- (void)failureCallBack:(NSError *)error
{
//    NSLog(@"error: %@", error);
    [self.view makeToast:@"发表微博失败"];
}

#pragma mark - 自定义方法

- (void)btnClicked:(id)sender
{
    UIButton *btnSender = (UIButton *)sender;
    
    switch (btnSender.tag)
    {
        case 1000:  // 绑定帐号
        {
            [weiboEngine logInWithDelegate:self
                                 onSuccess:@selector(onSuccessLogin)
                                 onFailure:@selector(onFailureLogin:)];
            break;
        }
        case 1001:  // 取消帐号绑定
        {
            if ([weiboEngine logOut])
            {
                [self.view makeToast:@"登出成功！"];
            }
            else
            {
                [self.view makeToast:@"登出失败！"];
            }
            break;
        }
        case 1002:  // 发表文字微博
        {
            if ([[self.weiboEngine openId] length] > 0)
            {
                //发表一条微博
                [weiboEngine postTextTweetWithFormat:@"json"
                                          content:@"这是文本微博的测试"
                                         clientIP:@"114.66.5.135"
                                        longitude:nil
                                      andLatitude:nil
                                      parReserved:nil
                                         delegate:self
                                        onSuccess:@selector(successCallBack:)
                                        onFailure:@selector(failureCallBack:)];
            }
            else
            {
                [self.view makeToast:@"请先授权！"];
            }
            break;
        }
        case 1003:  // 发表图片微博
        {
            if ([[self.weiboEngine openId] length] > 0)
            {
//                UIImage *img = [UIImage imageNamed:@"test.png"];
                UIImage *img = [UIImage imageWithContentsOfFile:[DOCUMENTS_FOLDER stringByAppendingPathComponent:@"new.png"]];
                NSData *dataImage = UIImageJPEGRepresentation(img, 1.0);
                [weiboEngine postPictureTweetWithFormat:@"json"
                                             content:@"这是图片微博的测试"
                                            clientIP:@"114.66.5.135"
                                                 pic:dataImage
                                      compatibleFlag:@"0"
                                           longitude:nil
                                         andLatitude:nil
                                         parReserved:nil
                                            delegate:self
                                           onSuccess:@selector(successCallBack:)
                                           onFailure:@selector(failureCallBack:)];
            }
            else
            {
                [self.view makeToast:@"请先授权！"];
            }
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
