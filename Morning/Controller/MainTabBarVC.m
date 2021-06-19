//
//  MainTabBarVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "MainTabBarVC.h"

#import "OneVC.h"
#import "TwoVC.h"
#import "ThreeVC.h"
#import "FourVC.h"
/*
 遇到的坑
 设置导航栏标题 覆盖了 底部tabbarItem标题 from：https://www.jianshu.com/p/3c40eb224197
 核心Api问题，
 self.navigationItem.title = @"my title";(只设置导航控制器标题)
 self.tabBarItem.title= @"my title";(只设置底部四大金刚标题)
 self.title= @"my title";(两者都会设置,并且只要你调用会覆盖上面两者设置的值)
 
 【多了一个导航栏】
 原因：在使用UITabBarController的时候，从AppDelegate.m中设置根控制器的时候，又在其外部套了一层导航栏控制器。效果图可以自己设置一下就知道了。
 傻逼代码如下：
 
 MainTabBarVC *vc = [[MainTabBarVC alloc] init];
 UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:vc];
 _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
 [_window setRootViewController:nv];
 [_window setBackgroundColor:[UIColor whiteColor]];
 [_window makeKeyAndVisible];
 
 写成下面的形式就正常了
 MainTabBarVC *vc = [[MainTabBarVC alloc] init];
 UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:vc];
 _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
 [_window setRootViewController:nv];
 [_window makeKeyAndVisible];
 
 造成这个问题的原因是之前最初写根控制器的时候习惯了要使用导航控制器作为基础来承载普通控制器，结果后面不假思索造成了这个傻逼错误。还以为出bug了，想了很久才发现是这个原因，特此记录。
 */
@interface MainTabBarVC ()

@end

@implementation MainTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainUI];
    [self disableDarkMode];//tabVC禁用暗黑模式，
}

- (void)disableDarkMode {
    if (@available(iOS 13.0, *)) {
        //只会让tabbar的背景色和内部的vc禁用，顶部的导航栏并没有被禁用
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;//不使用暗黑模式
    } else {
        // Fallback on earlier versions
    }//
}

#pragma mark initMainUI
- (void)initMainUI {
    //必须的两个属性设置[如果没有 nav就没有返回 和 title了]
    self.navigationController.navigationBarHidden = YES;
    self.hidesBottomBarWhenPushed = NO;
    
    OneVC *oneVC = [[OneVC alloc] init];
    TwoVC *twoVC = [[TwoVC alloc] init];
    ThreeVC *threeVC = [[ThreeVC alloc] init];
    FourVC *fourVC = [[FourVC alloc] init];
    
    //返回四个导航控制器
    UINavigationController *navHome = [self subNavOfTabBarVCWith:@"杂乱"
                                                  viewController:oneVC
                                                       imageName:@"wb_home"
                                               selectedImageName:@"wb_home_selected"];
    
    UINavigationController *navExpert = [self subNavOfTabBarVCWith:@"App"
                                                    viewController:twoVC
                                                         imageName:@"wb_message_center"
                                                 selectedImageName:@"wb_message_center_selected"];
    
    UINavigationController *navQuestions = [self subNavOfTabBarVCWith:@"进阶"
                                                       viewController:threeVC
                                                            imageName:@"wb_discover"
                                                    selectedImageName:@"wb_discover_selected"];
    
    UINavigationController *navMine = [self subNavOfTabBarVCWith:@"高级"
                                                  viewController:fourVC
                                                       imageName:@"wb_profile"
                                               selectedImageName:@"wb_profile_selected"];
    
    
    //设置TabBarVC的四个子控制器
    self.viewControllers = [NSArray arrayWithObjects:navHome, navExpert, navQuestions, navMine, nil];
    
}

#pragma mark 创建TabBarVC 的子控制器 并设置为Nav
-(UINavigationController *)subNavOfTabBarVCWith:(NSString *)title
                                 viewController:(UIViewController *)viewController
                                      imageName:(NSString *)imageName
                              selectedImageName:(NSString *)selectedImageName {
    
    //IOS 7以上要设置图片渲染模式
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//禁止渲染
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//禁止渲染
    
    viewController.hidesBottomBarWhenPushed = NO;//当进入到viewController时 是否要隐藏底部的 bar
    
    UINavigationController *navViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
    
    
    //下面如果不设置 选中和未选中状态颜色，系统会给出默认设置
    //设置Tab选中时文本文字颜色
    [navViewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}
                                                forState:UIControlStateSelected];
    
    //设置Tab未选中时颜色
    [navViewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}
                                                forState:UIControlStateNormal];
    
    if(image == nil || viewController == nil){
        navViewController.tabBarItem.enabled = NO;
    }
    return navViewController;
    
}

- (void)dealloc {
    FXWLog(@"-------->>>释放了:%@ ", NSStringFromClass([self class]));
}

@end
