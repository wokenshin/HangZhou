//
//  DelVC.m
//  Morning
//
//  Created by HanKibou on 2021/3/21.
//

#import "DelVC.h"
#import "DelObj.h"
#import "FXWDelegate.h"
@interface DelVC ()<FXWDelegate>
@property (nonatomic, strong)DelObj *obj;
@end

@implementation DelVC//【代理方】

- (void)viewDidLoad {
    [super viewDidLoad];
    _obj = [[DelObj alloc] init];
    _obj.delegate = self;
    [_obj howOldAreYou];//通过调用对象，在实现的代理回调中将数据回传回去。
    [_obj whatsYourName];//通过调用对象，在实现的代理回调中获取数据
}

- (NSInteger)age {//类似 UITableViewDataSource 回传数据
    return 31;
}

- (void)printMyName:(NSString *)name{//类似 UITableViewDelegate 下发数据
    NSLog(@"%@", name);
}
@end
