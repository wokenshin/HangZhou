//
//  AppDelegate.m
//  Morning
//
//  Created by kenshin van on 2021/2/10.
//

#import "AppDelegate.h"
#import "MainTabBarVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


/*关于Xcode11新建项目生成的SceneDelegate的兼容处理：
  如果不做iPad的多窗口需求，可以直接删除一些对应配置
  1、删除SceneDelegate文件，其实可删可不删，没用就删了吧
  2、删除info.plist中Application Scene Manifest的配置数据
  3、在Appdelegate中手动添加window，设置根控制器即可
 详细：https://juejin.cn/post/6844903982641446919
*/
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setRootVC];
    return YES;
}

- (void)setRootVC{
    MainTabBarVC *vc = [[MainTabBarVC alloc] init];
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window setRootViewController:vc];
    [_window makeKeyAndVisible];
}

@end
