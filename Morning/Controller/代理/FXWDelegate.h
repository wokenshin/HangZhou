//
//  FXWDelegate.h
//  Morning
//
//  Created by HanKibou on 2021/3/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FXWDelegate <NSObject>//【协议】
@optional
- (NSInteger)age;
- (void)printMyName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
