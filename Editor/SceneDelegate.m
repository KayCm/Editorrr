//
//  SceneDelegate.m
//  Editor
//
//  Created by Kai on 2022/2/25.
//

#import "SceneDelegate.h"

#import "IndexViewController.h"
#import "MainViewController.h"
#import "MineViewController.h"
#import "UIColor+Extension.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    self.window.frame = windowScene.coordinateSpace.bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    
    UITabBarController *tabbar = [UITabBarController new];
    
    IndexViewController *index = [IndexViewController new];
    index.title = @"首页";
    index.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"index_off"]imageWithRenderingMode:UIImageRenderingModeAutomatic] selectedImage:[[UIImage imageNamed:@"index_on"]imageWithRenderingMode:UIImageRenderingModeAutomatic]];
    
    MineViewController *mine = [MineViewController new];
    mine.title = @"我的";
    mine.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"mine_off"]imageWithRenderingMode:UIImageRenderingModeAutomatic] selectedImage:[[UIImage imageNamed:@"mine_on"]imageWithRenderingMode:UIImageRenderingModeAutomatic]];

    tabbar.viewControllers = @[index,mine];
    
    [tabbar.tabBar setTintColor:[UIColor colorWithHexString:@"#B46DFA"]];
    
    UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:tabbar];
    //Nav.view.backgroundColor = [UIColor colorWithRed:248 green:248 blue:255 alpha:1];
    self.window.rootViewController = Nav;
    
    [self.window makeKeyAndVisible];
    
    
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
