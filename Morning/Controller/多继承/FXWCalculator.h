//
//  FXWCalculator.h
//  Morning
//
//  Created by HanKibou on 2021/4/6.
//

#import <Foundation/Foundation.h>
#import "CalculatorOperator.h"

NS_ASSUME_NONNULL_BEGIN

//如果将协议暴露在头文件中，那么也就公开了协议的方法声明，外界可以直接调用，放在.m中，则私有化
@interface FXWCalculator : NSObject<CalculatorOperator>

@end

NS_ASSUME_NONNULL_END
