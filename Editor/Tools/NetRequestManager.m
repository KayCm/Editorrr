//
//  NetRequestManager.m
//  NativeVideoTemplet
//
//  Created by KayCM on 2018/1/15.
//  Copyright © 2018年 KayCM. All rights reserved.
//

#import "NetRequestManager.h"
#import "AFNetworking.h"

@implementation NetRequestManager

-(void)RequestWithPostInUrl:(NSString *)UrlStr WithPostDict:(NSDictionary *)Dict WithSuccessBlock:(void (^)(id))SuccessBlock WithFailureBlock:(void (^)(id))FailureBlock WithErrorBlock:(void (^)(id))ErrorBlock{
    
    /* 创建网络请求对象 */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /* Timeout */
    manager.requestSerializer.timeoutInterval = 8.f;
    /* 设置请求和接收的数据编码格式 */
    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 设置请求数据为 JSON 数据
    /* 设置请求头 */
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager.requestSerializer setValue:@"token" forHTTPHeaderField:@"token"];
    
    [manager POST:UrlStr parameters:Dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseObject;
        if ([responseObject[@"code"] intValue] == 0) {
            if (SuccessBlock) SuccessBlock(httpResponse);
        }else{
            if (FailureBlock) FailureBlock(httpResponse);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error)ErrorBlock(error);
    }];
    
}

-(void)RequestWithPostInUrl:(NSString *)UrlStr WithToken:(NSString *)token WithPostDict:(NSDictionary *)Dict WithSuccessBlock:(void (^)(id))SuccessBlock WithFailureBlock:(void (^)(id))FailureBlock WithErrorBlock:(void (^)(id))ErrorBlock{
    
    /* 创建网络请求对象 */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /* Timeout */
    manager.requestSerializer.timeoutInterval = 8.f;
    /* 设置请求和接收的数据编码格式 */
    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 设置请求数据为 JSON 数据
    /* 设置请求头 */
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
    [manager POST:UrlStr parameters:Dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseObject;
        if ([responseObject[@"code"] intValue] == 0) {
            if (SuccessBlock) SuccessBlock(httpResponse);
        }else{
            if (FailureBlock) FailureBlock(httpResponse);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error)ErrorBlock(error);
    }];
    
}

-(void)RequestWithGetInUrl:(NSString *)UrlStr WithGetDict:(NSDictionary *)Dict WithSuccessBlock:(void (^)(id))SuccessBlock WithFailureBlock:(void (^)(id))FailureBlock WithErrorBlock:(void (^)(id))ErrorBlock{
    
    /* 创建网络请求对象 */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /* Timeout */
    manager.requestSerializer.timeoutInterval = 10;
    /* 设置请求和接收的数据编码格式 */
    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 设置请求数据为 JSON 数据
    /* 设置请求头 */
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:UrlStr parameters:Dict headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"请求成功：%@", responseObject);
        
        NSDictionary *dict = responseObject;
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseObject;

        if ([[NSString stringWithFormat:@"%@",dict[@"code"]] isEqualToString:@"200"]) {

            if (SuccessBlock) SuccessBlock(dict[@"data"]);

        }else{

            if (FailureBlock) FailureBlock(httpResponse);

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败：%@", error);
    }];
    
//    [manager GET:UrlStr parameters:Dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        //NSLog(@"请求成功：%@", responseObject);
//
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseObject;
//
//        if (httpResponse) {
//
//            if (SuccessBlock) SuccessBlock(httpResponse);
//
//        }else{
//
//            if (FailureBlock) FailureBlock(httpResponse);
//
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        NSLog(@"请求失败：%@", error);
//        if(error)ErrorBlock(error);
//    }];
}

-(void)RequestWithDownLoadInUrl:(NSString *)UrlStr WithGetDict:(NSDictionary *)Dict WithLoadName:(NSString *)LoadName WithLoadProgress:(void (^)(id))ProgressBlock WithSuccessBlock:(void (^)(id))SuccessBlock WithFailureBlock:(void (^)(id))FailureBlock WithErrorBlock:(void (^)(id))ErrorBlock
{

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURL *url = [NSURL URLWithString:UrlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    
    NSString *filePath = [path stringByAppendingPathComponent:LoadName];
    
    
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"下载进度：%.0f％", downloadProgress.fractionCompleted * 100);
    
        
        if (ProgressBlock) ProgressBlock([NSString stringWithFormat:@"%.0f", downloadProgress.fractionCompleted * 100]);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        /* 设定下载到的位置 */
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        NSLog(@"下载完成");

        if (error) {
            
            if (ErrorBlock) ErrorBlock(error);
            
        }else{
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            
            if (httpResponse.statusCode == 200) {
                
                if (SuccessBlock) SuccessBlock(httpResponse);
                
            }else{
                
                if (FailureBlock) FailureBlock(httpResponse);
                
            }
        }

    }];
    
    [downloadTask resume];
    
}

@end

