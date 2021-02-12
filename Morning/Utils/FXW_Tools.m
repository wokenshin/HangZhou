//
//  FXWTools.m
//  Morning
//
//  Created by kenshin van on 2021/2/11.
//

#import "FXW_Tools.h"

@implementation FXW_Tools

#pragma mark 设置UI圆角
+ (void)fwx_setCornerRadiusWithView:(UIView *)view andAngle:(CGFloat)angle
{
    view.layer.cornerRadius  = angle; //本行代码在IOS6中就可以给label设置圆角，但是在IOS7中不行，还需要再加上下面一行代码
    view.layer.masksToBounds = YES;   //默认是NO,超出主层边界的内容统统剪掉
}

@end
