//
//  AppDelegate+SVProgressHUD.m
//  Editor
//
//  Created by Kai on 2022/2/25.
//

#import "AppDelegate+SVProgressHUD.h"
#import "SceneDelegate.h"
@implementation AppDelegate (SVProgressHUD)
-(UIWindow*)window{
    
    UIWindowScene *scene = (UIWindowScene*)[[[[UIApplication sharedApplication] connectedScenes] allObjects] firstObject];
    
    SceneDelegate *scDelegate = (SceneDelegate*)scene.delegate;
    
    return scDelegate.window ?:nil;
    
}
@end
