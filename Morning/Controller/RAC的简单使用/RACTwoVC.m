//
//  RACTwoVC.m
//  Morning
//
//  Created by HanKibou on 2021/2/17.
//

#import "RACTwoVC.h"
#import "RACSignal.h"
#import "RACSubscriber.h"
#import "UITextField+RACSignalSupport.h"
#import "UIControl+RACSignalSupport.h"
#import "NSNotificationCenter+RACSupport.h"
#import "RACSubscriptingAssignmentTrampoline.h"
#import "RACSignal+Operations.h"

//参考：https://blog.csdn.net/LOLITA0164/article/details/101052997 的 第二部分【进阶教程】
//由于后续带吗太多这里就不写了 直接看原文吧
@interface RACTwoVC ()
@property (nonatomic, strong)UITextField *searchText;

@end

@implementation RACTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initRACTwoVCUI];
    [self setRAC];
}

- (void)initRACTwoVCUI{
    self.title = @"RAC进阶使用";
    WS(ws);
    _searchText = [[UITextField alloc] init];
    _searchText.placeholder = @"请输入想要搜索的内容";
    _searchText.textColor = [UIColor redColor];
    [self.view addSubview:_searchText];
    [_searchText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_topLayoutGuide).offset(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(36);
    }];
}

//验证搜索内容是否合法
- (BOOL)isValidSearchText:(NSString *)text{
    return [text length] > 2;
}

- (void)setRAC{
    //上述代码使用搜索文本字段的文本信号，将其map转换为对应的背景色，然后将其应用于搜索框的背景色。运行测试效果如下，当搜索框输入的文本太短，会显示黄色背景的无效提示。
    //在搜索框发生更改时，rac_textSignal 会发生next事件并包含当前文本值，map将文本值转换为颜色信号继续发生next事件，而subscribeNext:采用此值并将应用于文本框的背景色。
    WS(ws);
    [[_searchText.rac_textSignal map:^id(NSString *text) {
        return [self isValidSearchText:text]?UIColor.whiteColor:UIColor.yellowColor;
    }] subscribeNext:^(UIColor *color) {
        ws.searchText.backgroundColor = color;
    }];
    
}


@end
