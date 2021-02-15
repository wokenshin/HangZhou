//
//  MasonryPriorityVC.m
//  Morning
//
//  Created by kenshin van on 2021/2/14.
//

#import "MasonryPriorityVC.h"
//参考：http://www.jianshu.com/p/b0e1797036fe
@interface MasonryPriorityVC ()
@property (nonatomic, strong) FXW_Button *btnRemoveCenterView;
@property (nonatomic, strong) FXW_Button *btnRemoveLeftView;

@property (nonatomic, strong) UIView *viewLeft;
@property (nonatomic, strong) UIView *viewCenter;
@property (nonatomic, strong) UIView *viewRight;
@end

@implementation MasonryPriorityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优先级";
    [self setMasonryUI];
}

- (void)setMasonryUI{
    CGFloat margin = 20;
    CGFloat size = 100;
    _viewLeft = [[UIView alloc] init];
    _viewLeft.backgroundColor = [UIColor redColor];
    [self.view addSubview:_viewLeft];
    WS(ws);
    [_viewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_topLayoutGuide).offset(margin);
        make.left.mas_equalTo(margin);
        make.width.mas_equalTo(size);
        make.height.mas_equalTo(size);
    }];
    
    _viewCenter = [[UIView alloc] init];
    _viewCenter.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_viewCenter];
    [_viewCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_topLayoutGuide).offset(margin);
        make.left.mas_equalTo(ws.viewLeft.mas_right).offset(margin);
        //上一行代码存在“问题”，因为 当左边的view消失后，中间的view缺少左边的约束，所以给其加上一个优先级更低的左边的约束，当第一个左边约束失效后，
        //这个约束就会起作用，从而达到继续约束viewCenter的效果
        make.left.equalTo(ws.view.mas_left).offset(margin).priority(300);//设置优先级
        
        make.width.mas_equalTo(size);
        make.height.mas_equalTo(size);
    }];
    
    _viewRight = [[UIView alloc] init];
    _viewRight.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_viewRight];
    [_viewRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_topLayoutGuide).offset(margin);
        make.left.mas_equalTo(ws.viewCenter.mas_right).offset(margin);
        make.size.mas_equalTo(CGSizeMake(size, size));
        
        //同理 左边的低级约束得设置两个，因为可能删除中间的view，也可能删除中间和左边的view
        make.left.equalTo(ws.viewLeft.mas_right).offset(margin).priority(300);
        make.left.equalTo(ws.view.mas_left).offset(margin).priority(200);
    }];
    
    CGFloat hBtn = 36;
    CGFloat wBtn = screenWidth/2;
    
    _btnRemoveCenterView = [[FXW_Button alloc] init];
    _btnRemoveCenterView.backgroundColor = [UIColor greenColor];
    [_btnRemoveCenterView setTitle:@"删除centerView" forState:UIControlStateNormal];
    [_btnRemoveCenterView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnRemoveCenterView clickButtonWithResultBlock:^(FXW_Button *button) {
// 这里有个知识点:用约束布局实现动画，布局代码写在外面，然后调用强制布局方法写在UIView动画里面
        [ws.viewCenter removeFromSuperview];
        //动画效果
        [UIView animateWithDuration:0.5 animations:^{
            [ws.view layoutIfNeeded];//强制刷新布局
        }];
    }];
    [self.view addSubview:_btnRemoveCenterView];
    [_btnRemoveCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(wBtn, hBtn));
    }];
    
    _btnRemoveLeftView = [[FXW_Button alloc] init];
    _btnRemoveLeftView.backgroundColor = [UIColor blueColor];
    [_btnRemoveLeftView setTitle:@"删除leftView" forState:UIControlStateNormal];
    [_btnRemoveLeftView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnRemoveLeftView clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws.viewLeft removeFromSuperview];
        //动画效果
        [UIView animateWithDuration:0.5 animations:^{
            [ws.view layoutIfNeeded];//强制刷新布局
        }];
    }];
    [self.view addSubview:_btnRemoveLeftView];
    [_btnRemoveLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(wBtn, hBtn));
    }];
    
}
@end
