//
//  ContentsViewController.m
//  Morning
//
//  Created by kenshin van on 2021/2/10.
//

#import "OneVC.h"
#import "InternationalizationVC.h"
#import "DelVC.h"
#import "MultipleInheritVC.h"


@interface OneVC ()

@end

@implementation OneVC

/*
 直接弄成一个列表，支持模糊查询那种，模糊查询看看好不好做，不好做就直接搜索?
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =  @"实验室";
    [self loadData];
    [self baseTableVC_reloadMyTableView];
}

- (void)loadData{
    //这里用时间的降序排列
    [self baseTableVC_addDataWithTitle:@"多继承" andDetail:@"2021.4.6"];
    [self baseTableVC_addDataWithTitle:@"协议-代理方-委托方" andDetail:@"2021.3.25"];
    [self baseTableVC_addDataWithTitle:@"国际化" andDetail:@"2021.2.11"];
}

- (void)baseTableVC_clickCellWithTitle:(NSString *)title{
    if ([title isEqualToString:@"多继承"]) {
        MultipleInheritVC *vc = [[MultipleInheritVC alloc] init];
        [self base_pushVC:vc];
        return;
    }
    if ([title isEqualToString:@"协议-代理方-委托方"]) {
        DelVC *vc = [[DelVC alloc] init];
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
