//
//  RACVC.m
//  Morning
//
//  Created by kenshin van on 2021/2/15.
//

#import "RACVC.h"
#import "RACTwoVC.h"

#import "RACSignal.h"
#import "RACSubscriber.h"
#import "UITextField+RACSignalSupport.h"
#import "UIControl+RACSignalSupport.h"
#import "NSNotificationCenter+RACSupport.h"
#import "RACSubscriptingAssignmentTrampoline.h"
#import "RACSignal+Operations.h"
/*
 2021.2.8.pm
 RAC+MVVM
 ReactiveCocoa简称RAC 说明：看过的文章都不错，简单易懂。值得一看
 ReactiveCocoa1.0 介绍： https://limboy.me/2013/06/19/frp-reactivecocoa/
 ReactiveCocoa2.0 介绍：https://limboy.me/2013/12/27/reactivecocoa-2/
 ReactiveCocoa2.1 介绍(主要是讲结合AFN的使用，暂时不用看)：https://limboy.me/2014/01/05/ios-rest-client-implementation/
 ReactiveCocoa2实战(主要讲经验，内容比较长未看完)：https://limboy.me/2014/06/06/deep-into-reactivecocoa2/
 RAC学习成本还是比较高的，有利有弊，但是用好了还是利大于弊。[戴铭却持相反的态度，至少没有大力支持]
 
 MVVM(还是看的同一个人的文章，加深里我的MVVM的理解，内容很平易近人)：https://limboy.me/2015/09/27/ios-mvvm-without-reactivecocoa/
 MVVM笔记 from上一行
 非常平易近人的解释:
 MVVM 是 MVC 模式的一种演进，它主要解决了 ViewController 过于臃肿带来的不易维护和测试的问题。
 其中 ViewModel 的主要职责是处理业务逻辑并提供 View 所需的数据，这样 VC 就不用关心业务，自然也就瘦了下来。
 ViewModel 只关心业务数据不关心 View，所以不会与 View 产生耦合，也就更方便进行单元测试。
 View 是一个壳，它所呈现的内容都需要由 ViewModel 来提供，而 View 又不与 ViewModel 直接沟通，这时就需要 ViewController 来做中间的协调者。ViewController 持有 View 和 ViewModel，当 VC 初始化时，会让 ViewModel 去取数据，简单来说就是调用 VM 的某个获取数据的方法。

 Tips
 ViewController 尽量不涉及业务逻辑，让 ViewModel 去做这些事情。
 ViewController 只是一个中间人，接收 View 的事件、调用 ViewModel 的方法、响应 ViewModel 的变化。
 ViewModel 不能包含 View，不然就跟 View 产生了耦合，不方便复用和测试。
 ViewModel 之间可以有依赖。
 ViewModel 避免过于臃肿，不然维护起来也是个问题。

 极客时间对RAC(即  ReactiveCocoa)的介绍(戴铭老师的付费课)：https://time.geekbang.org/column/article/93054
 戴铭对RAC给出了不同的评价，指出了RAC中的弊端，以及其没有流行起来的原因做出了分析。同时认可其接口设计思想在iOS中的运用优势。
 */


//2021.2.15
//demo 使用层面上 参考：https://blog.csdn.net/LOLITA0164/article/details/101052997
//本demo引入的RAC库为：ReactiveObjC，参考：https://www.jianshu.com/p/eb80e3803970
@interface RACVC ()
@property (nonatomic, strong)UITextField *text;
@property (nonatomic, strong)UIButton    *btn;

@property (nonatomic, strong)UITextField *userNameText;
@property (nonatomic, strong)UITextField *passwordText;
@property (nonatomic, strong)UIButton    *loginBtn;
@property (nonatomic, strong)UIButton    *nextBtn;
@end

@implementation RACVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RAC的简单使用";
    [self setRACVCUI];
    [self racDemoCodes];
    
}

- (void)setRACVCUI{
    WS(ws);
    _text = [[UITextField alloc] init];
    _text.placeholder = @"简单的测试文本框";
    _text.textColor = [UIColor redColor];
    _text.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_text];
    [_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_topLayoutGuide).offset(10);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(200, 36));
    }];
    
    
    _btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.backgroundColor = [UIColor blueColor];
    [_btn setTitle:@"测试按钮的RAC" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:_btn];
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.text.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(200, 36));
    }];
    
    _userNameText = [[UITextField alloc] init];
    _userNameText.placeholder = @"请输入手机号码";
    _userNameText.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_userNameText];
    [_userNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.btn.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
    }];
    
    _passwordText = [[UITextField alloc] init];
    _passwordText.placeholder = @"请输入>=6位数的密码";
    _passwordText.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_passwordText];
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.userNameText.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
    }];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginBtn.backgroundColor = [UIColor darkGrayColor];
    [_loginBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.passwordText.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(180, 36));
    }];
    
    UILabel *tipsLab = [[UILabel alloc] init];
    tipsLab.text = @"只有当输入合法的用户名和密码时，登陆按钮点击才可用";
    tipsLab.textColor = [UIColor redColor];
    tipsLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:tipsLab];
    [tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.loginBtn.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(20);
    }];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _nextBtn.backgroundColor = [UIColor grayColor];
    [_nextBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_nextBtn setTitle:@"下一页" forState:UIControlStateNormal];
    [self.view addSubview:_nextBtn];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipsLab.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(180, 36));
    }];
}

