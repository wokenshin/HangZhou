//
//  FXW_Define.h
//  Laboratory
//
//  Created by mac on 2019/6/21.
//  Copyright © 2019 mac. All rights reserved.
//

#ifndef FXW_Define_h
#define FXW_Define_h


//weakSelf 定义一个self的弱引用  等同于 __weak typeof(self) weakSelf = self;
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//获取手机屏幕的宽、高
#define screenWidth  [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

//RGB 取色
#define FXW_RGBColor(r,g,b) ([UIColor colorWithRed:(r * 1.0 /255) green:g * 1.0/255 blue:b * 1.0/255 alpha:1.0])
//16进制 Hex 取色
#define FXW_HEXColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//输出简单日志
#ifdef DEBUG
#define FXWLog(FORMAT,...)fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT,##__VA_ARGS__]UTF8String]);
#else
#define FXWLog(...)
#endif

//@weakify和@strongify语句是在Extended Objective-C库中定义的宏，它们也包含在ReactiveCocoa中
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif


#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#endif /* FXW_Define_h */
