//
//  ListViewController.m
//  Editor
//
//  Created by Kai on 2022/4/19.
//

#import "ListViewController.h"
#import "VideoEditorViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self viewSetup];
}


-(void)viewSetup{
    
    self.tabBarController.navigationItem.title = @"剪益";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100,100, 100, 30)];
    
    btn.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(gotooo) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)gotooo{
    
    VideoEditorViewController *vvv = [VideoEditorViewController new];
    
    [self.navigationController pushViewController:vvv animated:YES];
    
}

@end
