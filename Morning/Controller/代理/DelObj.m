//
//  DelObj.m
//  Morning
//
//  Created by HanKibou on 2021/3/21.
//

#import "DelObj.h"

@implementation DelObj

- (void)howOldAreYou {
    NSLog(@"你多少岁了？");
    if (!self.delegate) {
        NSLog(@"没有绑定代理，你问个屁的岁数！");
    }
    if ([self.delegate respondsToSelector:@selector(age)]) {
        NSInteger age = [self.delegate age];
        NSLog(@"我今年 %ld 岁", (long) age);
    } else {
        NSLog(@"没有绑定代理，无法获取岁数");
    }
}

- (void)whatsYourName {
    NSLog(@"你叫什么名字？");
    if (!self.delegate) {
        NSLog(@"没有绑定代理，你问个屁的名字！");
    }
    if ([self.delegate respondsToSelector:@selector(printMyName:)]) {
        [self.delegate printMyName:@"kenshin"];
    } else {
        NSLog(@"没有实现代理方法，无法获取姓名");
    }
}
@end
