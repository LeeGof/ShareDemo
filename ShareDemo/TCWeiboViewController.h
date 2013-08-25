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

#import <UIKit/UIKit.h>
#import "TCWBEngine.h"

@interface TCWeiboViewController : UIViewController
{
    TCWBEngine                  *weiboEngine;
    
    UIButton                    *loginButton;
    UIButton                    *logoutButton;
    UIButton                    *postStatusButton;
    UIButton                    *postImageStatusButton;
}

@property (nonatomic, retain) TCWBEngine   *weiboEngine;

@end
