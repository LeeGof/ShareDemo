/*******************************************************************************
 * 版权所有 (C)2012用友软件股份有限公司
 *
 * 文件名称： SinaWeiboViewController
 * 内容摘要： 新浪微博使用示例文件。
 * 当前版本： v1.0
 * 作   者： 李高峰
 * 完成日期： 2013年2月21日
 * 说   明：
 
 * 修改日期：
 * 版 本 号：
 * 修 改 人：
 * 修改内容：
 ******************************************************************************/

#import "SinaWeiboViewController.h"
#import "Constants.h"
#import "ShareDemoAppDelegate.h"
#import "Toast+UIView.h"

@interface SinaWeiboViewController ()

@end

@implementation SinaWeiboViewController

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
    
    self.title = @"新浪微博";
    
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
    [userInfo release], userInfo = nil;
    [statuses release], statuses = nil;
    [postStatusText release], postStatusText = nil;
    [postImageStatusText release], postImageStatusText = nil;
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - SinaWeiboDelegate

/*******************************************************************************
 * 方法名称：sinaweiboDidLogIn:
 * 功能描述：SinaWeibo对象登录操作完成后，调用此方法。
 * 输入参数：
 * 输出参数：sinaweibo：应用可在方法中通过此对象判断登录结果，以进行不同的处理
 ******************************************************************************/
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
//    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [self storeAuthData];
    
    [self.view makeToast:@"绑定成功"];
}

/*******************************************************************************
 * 方法名称：sinaweiboDidLogOut:
 * 功能描述：SinaWeibo对象登出操作完成后，调用此方法。
 * 输入参数：
 * 输出参数：sinaweibo：应用可在方法中通过此对象判断登出结果，以进行不同的处理
 ******************************************************************************/
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    [self removeAuthData];
    
    [self.view makeToast:@"取消绑定成功"];
}

/*******************************************************************************
 * 方法名称：sinaweiboLogInDidCancel:
 * 功能描述：取消登录操作，用户在sso登录过程中将应用重新唤醒到前台后，应调用[SinaWeibo applicationDidBecomeActive]方法，此方法将取消当前登录，并回调sinaweiboLogInDidCancel。
 * 输入参数：
 * 输出参数：sinaweibo
 ******************************************************************************/
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

/*******************************************************************************
 * 方法名称：sinaweibo:logInDidFailWithError:
 * 功能描述：登录失败后，将错误信息回调给此方法。
 * 输入参数：
 * 输出参数：
 ******************************************************************************/
- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

/*******************************************************************************
 * 方法名称：sinaweibo:accessTokenInvalidOrExpired:
 * 功能描述：操作过程中出错时sinaweibo对象将调用此方法，如accessToken无效或者过期。用户接收到此错误信息后应重新登录。
 * 输入参数：
 * 输出参数：
 ******************************************************************************/
- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self removeAuthData];
}

#pragma mark - SinaWeiboRequestDelegate

/*******************************************************************************
 * 方法名称：request:didFailWithError:
 * 功能描述：请求失败时回调此方法。
 * 输入参数：
    request：SDK中具体用来实现请求的类，应用可根据request.url来判断具体哪个请求失败
    error：失败信息
 * 输出参数：
 ******************************************************************************/
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"Request Error");
    if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" failed!", postStatusText]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        NSLog(@"Post status failed with error : %@", error);
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" failed!", postImageStatusText]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        NSLog(@"Post image status failed with error : %@", error);
    }
    
//    [self resetButtons];
}

/*******************************************************************************
 * 方法名称：request:didFinishLoadingWithResult:
 * 功能描述：请求完成后回调此方法。
 * 输入参数：
    request：SDK中具体用来实现请求的类，应用可根据request.url来判断具体哪个请求失败
    result：返回的结果，一般为请求的内容
 * 输出参数：
 ******************************************************************************/
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"Request Success");
    if ([request.url hasSuffix:@"statuses/update.json"])  // 文字微博
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        [postStatusText release], postStatusText = nil;
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])  // 图片微博
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        [postImageStatusText release], postImageStatusText = nil;
    }
    
