//
//  BizStore.m
//  Editor
//
//  Created by Kai on 2022/3/9.
//

#import "BizStore.h"
#import "NetRequestManager.h"
#import "CacheRequestManager.h"

@implementation BizStore

-(void)RequestSendCodeWithPhone:(NSString *)Phone WithSuccessBlock:(void (^)(id _Nonnull))SuccessBlock WithFailureBlock:(void (^)(id _Nonnull))FailureBlock WithErrorBlock:(void (^)(id _Nonnull))ErrorBlock{
    
    NSDictionary *dict = @{@"phone":Phone};
    
    NSString *url = @"http://jy.nodewebapp.com/member/sendVerifyCode";
    
    NetRequestManager *net = [NetRequestManager new];
    
    [net RequestWithPostInUrl:url WithPostDict:dict WithSuccessBlock:^(id NetResultSuccessValue) {
        //NSLog(@"%@",NetResultSuccessValue);
        if (SuccessBlock) SuccessBlock(NetResultSuccessValue[@"data"]);
    } WithFailureBlock:^(id NetResultFailureValue) {
        //NSLog(@"%@",NetResultFailureValue);
        if (FailureBlock) FailureBlock(NetResultFailureValue);
    } WithErrorBlock:^(id NetResultErrorValue) {
        //NSLog(@"%@",NetResultErrorValue);
        if (FailureBlock) FailureBlock(NetResultErrorValue);
    }];
}

-(void)RequestLoginWithPhone:(NSString *)Phone WithCode:(NSString *)Code WithSuccessBlock:(void (^)(id _Nonnull))SuccessBlock WithFailureBlock:(void (^)(id _Nonnull))FailureBlock WithErrorBlock:(void (^)(id _Nonnull))ErrorBlock{
    
    NSDictionary *dict = @{@"phone":Phone,@"verificationCode":Code};
    
    NSString *url = @"http://jy.nodewebapp.com/member/login";
    
    NetRequestManager *net = [NetRequestManager new];
    
    [net RequestWithPostInUrl:url WithPostDict:dict WithSuccessBlock:^(id NetResultSuccessValue) {
        //NSLog(@"%@",NetResultSuccessValue);
        if (SuccessBlock) SuccessBlock(NetResultSuccessValue[@"data"]);
    } WithFailureBlock:^(id NetResultFailureValue) {
        //NSLog(@"%@",NetResultFailureValue);
        if (FailureBlock) FailureBlock(NetResultFailureValue);
    } WithErrorBlock:^(id NetResultErrorValue) {
        //NSLog(@"%@",NetResultErrorValue);
        if (FailureBlock) FailureBlock(NetResultErrorValue);
    }];
    
    
}

-(void)RequestLogoutWithSuccessBlock:(void (^)(id _Nonnull))SuccessBlock WithFailureBlock:(void (^)(id _Nonnull))FailureBlock WithErrorBlock:(void (^)(id _Nonnull))ErrorBlock{
    
    CacheRequestManager *cache = [CacheRequestManager new];
    NSString *token = (NSString*)[cache getWithKey:@"token"];
    
    NSString *url = @"http://jy.nodewebapp.com/member/logout";
    
    NetRequestManager *net = [NetRequestManager new];
    
    [net RequestWithPostInUrl:url WithToken:token WithPostDict:nil WithSuccessBlock:^(id NetResultSuccessValue) {
        NSLog(@"%@",NetResultSuccessValue);
        if (SuccessBlock) SuccessBlock(NetResultSuccessValue[@"data"]);
    } WithFailureBlock:^(id NetResultFailureValue) {
        //NSLog(@"%@",NetResultFailureValue);
        if (FailureBlock) FailureBlock(NetResultFailureValue);
    } WithErrorBlock:^(id NetResultErrorValue) {
        //NSLog(@"%@",NetResultErrorValue);
        if (FailureBlock) FailureBlock(NetResultErrorValue);
    }];
    
}

