//
//  GetVideoViewController.m
//  Editor
//
//  Created by Kai on 2022/3/7.
//

#import "GetVideoViewController.h"
#import "Masonry.h"
#import "NetRequestManager.h"

@interface GetVideoViewController ()

@property(nonatomic,strong)UITextField *textfield;
@property(nonatomic,strong)UITextView *textView;

@end

@implementation GetVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self viewSetup];
}


-(void)viewSetup{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _textfield = [UITextField new];
    _textfield.placeholder =@"请输入抖音链接地址";
//    _textfield.layer.borderWidth = 1;
//    _textfield.layer.borderColor = [UIColor darkTextColor].CGColor;
    _textfield.layer.cornerRadius = 5;
    _textfield.layer.masksToBounds = YES;
    _textfield.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_textfield];
    
    [_textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(30);
        make.height.equalTo(@45);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
    }];
    
    UIButton *btn = [UIButton new];
    [btn setTitle:@"下载" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor darkTextColor]];
    btn.layer.cornerRadius = 15;
    btn.layer.masksToBounds = YES;
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_textfield.mas_bottom).with.offset(30);
        make.height.equalTo(@45);
        make.width.equalTo(@200);
    }];
    
    [btn addTarget:self action:@selector(downloadVideo) forControlEvents:UIControlEventTouchUpInside];
    
    _textView = [UITextView new];
    _textView.editable = NO;
    [self.view addSubview:_textView];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(btn.mas_bottom).with.offset(30);
        make.height.equalTo(@200);
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
}


-(void)downloadVideo{
    
    NSString *linkText = _textfield.text;
    
    NSString *loadUrl = @"";
        
    NSError *error;
    NSDataDetector *dataDetector=[NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
    NSArray *arrayOfAllMatches=[dataDetector matchesInString:linkText options:NSMatchingReportProgress range:NSMakeRange(0, linkText.length)];
    //NSMatchingOptions匹配方式也有好多种，我选择NSMatchingReportProgress，一直匹配

    //我们得到一个数组，这个数组中NSTextCheckingResult元素中包含我们要找的URL的range，当然可能找到多个URL，找到相应的URL的位置，用YYlabel的高亮点击事件处理跳转网页
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
       NSLog(@"%@",NSStringFromRange(match.range));
       NSLog(@"%@",[linkText substringWithRange:match.range]);
        
        loadUrl = [linkText substringWithRange:match.range];
    }

    
    if ([loadUrl isEqualToString:@""]) {
        return;
    }
    
    _textView.text = @"开始解析视频...";

    NSString *url = @"https://www.devtool.top/api/douyin/parse";
    
    NSDictionary *dict = @{@"url":loadUrl};
    
     
    
    __weak typeof(self) weakSelf = self;
    
    NetRequestManager *net = [NetRequestManager new];
    
    [net RequestWithGetInUrl:url WithGetDict:dict WithSuccessBlock:^(id NetResultSuccessValue) {
        
        NSDictionary *dict = NetResultSuccessValue;
        
        weakSelf.textView.text = [NSString stringWithFormat:@"%@\n视频解析成功...",weakSelf.textView.text];
        
        weakSelf.textView.text = [NSString stringWithFormat:@"%@\n%@",weakSelf.textView.text,dict[@"title"]];
        
        NSLog(@"请求url：%@", dict[@"video"][@"url"]);
        
        [weakSelf loadVeidoWithUrl:dict[@"video"][@"url"]];
        
    } WithFailureBlock:^(id NetResultFailureValue) {
        
    } WithErrorBlock:^(id NetResultFailureValue) {
            
    }];
    
    
}

-(void)loadVeidoWithUrl:(NSString*)url{
    
 
    _textView.text = [NSString stringWithFormat:@"%@\n开始下载视频...",_textView.text];
    
    NSString* fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
    
    __weak typeof(self) weakSelf = self;
    
    NetRequestManager *net = [NetRequestManager new];
    
    [net RequestWithDownLoadInUrl:url WithGetDict:nil WithLoadName:fileName WithLoadProgress:^(id NetResultProgressValue) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
           // UI更新代码
            weakSelf.textView.text = [NSString stringWithFormat:@"%@...%@%%",weakSelf.textView.text,NetResultProgressValue];
           
        });
        
        
    } WithSuccessBlock:^(id NetResultSuccessValue) {
        
        NSLog(@"下载完成111");
        
        dispatch_async(dispatch_get_main_queue(), ^{
           // UI更新代码
            weakSelf.textView.text = [NSString stringWithFormat:@"%@\n下载完成",weakSelf.textView.text];
        });
        
       
    } WithFailureBlock:^(id NetResultFailureValue) {
        
    } WithErrorBlock:^(id NetResultFailureValue) {
        
    }];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
