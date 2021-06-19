//
//  YYModelBaseUseVC.m
//  Morning
//
//  Created by kenshin van on 2021/2/13.
//

#import "YYModelBaseUseVC.h"
#import "NSObject+YYModel.h"
#import "ModelPerson.h"

//官网(除了英文版还有中文版介绍)：https://github.com/ibireme/YYModel
@interface YYModelBaseUseVC ()

@end

@implementation YYModelBaseUseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YYModel的简单使用";
    
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    [mDic setObject:@31 forKey:@"age"];
    [mDic setObject:@"kibou" forKey:@"name"];
    [mDic setObject:@"313911762" forKey:@"idCard"];
    
    // 将 JSON (NSData,NSString,NSDictionary) 转换为 Model:
    ModelPerson *model = [ModelPerson yy_modelWithJSON:mDic];
    NSLog(@"%@", model);//无法输出 要重写description方法
    
    // 将 Model 转换为 JSON 对象:
    NSDictionary *json = [model yy_modelToJSONObject];
    NSLog(@"%@", json);
    
    //如果model内嵌套了别的model，YY会自动帮助解析，无需做多余操作。
}


@end
