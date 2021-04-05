//
//  ContentsViewController.m
//  Morning
//
//  Created by kenshin van on 2021/2/10.
//

#import "ContentsViewController.h"
#import "InternationalizationVC.h"
#import "YYModelBaseUseVC.h"
#import "MasonryVC.h"
#import "RACVC.h"
#import "DelVC.h"
#import "MultipleInheritVC.h"


@interface ContentsViewController ()

@end

@implementation ContentsViewController

/*
 直接弄成一个列表，支持模糊查询那种，模糊查询看看好不好做，不好做就直接搜索?
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Contents";
    [self loadData];
    [self baseTableVC_reloadMyTableView];
}

- (void)loadData{
    //这里用时间的降序排列
    [self baseTableVC_addDataWithTitle:@"多继承" andDetail:@"2021.4.6"];
    [self baseTableVC_addDataWithTitle:@"代理" andDetail:@"2021.3.25"];
    [self baseTableVC_addDataWithTitle:@"RAC的简单使用" andDetail:@"2021.2.15,函数式响应式编程"];
    [self baseTableVC_addDataWithTitle:@"Masonry的简单使用" andDetail:@"2021.2.13"];
    [self baseTableVC_addDataWithTitle:@"YYModel的简单使用" andDetail:@"2021.2.13"];
    [self baseTableVC_addDataWithTitle:@"国际化" andDetail:@"2021.2.11"];
}

- (void)baseTableVC_clickCellWithTitle:(NSString *)title{
    if ([title isEqualToString:@"多继承"]) {
        MultipleInheritVC *vc = [[MultipleInheritVC alloc] init];
        [self base_pushVC:vc];
        return;
    }
    if ([title isEqualToString:@"代理"]) {
        DelVC *vc = [[DelVC alloc] init];
        [self base_pushVC:vc];
        return;
    }
    if ([title isEqualToString:@"RAC的简单使用"]) {
        RACVC *vc = [[RACVC alloc] init];
        [self base_pushVC:vc];
        return;
    }
    if ([title isEqualToString:@"Masonry的简单使用"]) {
        MasonryVC *vc = [[MasonryVC alloc] init];
        [self base_pushVC:vc];
        return;
    }
    if ([title isEqualToString:@"YYModel的简单使用"]) {
        YYModelBaseUseVC *vc = [[YYModelBaseUseVC alloc] init];
        [self base_pushVC:vc];
        return;
    }
    if([title isEqualToString:@"国际化"]){
        InternationalizationVC *vc = [[InternationalizationVC alloc] init];
        [self base_pushVC:vc];
        return;
    }
    NSLog(@"%@ 没有这个cell !!!", [self class]);
}
@end
