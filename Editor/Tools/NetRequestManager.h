//
//  NetRequestManager.h
//  NativeVideoTemplet
//
//  Created by KayCM on 2018/1/15.
//  Copyright © 2018年 KayCM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequestManager : NSObject

/**
 POST请求
 
 @param UrlStr 地址
 @param Dict 传入值
 @param SuccessBlock 成功
 @param FailureBlock 失败
 @param ErrorBlock 错误
 */
-(void)RequestWithPostInUrl:(NSString*)                                     UrlStr
                WithPostDict:(NSDictionary*)                                Dict
            WithSuccessBlock:(void(^)   (id NetResultSuccessValue))         SuccessBlock
            WithFailureBlock:(void(^)   (id NetResultFailureValue))         FailureBlock
             WithErrorBlock:(void(^)     (id NetResultFailureValue))        ErrorBlock;

/**
 GET请求
 
 @param UrlStr 地址
 @param Dict 传入值
 @param SuccessBlock 成功
 @param FailureBlock 失败
 @param ErrorBlock 错误
 */
-(void)RequestWithGetInUrl:(NSString*)                                      UrlStr
               WithGetDict:(NSDictionary*)                                  Dict
          WithSuccessBlock:(void(^)     (id NetResultSuccessValue))         SuccessBlock
          WithFailureBlock:(void(^)     (id NetResultFailureValue))         FailureBlock
            WithErrorBlock:(void(^)     (id NetResultFailureValue))         ErrorBlock;

/**
 下载请求
 
 @param UrlStr  地址
 @param Dict 传入值
 @param LoadName 下载保存的文件名 文件名+后缀 如 xxx.mp4
 @param ProgressBlock 下载进度
 @param SuccessBlock 成功
 @param FailureBlock 失败
 @param ErrorBlock 错误
 */
-(void)RequestWithDownLoadInUrl:(NSString*)                                 UrlStr
                    WithGetDict:(NSDictionary*)                             Dict
                   WithLoadName:(NSString*)                                 LoadName
               WithLoadProgress:(void(^)   (id NetResultProgressValue))     ProgressBlock
               WithSuccessBlock:(void(^)   (id NetResultSuccessValue))      SuccessBlock
               WithFailureBlock:(void(^)   (id NetResultFailureValue))      FailureBlock
                 WithErrorBlock:(void(^)   (id NetResultFailureValue))      ErrorBlock;

@end
