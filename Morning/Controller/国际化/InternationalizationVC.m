//
//  InternationalizationVC.m
//  Morning
//
//  Created by kenshin van on 2021/2/11.
//

#import "InternationalizationVC.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

/*
 参考：
 App名称国际化
 App内文本国家化
 参考：https://www.jianshu.com/p/1d3e4877063b  [2016年的文章]
 内容简单，不做描述

 App权限弹窗国际化「就是获取访问权限时的弹窗文本内容的国际化」
 参考：https://blog.csdn.net/ziyuzhiye/article/details/89417538  [2019年的文章]
 也是向相同的文件中添加配置即可，同样还是要在info.plist中设置原始的权限配置内容，这里info中的key和国际化文件中的key是一致的。
 
 日历权限：https://www.jianshu.com/p/d3658ba9afdf
 
 */
@interface InternationalizationVC ()

@end

@implementation InternationalizationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"国际化";
    [self initUI];
}

- (void)initUI{
    UILabel *tipsLab = [[UILabel alloc] init];
    tipsLab.numberOfLines = 0;//设置为0，文本会自动换行
    tipsLab.backgroundColor = [UIColor grayColor];
    tipsLab.textColor = [UIColor greenColor];
    tipsLab.font = [UIFont systemFontOfSize:18];
    tipsLab.text = @"切换系统语言为英语，查看App名称变化、查看该控制器下方文本变化,实现细节查看源码注释";
    [self.view addSubview:tipsLab];
    [tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).mas_equalTo(10);//导航栏底部
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *demoLab = [[UILabel alloc] init];
    demoLab.text = NSLocalizedString(@"demoLab", nil);
    [self.view addSubview:demoLab];
    [demoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipsLab.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *descLab = [[UILabel alloc] init];
    descLab.text = @"提示:在切换系统语言之后，直接卸载App，重启,测试不同系统语言下的权限提示框效果";
    descLab.numberOfLines = 0;
    [self.view addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(demoLab.mas_bottom).mas_equalTo(30);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
    
    FXW_Button *btn = [[FXW_Button alloc] init];
    [btn setTitle:@"获取日历权限" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    btn.backgroundColor = [UIColor blackColor];
    [FXW_Tools fwx_setCornerRadiusWithView:btn andAngle:10];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descLab.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(36);
    }];
    
    WS(ws);
    [btn clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws saveCalendar];
    }];
}

// 先来一波权限判断
- (void)saveCalendar {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    //使用 requestAccessToEntityType:completion: 方法请求使用用户的日历数据库
    //注意：要提前在info.plist中添加日历权限，否则会crash，模拟器中也需要获取该权限
    //下面一行代码执行之后，将会弹出系统弹窗询问是否允许访问日历，点击弹窗之后进入后面的回调中响应
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        // 获取访问权限
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (error)
            {
                NSLog(@"报错啦");
            }
            else if (!granted)
            {
                NSLog(@"被用户拒绝，不允许访问日历，滚去开启权限");
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"已获取到权限，执行将事件保存到日历的相关操作...");
                });
            }
        }];
    }
}



@end
