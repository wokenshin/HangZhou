//
//  DelObj.h
//  Morning
//
//  Created by HanKibou on 2021/3/21.
//

#import <Foundation/Foundation.h>
#import "FXWDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface DelObj : NSObject//【委托方】

@property (nonatomic, weak) id<FXWDelegate> delegate;

- (void)howOldAreYou;
- (void)whatsYourName;
@end

NS_ASSUME_NONNULL_END
