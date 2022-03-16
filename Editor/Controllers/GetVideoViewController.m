//
//  GetVideoViewController.m
//  Editor
//
//  Created by Kai on 2022/3/7.
//

#import "GetVideoViewController.h"
#import "Masonry.h"
#import "NetRequestManager.h"
#import <SDWebImage/SDWebImage.h>
#import "SVProgressHUD.h"
#import "UIColor+Extension.h"

@interface GetVideoViewController ()

@property(nonatomic,strong)UITextField *textfield;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)NSDictionary *dict;
@end

@implementation GetVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self viewSetup];
}


-(void)viewSetup{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UIButton *close = [UIButton new];
    [close setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    close.backgroundColor = [UIColor colorWithHexString:@"#999999"];
    close.layer.cornerRadius = 11;
    close.layer.masksToBounds = YES;
    [self.view addSubview:close];
    [close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.top.equalTo(self.view.mas_top).with.offset(10);
        make.height.width.equalTo(@22);
    }];
    close.tag = 1;
    [close addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *tvBg = [UIView new];
    
    tvBg.backgroundColor = [UIColor colorWithHexString:@"@e6e6e6"];
    
    [self.view addSubview:tvBg];
    
    [tvBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(close.mas_bottom).with.offset(10);
        make.height.equalTo(@45);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
    }];
    
    UIButton *pasteBtn = [UIButton new];
    [pasteBtn setTitle:@"粘贴" forState:UIControlStateNormal];
    pasteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [pasteBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [tvBg addSubview:pasteBtn];
    
    [pasteBtn addTarget:self action:@selector(pasteUrl2textfield) forControlEvents:UIControlEventTouchUpInside];
    
    [pasteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tvBg.mas_centerY).with.offset(0);
        make.right.equalTo(tvBg.mas_right).with.offset(-10);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];
    
    
    _textfield = [UITextField new];
    _textfield.placeholder =@"请输入抖音链接地址";
    _textfield.clearButtonMode=UITextFieldViewModeWhileEditing;
//    _textfield.layer.borderWidth = 1;
//    _textfield.layer.borderColor = [UIColor darkTextColor].CGColor;
    _textfield.layer.cornerRadius = 5;
    _textfield.layer.masksToBounds = YES;
    _textfield.backgroundColor = [UIColor colorWithHexString:@"@e6e6e6"];
    [tvBg addSubview:_textfield];
    
    [_textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tvBg.mas_centerY).with.offset(0);
        make.height.equalTo(@45);
        make.left.equalTo(tvBg.mas_left).with.offset(10);
        make.right.equalTo(pasteBtn.mas_left).with.offset(-10);
    }];
    
    UIView *border = [UIView new];
    border.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [self.view addSubview:border];
    
    [border mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.top.equalTo(tvBg.mas_bottom).with.offset(5);
    }];
    
    
    UIButton *btn = [UIButton new];
    [btn setTitle:@"下载" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor darkTextColor]];
    btn.layer.cornerRadius = 15;
    btn.layer.masksToBounds = YES;
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(tvBg.mas_bottom).with.offset(30);
        make.height.equalTo(@45);
        make.width.equalTo(@200);
    }];
    
    [btn addTarget:self action:@selector(downloadVideo) forControlEvents:UIControlEventTouchUpInside];
    
    _textView = [UITextView new];
    _textView.editable = NO;
    [self.view addSubview:_textView];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(btn.mas_bottom).with.offset(10);
        make.height.equalTo(@120);
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    _img = [UIImageView new];
    _img.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_img];
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_textView.mas_bottom).with.offset(10);
        make.height.equalTo(self.view.mas_width);
        make.width.equalTo(self.view.mas_width);
    }];
    
    
    UIButton *doneBtn = [UIButton new];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:[UIColor darkTextColor]];
    doneBtn.layer.cornerRadius = 15;
    doneBtn.layer.masksToBounds = YES;
    [self.view addSubview:doneBtn];
    
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_img.mas_bottom).with.offset(15);
        make.height.equalTo(@45);
        make.width.equalTo(@345);
    }];
    
    [doneBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)close:(UIButton*)btn{
    
    if (btn.tag == 1) {
        [self dismissViewControllerAnimated:YES completion:^{
                    
        }];
    }else{
        
        if (_dict) {
            if (self.valueBlock)self.valueBlock(_dict);
        }
        
        [self dismissViewControllerAnimated:YES completion:^{
                    
        }];
        
    }
    
}


-(void)downloadVideo{
    
    
    [SVProgressHUD show];
    
    
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
        
        [weakSelf loadVeidoWithUrl:dict[@"video"][@"url"] WithCover:dict[@"video"][@"cover"]];
        
    } WithFailureBlock:^(id NetResultFailureValue) {
        [SVProgressHUD dismiss];
    } WithErrorBlock:^(id NetResultFailureValue) {
        [SVProgressHUD dismiss];
    }];
    
    
    
    
}

-(void)pasteUrl2textfield{
    
    _textfield.text = [[UIPasteboard generalPasteboard] string];
    
}

-(void)loadVeidoWithUrl:(NSString*)url  WithCover:(NSString*)cover{
    
    [self.view endEditing:YES]; 
    
 
    _textView.text = [NSString stringWithFormat:@"%@\n开始下载视频...",_textView.text];
    
    NSString* fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
    
    __weak typeof(self) weakSelf = self;
    
    NetRequestManager *net = [NetRequestManager new];
    
    NSString *txt = weakSelf.textView.text;
    
    [net RequestWithDownLoadInUrl:url WithGetDict:nil WithLoadName:fileName WithLoadProgress:^(id NetResultProgressValue) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
           // UI更新代码
            weakSelf.textView.text = [NSString stringWithFormat:@"%@...%@%%",txt,NetResultProgressValue];
           
        });
        
        
    } WithSuccessBlock:^(id NetResultSuccessValue) {
        
        NSLog(@"下载完成");
        
        dispatch_async(dispatch_get_main_queue(), ^{
           // UI更新代码
            weakSelf.textView.text = [NSString stringWithFormat:@"%@\n下载完成",weakSelf.textView.text];
            
            [weakSelf.img sd_setImageWithURL:[NSURL URLWithString:cover] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                [SVProgressHUD dismiss];
            }];
            
            [weakSelf.textView setContentOffset:CGPointMake(0.f,weakSelf.textView.contentSize.height-weakSelf.textView.frame.size.height)];
            
            NSString *tmpDir = NSTemporaryDirectory();
            
            weakSelf.dict = @{@"dir":[NSString stringWithFormat:@"%@%@",tmpDir,fileName],
                @"cover":cover};
            
            
        });
        
       
    } WithFailureBlock:^(id NetResultFailureValue) {
        [SVProgressHUD dismiss];
    } WithErrorBlock:^(id NetResultFailureValue) {
        [SVProgressHUD dismiss];
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
