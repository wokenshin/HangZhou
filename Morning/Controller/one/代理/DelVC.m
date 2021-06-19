//
//  DelVC.m
//  Morning
//
//  Created by HanKibou on 2021/3/21.
//

#import "DelVC.h"
#import "DelObj.h"
#import "FXWDelegate.h"
//知识点参考：https://juejin.cn/post/6844904150359080967
//协议可以继承其他协议，并且可以继承多个协议，在iOS中对象是不支持多继承的，而协议可以多继承。
@interface DelVC ()<FXWDelegate>
@property (nonatomic, strong)DelObj *obj;
@end

@implementation DelVC//【代理方】

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    _obj = [[DelObj alloc] init];
    _obj.delegate = self;//绑定代理，其实就是将obj的代理的指针指向当前的控制器，这样当前vc就成为了代理方，接收委托下发的信息
    [_obj howOldAreYou];//通过调用对象，在实现的代理回调中将数据回传回去。
    [_obj whatsYourName];//通过调用对象，在实现的代理回调中获取数据
}

- (void)initUI {
    self.title = @"协议";
    CGFloat margin = 20;
    UILabel *tipsLab = [[UILabel alloc] init];
    tipsLab.text = @"如何快速的记住协议呢？比如UITableView的协议 UITableViewDelegate、UITableViewDataSource。你既可以在当前的控制器中等待事件下发的回调（didSelectRowAtIndexPath）也可以返回自己设置的Cell给TableView让其自己负责显示（cellForRowAtIndexPath）\n综上，代理既可以下发也可以返回";
    tipsLab.numberOfLines = 0;//自动换行
    tipsLab.textColor = [UIColor blackColor];
    [self.view addSubview:tipsLab];
    [tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(margin);
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
    }];
}

#pragma mark - FXWDelegate
- (NSInteger)age {//类似 UITableViewDataSource 回传数据
    return 31;
}

- (void)printMyName:(NSString *)name{//类似 UITableViewDelegate 下发数据
    NSLog(@"我的名字叫 %@", name);
}
@end
