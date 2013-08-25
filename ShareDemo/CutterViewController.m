//
//  CutterViewController.m
//  ShareDemo
//
//  Created by ligf on 13-2-26.
//  Copyright (c) 2013年 ligf. All rights reserved.
//

#import "CutterViewController.h"
#import "Constants.h"

@interface CutterViewController ()

@end

@implementation CutterViewController

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
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    webView.scalesPageToFit =YES;
    [webView setDelegate:self];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.eoe.cn/"]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
}

- (void)viewWillAppear:(BOOL)animated
{
    UIButton *btnCutter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnCutter setFrame:CGRectMake(250, 7, 62, 30)];
    [btnCutter addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnCutter setTitle:@"Cutter" forState:UIControlStateNormal];
    btnCutter.tag = 1000;
    UIBarButtonItem *barBtnCutter = [[UIBarButtonItem alloc] initWithCustomView:btnCutter];
    barBtnCutter.style=UIBarButtonItemStyleBordered;
    self.navigationItem.rightBarButtonItem = barBtnCutter;
    [barBtnCutter release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnClick:(id)sender
{
    UIButton *btnSender = (UIButton *)sender;
    switch (btnSender.tag)
    {
        case 1000:
        {
            NSData *imageData = [self getImageFromView:webView];
            [imageData writeToFile:[DOCUMENTS_FOLDER stringByAppendingPathComponent:@"new.png"] atomically:YES];

            break;
        }
        default:
            break;
    }
}

- (NSData *)getImageFromView:(UIView *)view  // Mine is UIWebView but should work for any
{
    NSData *pngImg;
    CGFloat max, scale = 1.0;
    CGSize viewSize = [view bounds].size;
    
    // Get the size of the the FULL Content, not just the bit that is visible
    CGSize size = [view sizeThatFits:CGSizeZero];
    
    // Scale down if on iPad to something more reasonable
    max = (viewSize.width > viewSize.height) ? viewSize.width : viewSize.height;
    if( max > 960 )
        scale = 960/max;
    
    UIGraphicsBeginImageContextWithOptions( size, YES, scale );
    
    // Set the view to the FULL size of the content.
    [view setFrame: CGRectMake(0, 0, size.width, size.height)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    pngImg = UIImagePNGRepresentation( UIGraphicsGetImageFromCurrentImageContext() );
    
    UIGraphicsEndImageContext();
    return pngImg;    // Voila an image of the ENTIRE CONTENT, not just visible bit
}

- (void)fullScreenshots
{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
    
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
    
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    [activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError:%@", error);
    [activityIndicator stopAnimating];
    UIView *view = (UIView *)[self.view viewWithTag:108];
    [view removeFromSuperview];
}

@end
