//
//  TwoVC.m
//  Morning
//
//  Created by HanKibou on 2021/5/23.
//

#import "TwoVC.h"
#import "YYModelBaseUseVC.h"
#import "MasonryVC.h"
#import "RACVC.h"

@interface TwoVC ()

@end

@implementation TwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"封装";
    [self loadData];
    [self baseTableVC_reloadMyTableView];
}

- (void)loadData {
    //这里用时间的降序排列
    [self baseTableVC_addDataWithTitle:@"RAC的简单使用" andDetail:@"2021.2.15,函数式响应式编程"];
    [self baseTableVC_addDataWithTitle:@"Masonry的简单使用" andDetail:@"2021.2.13"];
    [self baseTableVC_addDataWithTitle:@"YYModel的简单使用" andDetail:@"2021.2.13"];
    [self baseTableVC_addDataWithTitle:@"AFN" andDetail:@"TODO"];
    [self baseTableVC_addDataWithTitle:@"WebSocket" andDetail:@"TODO"];
    [self baseTableVC_addDataWithTitle:@"BLE" andDetail:@"TODO"];

}

- (void)baseTableVC_clickCellWithTitle:(NSString *)title {
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
}



@end
