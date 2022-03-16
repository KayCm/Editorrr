//
//  BizStore.h
//  Editor
//
//  Created by Kai on 2022/3/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BizStore : NSObject



/// 发送验证码
/// @param Phone Phone description
/// @param SuccessBlock SuccessBlock description
/// @param FailureBlock FailureBlock description
/// @param ErrorBlock ErrorBlock description
-(void)RequestSendCodeWithPhone:(NSString*)                                 Phone
               WithSuccessBlock:(void(^)   (id NetResultSuccessValue))      SuccessBlock
               WithFailureBlock:(void(^)   (id NetResultFailureValue))      FailureBlock
                 WithErrorBlock:(void(^)   (id NetResultErrorValue))      ErrorBlock;


/// 登陆
/// @param Phone Phone description
/// @param Code Code description
/// @param SuccessBlock SuccessBlock description
/// @param FailureBlock FailureBlock description
/// @param ErrorBlock ErrorBlock description
-(void)RequestLoginWithPhone:(NSString*)                                 Phone
                    WithCode:(NSString*)                                 Code
            WithSuccessBlock:(void(^)   (id NetResultSuccessValue))      SuccessBlock
            WithFailureBlock:(void(^)   (id NetResultFailureValue))      FailureBlock
              WithErrorBlock:(void(^)   (id NetResultErrorValue))      ErrorBlock;



/// 登出
/// @param SuccessBlock SuccessBlock description
/// @param FailureBlock FailureBlock description
/// @param ErrorBlock ErrorBlock description
-(void)RequestLogoutWithSuccessBlock:(void(^)   (id NetResultSuccessValue))      SuccessBlock
                    WithFailureBlock:(void(^)   (id NetResultFailureValue))      FailureBlock
                      WithErrorBlock:(void(^)   (id NetResultErrorValue))      ErrorBlock;




/// 用户信息查询
/// @param SuccessBlock SuccessBlock description
/// @param FailureBlock FailureBlock description
/// @param ErrorBlock ErrorBlock description
-(void)RequestCheckUserWithSuccessBlock:(void(^)   (id NetResultSuccessValue))      SuccessBlock
                       WithFailureBlock:(void(^)   (id NetResultFailureValue))      FailureBlock
                         WithErrorBlock:(void(^)   (id NetResultErrorValue))      ErrorBlock;


/// 用户激活
/// @param CdKey CdKey description
/// @param SuccessBlock SuccessBlock description
/// @param FailureBlock FailureBlock description
/// @param ErrorBlock ErrorBlock description
-(void)RequestActivatingWithCdKey:(NSString*)                                   CdKey
                WithSuccessBlock:(void(^)   (id NetResultSuccessValue))         SuccessBlock
                WithFailureBlock:(void(^)   (id NetResultFailureValue))         FailureBlock
                  WithErrorBlock:(void(^)   (id NetResultErrorValue))           ErrorBlock;



/// 激活状态检查
/// @param SuccessBlock SuccessBlock description
/// @param FailureBlock FailureBlock description
/// @param ErrorBlock ErrorBlock description    
-(void)RequestActivatingCheckWithSuccessBlock:(void(^)   (id NetResultSuccessValue))      SuccessBlock
                             WithFailureBlock:(void(^)   (id NetResultFailureValue))      FailureBlock
                               WithErrorBlock:(void(^)   (id NetResultErrorValue))      ErrorBlock;

@end

NS_ASSUME_NONNULL_END
