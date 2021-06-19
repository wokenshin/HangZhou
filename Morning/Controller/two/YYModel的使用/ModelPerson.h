//
//  ModelPerson.h
//  Morning
//
//  Created by kenshin van on 2021/2/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModelPerson : NSObject

@property (nonatomic, assign)int age;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *idCard;

@end

NS_ASSUME_NONNULL_END
