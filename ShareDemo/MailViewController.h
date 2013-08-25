//
//  MailViewController.h
//  ShareDemo
//
//  Created by ligf on 13-2-26.
//  Copyright (c) 2013年 ligf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import<MessageUI/MFMailComposeViewController.h>

@interface MailViewController : UIViewController<MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate>
{
    UIButton                    *shareToMailButton;
}

@end
