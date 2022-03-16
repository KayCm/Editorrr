//
//  AgreementViewController.m
//  Editor
//
//  Created by Kai on 2022/3/15.
//

#import "AgreementViewController.h"
#import "Masonry.h"
#import "UIColor+Extension.h"

@interface AgreementViewController ()

@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    if (_type == 1) {
        self.title = @"注册协议";
    }else{
        self.title = @"隐私政策";
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self viewSetup];
}

-(void)viewSetup{
    
    
    CGFloat navBar_Height =  self.navigationController.navigationBar.frame.size.height;
    UIWindow *window = [UIApplication.sharedApplication.windows firstObject];
    NSLog(@"top == %f",window.safeAreaInsets.top);
    
    UILabel *lbl = [UILabel new];
    lbl.font = [UIFont boldSystemFontOfSize:30];
    [self.view addSubview:lbl];
    
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.top.equalTo(self.view.mas_top).with.offset(window.safeAreaInsets.top+navBar_Height+10);
        make.height.equalTo(@0);
        
    }];
    
    
    UITextView *textView = [UITextView new];
    textView.editable = NO;
    textView.showsVerticalScrollIndicator = NO;
    textView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:textView];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.top.equalTo(lbl.mas_bottom).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
    }];
    
    
    
    if (_type == 1) {
        
//        lbl.text = @"注册协议";
        
        NSError *error;
           NSString *textFieldContents=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"argee" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
           NSLog(@"--textFieldContents---%@-----",textFieldContents);
           if (textFieldContents==nil) {
               NSLog(@"---error--%@",[error localizedDescription]);
           }
        
        textView.text = textFieldContents;
        
        
    }else{
        
//        lbl.text = @"隐私政策";
        
        NSError *error;
           NSString *textFieldContents=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"argee1" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
           NSLog(@"--textFieldContents---%@-----",textFieldContents);
           if (textFieldContents==nil) {
               NSLog(@"---error--%@",[error localizedDescription]);
           }
        
        textView.text = textFieldContents;
        
        
        
    }
    
}


@end
