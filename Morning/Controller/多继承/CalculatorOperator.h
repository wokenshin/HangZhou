//
//  CalculatorOperator.h
//  Morning
//
//  Created by HanKibou on 2021/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//加法
@protocol AddOperator <NSObject>
- (double)addWithA:(double)a andB:(double)b;
@end

//减法
@protocol SubOperator <NSObject>
- (double)subWithA:(double)a andB:(double)b;
@end

//乘法
@protocol MulOperator <NSObject>
- (double)mulWithA:(double)a andB:(double)b;
@end

//这里实现了“多继承”，继承多个方法的声明，实现需要在实现文件中自己实现
@protocol CalculatorOperator <AddOperator, SubOperator, MulOperator>

@end

NS_ASSUME_NONNULL_END
