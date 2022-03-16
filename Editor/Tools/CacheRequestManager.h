//
//  CacheRequestManager.h
//  Editor
//
//  Created by Kai on 2022/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CacheRequestManager : NSObject

-(void)saveWithData:(id)data Withkey:(NSString*)key;

-(instancetype)getWithKey:(NSString*)key;

-(void)removeWithkey:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
