//
//  RACTwoVC.m
//  Morning
//
//  Created by HanKibou on 2021/2/17.
//

#import "RACTwoVC.h"



@interface RACTwoVC ()
@property (nonatomic, strong)UIButton    *racBtn;
@property (nonatomic, strong)UIButton    *racKVOBtn;
@property (nonatomic, strong)UITextField *racText;
@property (nonatomic, strong)UIButton    *timerBtn;
@property (nonatomic, strong)UILabel     *lab;
@property (nonatomic, strong)UITextField *racText2;
@property (nonatomic, strong)RACDisposable   *disTimer;
@property (nonatomic, strong)RACDisposable   *disNotify;
@end

@implementation RACTwoVC

- (void)dealloc{
    //在信号dealloc的时候 内部也会调用 dispose，可是为什么这里不这么操作就无法释放呢？
    [_disTimer dispose];//删除timer
    [_disNotify dispose];//删除通知
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initRACTwoVCUI];
    [self setRAC];
}

- (void)initRACTwoVCUI{
    self.title = @"RAC进阶使用";
    WS(ws);
    CGFloat heightUI = 36;
    CGFloat margin = 10;
    
    _racBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    //_racBtn.titleLabel.text = @"racBtn";
    //_racBtn.titleLabel.textColor = [UIColor blueColor];
    //上面两行代码无法生效。。。
    [_racBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [_racBtn setTitle:@"racBtn" forState:UIControlStateNormal];
    _racBtn.backgroundColor = UIColor.blueColor;
    [self.view addSubview:_racBtn];
    [_racBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_topLayoutGuide).offset(0);
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
        make.height.mas_equalTo(heightUI);
    }];
    
    _racKVOBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_racKVOBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [_racKVOBtn setTitle:@"KVOBtn" forState:UIControlStateNormal];
    _racKVOBtn.backgroundColor = UIColor.grayColor;
    [self.view addSubview:_racKVOBtn];
    [_racKVOBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.racBtn.mas_bottom).offset(margin);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(200, heightUI));
    }];
    
    //为了触发键盘现实而写的text
    _racText = [[UITextField alloc] init];
    _racText.backgroundColor = UIColor.grayColor;
    _racText.placeholder = @"rac实现通知、值监听";
    [self.view addSubview:_racText];
    [_racText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.racKVOBtn.mas_bottom).offset(margin);
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
        make.height.mas_equalTo(heightUI);
    }];
    
    _timerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_timerBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [_timerBtn setTitle:@"Timer" forState:UIControlStateNormal];
    _timerBtn.backgroundColor = UIColor.grayColor;
    [self.view addSubview:_timerBtn];
    [_timerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.racText.mas_bottom).offset(10);
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
        make.height.mas_equalTo(heightUI);
    }];
    
    _lab = [[UILabel alloc] init];
    _lab.text = @"同步下方文本框内容...";
    _lab.backgroundColor = UIColor.grayColor;
    [self.view addSubview:_lab];
    [_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.timerBtn.mas_bottom).offset(10);
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
        make.height.mas_equalTo(heightUI);
    }];
    
    _racText2 = [[UITextField alloc] init];
    _racText2.placeholder = @"输入内容会被同步到上方标签...";
    _racText2.backgroundColor = UIColor.grayColor;
    [self.view addSubview:_racText2];
    [_racText2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.lab.mas_bottom).offset(10);
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
        make.height.mas_equalTo(heightUI);
    }];
    
}


- (void)setRAC{
    [self racBaseOperation];
    
    //rac_signalForControlEvents 代替按钮事件的监听
    [[_racBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"racBtn Action ...");
    }];
    
    //为了触发KVO而写的事件处理
    @weakify(self);
    [[_racKVOBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)]
    subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.racKVOBtn.backgroundColor = UIColor.yellowColor;
    }];
    
    //KVO
    [[_racKVOBtn rac_valuesForKeyPath:@"backgroundColor" observer:nil] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    //通过
    _disNotify = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"键盘出来了 嘿嘿！ 通知没有被移除");
        NSLog(@"%@", x);
    }];
    
    //监听文本框textfield
    [_racText.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
    
    //Timer
    [[_timerBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self timerFunc];
    }];
    
    //绑定信号 RAC的宏定义
    //用来给某个对象的某个属性绑定信号，只要产生信号内容，就会将内容赋值给属性
    RAC(_lab, text) = _racText2.rac_textSignal;
}

