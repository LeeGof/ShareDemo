//
//  RootViewController.h
//  ShareDemo
//
//  Created by ligf on 13-2-21.
//  Copyright (c) 2013年 ligf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView         *_tblControl;    //table控件
    NSArray             *_arrTableData;  // Table数据源
}

@property (nonatomic, retain) NSArray *arrTableData;
@property (nonatomic, retain) UITableView *tblControl;

@end