-(void)RequestCheckUserWithSuccessBlock:(void (^)(id _Nonnull))SuccessBlock WithFailureBlock:(void (^)(id _Nonnull))FailureBlock WithErrorBlock:(void (^)(id _Nonnull))ErrorBlock{
    
    CacheRequestManager *cache = [CacheRequestManager new];
    NSString *token = (NSString*)[cache getWithKey:@"token"];
    
    NSString *url = @"http://jy.nodewebapp.com/member/getMemberInfo";
    
    NetRequestManager *net = [NetRequestManager new];
    
    [net RequestWithPostInUrl:url WithToken:token WithPostDict:nil WithSuccessBlock:^(id NetResultSuccessValue) {
        NSLog(@"%@",NetResultSuccessValue);
        if (SuccessBlock) SuccessBlock(NetResultSuccessValue[@"data"]);
    } WithFailureBlock:^(id NetResultFailureValue) {
        //NSLog(@"%@",NetResultFailureValue);
        if (FailureBlock) FailureBlock(NetResultFailureValue);
    } WithErrorBlock:^(id NetResultErrorValue) {
        //NSLog(@"%@",NetResultErrorValue);
        if (FailureBlock) FailureBlock(NetResultErrorValue);
    }];
    
}

-(void)RequestActivatingWithCdKey:(NSString *)CdKey WithSuccessBlock:(void (^)(id _Nonnull))SuccessBlock WithFailureBlock:(void (^)(id _Nonnull))FailureBlock WithErrorBlock:(void (^)(id _Nonnull))ErrorBlock{
    
    CacheRequestManager *cache = [CacheRequestManager new];
    NSString *token = (NSString*)[cache getWithKey:@"token"];
    
    NSString *url = @"http://jy.nodewebapp.com/member/activation";
    
    NSDictionary *dict = @{@"cdKey":CdKey};
    
    NetRequestManager *net = [NetRequestManager new];
    
    [net RequestWithPostInUrl:url WithToken:token WithPostDict:dict WithSuccessBlock:^(id NetResultSuccessValue) {
        NSLog(@"%@",NetResultSuccessValue);
        if (SuccessBlock) SuccessBlock(NetResultSuccessValue[@"data"]);
    } WithFailureBlock:^(id NetResultFailureValue) {
        NSLog(@"%@",NetResultFailureValue);
        if (FailureBlock) FailureBlock(NetResultFailureValue);
    } WithErrorBlock:^(id NetResultErrorValue) {
        NSLog(@"%@",NetResultErrorValue);
        if (FailureBlock) FailureBlock(NetResultErrorValue);
    }];
    
}


-(void)RequestActivatingCheckWithSuccessBlock:(void (^)(id _Nonnull))SuccessBlock WithFailureBlock:(void (^)(id _Nonnull))FailureBlock WithErrorBlock:(void (^)(id _Nonnull))ErrorBlock{
    
    
    CacheRequestManager *cache = [CacheRequestManager new];
    NSString *token = (NSString*)[cache getWithKey:@"token"];
    
    NSString *url = @"http://jy.nodewebapp.com/member/getActiveStatus";
    
    NetRequestManager *net = [NetRequestManager new];
    
    [net RequestWithPostInUrl:url WithToken:token WithPostDict:nil WithSuccessBlock:^(id NetResultSuccessValue) {
        NSLog(@"%@",NetResultSuccessValue);
        if (SuccessBlock) SuccessBlock(NetResultSuccessValue[@"data"]);
    } WithFailureBlock:^(id NetResultFailureValue) {
        NSLog(@"%@",NetResultFailureValue);
        if (FailureBlock) FailureBlock(NetResultFailureValue);
    } WithErrorBlock:^(id NetResultErrorValue) {
        NSLog(@"%@",NetResultErrorValue);
        if (FailureBlock) FailureBlock(NetResultErrorValue);
    }];
    
}

@end
