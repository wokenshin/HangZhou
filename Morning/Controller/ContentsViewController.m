//
//  ContentsViewController.m
//  Morning
//
//  Created by kenshin van on 2021/2/10.
//

#import "ContentsViewController.h"
#import "InternationalizationVC.h"

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
    [self baseTableVC_addDataWithTitle:@"国际化" andDetail:@"2021.2.11"];
    
}

- (void)baseTableVC_clickCellWithTitle:(NSString *)title{
    
    if([title isEqualToString:@"国际化"]){
        InternationalizationVC *vc = [[InternationalizationVC alloc] init];
        [self base_pushVC:vc];
        return;
    }
    NSLog(@"%@ 没有这个cell !!!", [self class]);
}
@end