//RAC相关的代码
- (void)racDemoCodes{
    
    [[_btn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"卧槽！瞬间觉得自己写的block回调按钮不香了...");
    }];
    //@weakify(self)：为了打断循环引用！！
    //@strongify(self)：为了防止self被释放后，队列无法调用block！！
    //其实这里的block内存泄漏问题和block的变量截获有关，慕课网里的相关资料说得很清楚
    
//    @weakify(self);
//    [[_text rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
//        @strongify(self);
//        NSLog(@"_text 这里也不是预期的效果，初始化完成后，直接就调用了--->%@",x);
//        self.text.text = @"Hello";
//    }];
    
    [_text.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"只要文本内容改变就会触发 %@", x);//实际上也会有有监听不到的时候，比如输入内容的英语 提示单词纠错，修改后时就没触发这里的回调
    }];
    
    //我们也可以给信号设置过滤条件，只在我们想要的情况下回调即可
    [[_text.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return [value length] > 3;//这里设置了过滤条件【这里的回调 每次值改变时都会触发】
    }] subscribeNext:^(NSString * _Nullable x) {
            NSLog(@"%@", x);//当过滤条件满足时，就会触发这里的回调
       }];
    
    //还能监听通知的各种事件，下面就是监听了APP退到后台的事件。最重要的一点就是不需要移除通知，比通知用起来更爽，无后顾之忧！！！
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationWillEnterForegroundNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"notify 这里为被调用了两次，这不是预期的效果---->%@",x);//这里调用了两次。。。 question？？？
    }];
    
    // 创建验证用户名的信号
    @weakify(self);
    RACSignal *validUsernameSignal = [_userNameText.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self);
        //由于它是布尔类型，我们通过装箱转换为NSNumber对象类型
        return @([self isValidUsername:value]);
    }];
    
    // 创建验证密码的信号
    //@weakify(self); 这里应该不用再声明了
    RACSignal* validPasswordSignal = [_passwordText.rac_textSignal map:^id(id value) {
        @strongify(self);
        return @([self isValidPassword:value]);
    }];
    
//    //再次转换这些信号，以便它们可以为文本框提供漂亮的背景颜色
//    [[validPasswordSignal map:^id (NSNumber* pwd) {
//            //转换为颜色数据
//            return [pwd boolValue]?UIColor.clearColor:UIColor.yellowColor;
//        }] subscribeNext:^(UIColor* color) {
//           //将颜色设置到对应的文本框上
//            @strongify(self);
//            self.passwordText.backgroundColor = color;
//    }];
    
    //从概念上来讲，上面注释掉的代码讲信号的最终输出分配给了文本框的 backgroundColor 属性，但是从代码上很难感受出来！幸运的是，ReactiveCocoa 中有一个宏，可以让你优雅地表达这一点
    RAC(self.userNameText, backgroundColor) = [validUsernameSignal map:^id(id value) {
        return [value boolValue] ? UIColor.clearColor : UIColor.yellowColor;
    }];
    RAC(self.passwordText, backgroundColor) = [validPasswordSignal map:^id(id value) {
        return [value boolValue] ? UIColor.clearColor : UIColor.yellowColor;
    }];
    
    //组合信号 在用户名和密码都无效的情况下 登陆按钮是无效的，都有效时，登陆按钮才可以点击
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validUsernameSignal, validPasswordSignal] reduce:^id (NSNumber *usernameValid, NSNumber *passwordValid){
        //每当这两个信号的其中任何一个发出新值时，reduce块都会被执行，它返回的值将作为组合信号的下一个值发送。
        return @([usernameValid boolValue]&&[passwordValid boolValue]);
    }];
    //RACSignal组合方法可以结合任何数量的信号，并且在reduce块的参数分别对应每个信号传递的值
    //现在，我们使用这个全新的信号添加内容，将其绑定到按钮上的enable属性：
    RAC(self.loginBtn, enabled) = signUpActiveSignal;
    
    //设置登录按钮处理点击事件
    [[_loginBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"登录中...");
    }];
    
    [[_nextBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        RACTwoVC *vc = [[RACTwoVC alloc] init];
        @strongify(self);
        [self base_pushVC:vc];
    }];
}

//验证用户名是否为手机号码
- (BOOL)isValidUsername:(NSString *)telephone{
    if (telephone == nil || telephone.length < 1) {
        return NO;
    }
    telephone = [telephone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *regex = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:telephone];
    if (!isMatch) {
        return [self isValidMobileNumber:telephone];
    }
    return isMatch;
}

- (BOOL)isValidMobileNumber:(NSString*)mobileNum
{
    
    if (mobileNum == nil || [mobileNum length] == 0) {
        return NO;
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^[1][3|4|5|7|8|9]\\d{9}$";
    
    //    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    
    if (!isMatch) {
        return NO;
    }
    return YES;
    
}

//密码长度必须>=6
- (BOOL)isValidPassword:(NSString *)pwd{
    if ([pwd length] >= 6) {
        return YES;
    }
    return NO;
}

- (void)dealloc{
    NSLog(@"RACVC释放了......");//这里我引入了一个第三方库:MLeaksFinder 其实不用写这里的方法也可以检查。出现内存泄漏了 会有弹窗提示。
}
@end
