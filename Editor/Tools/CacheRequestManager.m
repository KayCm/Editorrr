//
//  CacheRequestManager.m
//  Editor
//
//  Created by Kai on 2022/3/8.
//

#import "CacheRequestManager.h"

@implementation CacheRequestManager

-(void)saveWithData:(id)data Withkey:(NSString*)key{
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(instancetype)getWithKey:(NSString*)key{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
}

-(void)removeWithkey:(NSString*)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