- (void)timerFunc{
    //通过RAC创建的timer 默认在子线程当中，默认开启了runloop且是runloop下的NSRunLoopCommonModes模式，这样滑动UI时就不会终止timer了
    _disTimer = [[RACSignal interval:1.0 onScheduler:[RACScheduler scheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"%@----%@",x,[NSThread currentThread]);
    }];
    
}

- (void)timerMethod{
    NSLog(@"每秒触发一次...");
}

//RAC的基本操作流程：创建信号、监听信号并设置回调、发送信号
- (void)racBaseOperation{
    //1、创建信号 创建信号对象 然后创建一个可变数组用于保存订阅者
    RACSubject *racsub = [[RACSubject alloc] init];
    //2、订阅信号 创建一个新月者 将block保存到订阅者中，将订阅者保存到上面的数组中
    [racsub subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到的信号：%@",x);
    }];
    //3、发送信号 遍历信号对象中的数组，取出订阅对象，调用订阅对象中的block执行，这样就会出发第二部中的block回调
    [racsub sendNext:@"kenshin"];
    
}

//RACSignal的基本使用
- (void)RACSignalBaseFunc{
    //【获得一个信号的方式】

    //单元信号
    RACSignal *signal1 = [RACSignal return:@"some value"];
    RACSignal *signal2 = [RACSignal error:[NSError new]];
    RACSignal *signal3 = [RACSignal empty];
    RACSignal *signal4 = [RACSignal never];
    
    //动态信号
    RACSignal *signal5 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendError:[NSError new]];
        [subscriber sendCompleted];//当执行到sendError之后 下面的就不会执行了
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    
    //桥接方式
    RACSignal *signal6 = [self.view rac_signalForSelector:@selector(setFrame:)];
    RACSignal *signal7 = [self.racBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)];
    RACSignal *signal8 = [self.view rac_willDeallocSignal];
    RACSignal *signal9 = RACObserve(self.view, backgroundColor);
    
    //信号变换
    RACSignal *signal10 = [signal1 map:^id (NSString   *value) {
        return [value substringToIndex:1];;
    }];
    
    //序列转换【用的较少】
    //RACSignal *signal11 = sequence.signal;
    
    //【订阅一个信号的方式】
    //订阅方法
    [signal1 subscribeNext:^(id  _Nullable x) {
            
    }];
    
    [signal2 subscribeNext:^(id  _Nullable x) {
        
    } error:^(NSError * _Nullable error) {
        
    }];
    
    [signal3 subscribeNext:^(id  _Nullable x) {
        
    } error:^(NSError * _Nullable error) {
        
    } completed:^{
        
    }];
    //绑定(也属于桥接)
    RAC(self.view, backgroundColor) = signal10;
    
    //Cocoa桥接
    //下面代码的意思是当出现信号1和2之后会调用setFrame这个方法
    [self.view rac_liftSelector:@selector(myFuncSingalOne:withSignalTwo:) withSignals:signal1, signal2, nil];
    [self.view rac_liftSelector:@selector(myFuncSingalOne:withSignalTwo:) withSignalsFromArray:@[signal3, signal4]];
    [self.view rac_liftSelector:@selector(myFuncSingalOne:withSignalTwo:) withSignalOfArguments:signal5];
    
}

- (void)yFuncSingalOne:(RACSignal *)signal1 withSignalTwo:(RACSignal *)signal2{
    
}

- (void)someCodes{
    //【订阅过程】十分重要
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendCompleted];//当执行到sendError之后 下面的就不会执行了
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"dispose");
        }];
    }];
    
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"next value is %@", x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"get some error:%@", error);
    } completed:^{
        NSLog(@"finished success");
    }];
    
    [disposable dispose];
    
    //元祖————RACTuple
    //元祖RACTuple 是RAC定义的一种数据类型，是NSArray的简化版，
}

@end
