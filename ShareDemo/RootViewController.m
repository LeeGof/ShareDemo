//
//  RootViewController.m
//  ShareDemo
//
//  Created by ligf on 13-2-21.
//  Copyright (c) 2013年 ligf. All rights reserved.
//

#import "RootViewController.h"
#import "SinaWeiboViewController.h"
#import "TCWeiboViewController.h"
#import "WeiXinViewController.h"
#import "MailViewController.h"
#import "CutterViewController.h"
#import "WYWeiboViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
@synthesize arrTableData = _arrTableData;
@synthesize tblControl = _tblControl;

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
    
    self.arrTableData = [NSArray arrayWithObjects:@"新浪微博",@"腾讯微博",@"微信",@"邮箱",@"截图",@"网易微博", nil];
    
    _tblControl = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    _tblControl.delegate = self;
    _tblControl.dataSource = self;
    [self.view addSubview:_tblControl];
    [_tblControl release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    self.arrTableData = nil;
    self.tblControl = nil;
    
    [super viewDidUnload];
}

- (void)dealloc
{
    [_arrTableData release];
    [_tblControl release];
    
    [super dealloc];
}

#pragma mark - Tableview DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrTableData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_tblControl dequeueReusableCellWithIdentifier:@"BaseCell"];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BaseCell"] autorelease];
    }
    cell.textLabel.text = [_arrTableData objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Tableview Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    barButtonItem.title = NSLocalizedString(@"cancel", nil);
    self.navigationItem.backBarButtonItem=barButtonItem;
    [barButtonItem release];
    
    //进入详情页面
    switch (indexPath.row)
    {
        case 0:
        {
            SinaWeiboViewController *sinaWeiboViewController = [[[SinaWeiboViewController alloc] init] autorelease];
            
            [self.navigationController pushViewController:sinaWeiboViewController animated:YES];
            
            break;
        }
        case 1:
        {
            TCWeiboViewController *tcWeiboViewController = [[[TCWeiboViewController alloc] init] autorelease];
            
            [self.navigationController pushViewController:tcWeiboViewController animated:YES];
            
            break;
        }
        case 2:
        {
            WeiXinViewController *weixinViewController = [[[WeiXinViewController alloc] init] autorelease];
            
            [self.navigationController pushViewController:weixinViewController animated:YES];
            
            break;
        }
        case 3:
        {
            MailViewController  *mailViewController = [[[MailViewController alloc] init] autorelease];
            
            [self.navigationController pushViewController:mailViewController animated:YES];
            
            break;
        }
        case 4:
        {
            CutterViewController *cutterViewController = [[[CutterViewController alloc] init] autorelease];
            
            [self.navigationController pushViewController:cutterViewController animated:YES];
            
            break;
        }
        case 5:
        {
            WYWeiboViewController *wyWeiboViewController = [[[WYWeiboViewController alloc] init] autorelease];
            
            [self.navigationController pushViewController:wyWeiboViewController animated:YES];
            
            break;
        }
        case 6:
        {
            
            
            break;
        }
        case 7:
        {
            
            
            break;
        }
        case 8:
        {
            
            
            break;
        }
        default:
            break;
    }
}



@end
