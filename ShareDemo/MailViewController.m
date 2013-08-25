//
//  MailViewController.m
//  ShareDemo
//
//  Created by ligf on 13-2-26.
//  Copyright (c) 2013年 ligf. All rights reserved.
//

#import "MailViewController.h"
#import "Constants.h"

@interface MailViewController ()

@end

@implementation MailViewController

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
    
    self.title = @"分享到邮箱";
    
    shareToMailButton = [self buttonWithFrame:CGRectMake(20, 100, 280, 40) action:@selector(btnClicked:) withTag:1000];
    [shareToMailButton setTitle:@"分享到邮箱" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义方法

- (void)btnClicked:(id)sender
{
    UIButton *btnSender = (UIButton *)sender;
    
    switch (btnSender.tag)
    {
        case 1000:  // 分享到邮箱
        {
            [self showMailPicker];
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

- (void)showMailPicker
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (mailClass !=nil)
    {
        if ([mailClass canSendMail])
        {
            [self displayMailComposerSheet];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@""message:@"设备不支持邮件功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }
    else
    {
        
    }
    
}

- (void)displayMailComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    
    picker.mailComposeDelegate =self;
    [picker setSubject:@"文件分享"];
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@"279352257@qq.com"];
//    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@qq.com",@"third@qq.com", nil];
//    NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@qq.com"];
    
    [picker setToRecipients:toRecipients];
//    [picker setCcRecipients:ccRecipients];
//    [picker setBccRecipients:bccRecipients];
    //发送图片附件
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"res3" ofType:@"jpg"];
//    NSData *myData = [NSData dataWithContentsOfFile:path];
    NSData *myData = [NSData dataWithContentsOfFile:[DOCUMENTS_FOLDER stringByAppendingPathComponent:@"new.png"]];
    [picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"new.png"];
    //发送txt文本附件
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"MyText" ofType:@"txt"];
    //NSData *myData = [NSData dataWithContentsOfFile:path];
    //[picker addAttachmentData:myData mimeType:@"text/txt" fileName:@"MyText.txt"];
    //发送doc文本附件
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"MyText" ofType:@"doc"];
    //NSData *myData = [NSData dataWithContentsOfFile:path];
    //[picker addAttachmentData:myData mimeType:@"text/doc" fileName:@"MyText.doc"];
    //发送pdf文档附件
    /*
     NSString *path = [[NSBundlemainBundle] pathForResource:@"CodeSigningGuide"ofType:@"pdf"];
     NSData *myData = [NSDatadataWithContentsOfFile:path];
     [pickeraddAttachmentData:myData mimeType:@"file/pdf"fileName:@"rainy.pdf"];
     */
    // Fill out the email body text
//    NSString *emailBody = [NSString stringWithFormat:@"<img src='http://t1.baidu.com/it/u=3947848263,165348523&fm=24&gp=0.jpg' /><p>我分享了文件给您，地址是%@</p>",@""];
    NSString *emailBody = [NSString stringWithFormat:@"<p>我分享了图片</p>"];
    [picker setMessageBody:emailBody isHTML:YES];
    [self presentModalViewController:picker animated:YES];
    [picker release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: Mail sending canceled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Result: Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: Mail sending failed");
            break;
        default:
            NSLog(@"Result: Mail not sent");
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    NSLog(@"messageComposeViewController");
}

@end
