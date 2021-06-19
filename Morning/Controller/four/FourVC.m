//
//  FourVC.m
//  Morning
//
//  Created by HanKibou on 2021/5/23.
//

#import "FourVC.h"

@interface FourVC ()

@end

@implementation FourVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =  @"知识点";
    [self loadData];
    [self baseTableVC_reloadMyTableView];
}

- (void)loadData {
    

}

- (void)baseTableVC_clickCellWithTitle:(NSString *)title {
    
}
    

@end