//    [self resetButtons];
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        if (alertView.tag == 0)  //  发送文字微博
        {
            SinaWeibo *sinaweibo = [self sinaweibo];
            [sinaweibo requestWithURL:@"statuses/update.json"
                               params:[NSMutableDictionary dictionaryWithObjectsAndKeys:postStatusText, @"status", nil]
                           httpMethod:@"POST"
                             delegate:self];
            
        }
        else if (alertView.tag == 1)  // 发送图片微博
        {
            SinaWeibo *sinaweibo = [self sinaweibo];
            UIImage *image = [UIImage imageWithContentsOfFile:[DOCUMENTS_FOLDER stringByAppendingPathComponent:@"new.png"]];
            [sinaweibo requestWithURL:@"statuses/upload.json"
                               params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"图片微博", @"status",
                                       image, @"pic", nil]
                           httpMethod:@"POST"
                             delegate:self];
//            [sinaweibo requestWithURL:@"statuses/upload.json"
//                               params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                       @"图片微博", @"status",
//                                       [UIImage imageNamed:@"logo.png"], @"pic", nil]
//                           httpMethod:@"POST"
//                             delegate:self];
            
        }
    }
}

#pragma mark - 自定义方法

- (void)btnClicked:(id)sender
{
    UIButton *btnSender = (UIButton *)sender;
    
    switch (btnSender.tag)
    {
        case 1000:
        {
            if ([self isBindCount])
            {
                [self.view makeToast:@"已经绑定帐号，不需要重新绑定"];
            }
            else
            {
                [userInfo release], userInfo = nil;
                [statuses release], statuses = nil;
                
                SinaWeibo *sinaweibo = [self sinaweibo];
                [sinaweibo logIn];
            }
            
            break;
        }
        case 1001:
        {
            if ([self isBindCount])
            {
                SinaWeibo *sinaweibo = [self sinaweibo];
                [sinaweibo logOut];
            }
            else
            {
                [self.view makeToast:@"没有绑定帐号"];
            }
            
            break;
        }
        case 1002:
        {
            if (!postStatusText)
            {
                [postStatusText release], postStatusText = nil;
                postStatusText = [[NSString alloc] initWithFormat:@"文字微博测试:%@", [NSDate date]];
            }
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                message:postStatusText
                                                               delegate:self cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"OK", nil];
            postStatusText = @"文字微博测试";
            alertView.tag = 0;
            [alertView show];
            [alertView release];
            break;
        }
        case 1003:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                message:@"发送图片微博"
                                                               delegate:self cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"OK", nil];
            alertView.tag = 1;
            [alertView show];
            [alertView release];
            break;
        }
        default:
            break;
    }
}

/*******************************************************************************
 * 方法名称：sinaweibo
 * 功能描述：获取SinaWeibo对象
 * 输入参数：
 * 输出参数：SinaWeibo对象
 ******************************************************************************/
- (SinaWeibo *)sinaweibo
{
    ShareDemoAppDelegate *delegate = (ShareDemoAppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}

/*******************************************************************************
 * 方法名称：removeAuthData
 * 功能描述：移除本地保存的新浪用户帐号信息
 * 输入参数：
 * 输出参数：
 ******************************************************************************/
- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

/*******************************************************************************
 * 方法名称：storeAuthData
 * 功能描述：保存新浪用户帐号信息到本地
 * 输入参数：
 * 输出参数：SinaWeibo对象
 ******************************************************************************/
- (void)storeAuthData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*******************************************************************************
 * 方法名称：resetButtons
 * 功能描述：设置页面按钮的状态
 * 输入参数：
 * 输出参数：SinaWeibo对象
 ******************************************************************************/
- (void)resetButtons
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    BOOL authValid = sinaweibo.isAuthValid;
    
    loginButton.enabled = !authValid;
    logoutButton.enabled = authValid;
    postStatusButton.enabled = authValid;
    postImageStatusButton.enabled = authValid;
}

/*******************************************************************************
 * 方法名称：isBindCount
 * 功能描述：判断是否已经绑定帐号
 * 输入参数：
 * 输出参数：SinaWeibo对象
 ******************************************************************************/
- (BOOL)isBindCount
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    return sinaweibo.isAuthValid;
}

/*******************************************************************************
 * 方法名称：buttonWithFrame:action:
 * 功能描述：初始化页面按钮，并添加到页面视图
 * 输入参数：
 * 输出参数：SinaWeibo对象
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
