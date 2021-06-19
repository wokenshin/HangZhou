//
//  MultipleInheritVC.m
//  Morning
//
//  Created by HanKibou on 2021/4/6.
//

#import "MultipleInheritVC.h"
#import "FXWCalculator.h"

@interface MultipleInheritVC ()

@end

@implementation MultipleInheritVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    //参考：https://www.jianshu.com/p/9601e84177a3 ，多继承可以用 协议、分类、消息转发等方式来实现
    FXWCalculator *ca = [[FXWCalculator alloc] init];
    NSLog(@"加法运算结果：%f", [ca addWithA:1.11 andB:2.22]);
    NSLog(@"减法运算结果：%f", [ca subWithA:3.33 andB:2.22]);
    NSLog(@"乘法运算结果：%f", [ca mulWithA:12 andB:30]);
}

- (void)initUI {
    self.title = @"多继承";
    CGFloat margin = 20;
    UILabel *tipsLab = [[UILabel alloc] init];
    tipsLab.text = @"参考：https://www.jianshu.com/p/9601e84177a3 ，多继承可以用 协议、分类、消息转发等方式来实现 个人开发中常见到的是使用协议（protocol）";
    tipsLab.numberOfLines = 0;//自动换行
    tipsLab.textColor = [UIColor blackColor];
    [self.view addSubview:tipsLab];
    [tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(margin);
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
    }];
}



@end
