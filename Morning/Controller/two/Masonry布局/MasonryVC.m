//
//  MasonryVC.m
//  Morning
//
//  Created by kenshin van on 2021/2/13.
//

#import "MasonryVC.h"
#import "MasonryPriorityVC.h"
/**
 参考:https://www.jianshu.com/p/24e4ff56bfea
 官网：https://github.com/SnapKit/Masonry
 */
@interface MasonryVC ()
@property (nonatomic, strong)FXW_Button     *btnUpdate;
@property (nonatomic, strong)UILabel        *labB;
@property (nonatomic, strong)FXW_Button     *btnNextPage;
@property (nonatomic, assign)BOOL            isChange;

@end

@implementation MasonryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Masonry的简单使用";
    self.view.backgroundColor = FXW_HEXColor(0x3f3f3f);//灰色 简书夜间模式
    [self setMasonryUI];
}

- (void)setMasonryUI{
    
    UILabel *labTop = [[UILabel alloc] init];
    labTop.textColor = [UIColor blackColor];
    labTop.backgroundColor = [UIColor yellowColor];
    labTop.text = @"靠近导航栏顶部的文本";
    [self.view addSubview:labTop];
    [labTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.centerX.mas_equalTo(0);
    }];
    
    UILabel *labA = [[UILabel alloc] init];
    labA.textColor = [UIColor blackColor];
    labA.backgroundColor = [UIColor redColor];
    labA.text = @"水平居中";
    labA.textAlignment = NSTextAlignmentCenter;//文本内容水平居中
    [self.view addSubview:labA];
    [labA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(labTop.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    
    _labB = [[UILabel alloc] init];
    _labB.textColor = [UIColor greenColor];
    _labB.backgroundColor = FXW_HEXColor(0x049fa);
    _labB.text = @"倍数布局";
    _labB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_labB];
    [_labB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(labA.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(labA.mas_width).multipliedBy(0.5);//相对于labA高度的0.5倍
        make.width.mas_equalTo(labA.mas_width).multipliedBy(2);//相当于labA宽度的2倍
    }];
    
    _btnUpdate = [[FXW_Button alloc] init];
    [_btnUpdate setTitle:@"点击更新约束" forState:UIControlStateNormal];
    _btnUpdate.backgroundColor = FXW_HEXColor(0x00a062);
    WS(ws);
    [_btnUpdate clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws clickBtnUpdate];
    }];
    [self.view addSubview:_btnUpdate];
    [_btnUpdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.labB.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(36);
    }];
    
    UILabel *labC = [[UILabel alloc] init];
    labC.textColor = [UIColor brownColor];
    labC.backgroundColor = [UIColor whiteColor];
    labC.text = @"Masonry使用注意事项用mas_makeConstraints的那个view需要在addSubview之后才能用这个方法mas_equalTo适用数值元素，equalTo适合多属性的比,如make.left.and.right.equalTo(self.view)方法and和with只是为了可读性，返回自身，比如make.left.and.right.equalTo(self.view)和make.left.right.equalTo(self.view)是一样的。因为iOS中原点在左上角所以注意使用offset时注意right和bottom用负数。";
    labC.numberOfLines = 0;//设置为0 文本将会自动换行
    labC.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labC];
    [labC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.btnUpdate.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(screenWidth*0.8);
    }];
    
    _btnNextPage = [[FXW_Button alloc] init];
    [_btnNextPage setTitle:@"下一页:优先级" forState:UIControlStateNormal];
    _btnNextPage.backgroundColor = FXW_HEXColor(0x00a062);
    [_btnNextPage clickButtonWithResultBlock:^(FXW_Button *button) {
        MasonryPriorityVC *vc = [[MasonryPriorityVC alloc] init];
        [ws base_pushVC:vc];
    }];
    [self.view addSubview:_btnNextPage];
    [_btnNextPage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(labC.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *labBottom = [[UILabel alloc] init];
    labBottom.textColor = [UIColor blackColor];
    labBottom.backgroundColor = [UIColor yellowColor];
    labBottom.text = @"靠近TabBar顶部的文本";
    [self.view addSubview:labBottom];
    [labBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.mas_bottomLayoutGuide);
        make.centerX.mas_equalTo(0);
    }];
    
}

//点击按钮更新约束
- (void)clickBtnUpdate{
    _isChange = !_isChange;
    WS(ws);
    //注意 这里使用的是 mas_remakeConstraints
    if (_isChange) {
        [_btnUpdate mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ws.labB.mas_bottom).offset(10);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(140);
            make.height.mas_equalTo(36);
        }];
    }else{
        [_btnUpdate mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ws.labB.mas_bottom).offset(10);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(140);
            make.height.mas_equalTo(50);
        }];
    }
}
@end
