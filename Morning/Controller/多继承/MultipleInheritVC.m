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
    //参考：https://www.jianshu.com/p/9601e84177a3 ，多继承可以用 协议、分类、消息转发等方式来实现
    FXWCalculator *ca = [[FXWCalculator alloc] init];
    NSLog(@"加法运算结果：%f", [ca addWithA:1.11 andB:2.22]);
    NSLog(@"减法运算结果：%f", [ca subWithA:3.33 andB:2.22]);
    NSLog(@"乘法运算结果：%f", [ca mulWithA:12 andB:30]);
}



@end
