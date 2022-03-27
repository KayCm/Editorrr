//
//  LoginViewController.m
//  Editor
//
//  Created by Kai on 2022/3/8.
//

#import "LoginViewController.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "UIButton+Gradient.h"
#import "CacheRequestManager.h"
#import "BizStore.h"
#import "SVProgressHUD.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *loginField;
@property(nonatomic,strong)UITextField *codeField;
@property(nonatomic,strong)UIButton *codeBtn;
@property(nonatomic,strong)UIButton *selecgBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self viewSetup];
    
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
}


-(void)viewSetup{
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#000000"];
    
    
    UIButton *close = [UIButton new];
    [close setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self.view addSubview:close];
    
    [close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@18);
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [close addTarget:self action:@selector(closeVc) forControlEvents:UIControlEventTouchUpInside];

    
    
    UILabel *title = [UILabel new];
    title.text = @"欢迎登陆～";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont boldSystemFontOfSize:30];
    [self.view addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(36);
        make.top.equalTo(self.view.mas_top).with.offset(88);
        make.height.equalTo(@38);
        make.width.equalTo(@200);
    }];
    
    
    UIView *phoneView = [UIView new];
    [self.view addSubview:phoneView];
    
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(48.5);
        make.right.equalTo(self.view.mas_right).with.offset(-48.5);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@60);
        make.top.equalTo(title.mas_bottom).with.offset(60);
    }];
    
    
    UIImageView *iconPhone = [UIImageView new];
    iconPhone.image = [UIImage imageNamed:@"icon_phone"];
    [phoneView addSubview:iconPhone];
    
    [iconPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@13.5);
        make.height.equalTo(@15);
        make.left.equalTo(phoneView.mas_left);
        make.centerY.equalTo(phoneView.mas_centerY).with.offset(5);
    }];
    
    _codeBtn = [UIButton new];
    _codeBtn.backgroundColor = [UIColor colorWithHexString:@"#B46DFA"];
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _codeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    _codeBtn.layer.cornerRadius = 33/2;
    [phoneView addSubview:_codeBtn];
    
    [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@90);
        make.height.equalTo(@33);
        make.right.equalTo(phoneView.mas_right);
        make.centerY.equalTo(phoneView.mas_centerY).with.offset(5);
    }];
    
    [_codeBtn addTarget:self action:@selector(drawVerifyCodeCountdownUI:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _loginField = [UITextField new];
    _loginField.textColor = [UIColor whiteColor];
    _loginField.placeholder =@"请输入手机号";
    _loginField.clearButtonMode=UITextFieldViewModeWhileEditing;
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#ffffff" alpha:0.6]}];
    _loginField.attributedPlaceholder = placeholderString;
    [phoneView addSubview:_loginField];

    _loginField.keyboardType = UIKeyboardTypeNumberPad;
    
    _loginField.delegate = self;
    
    [_loginField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconPhone.mas_right).with.offset(10);
        make.centerY.equalTo(iconPhone.mas_centerY);
        make.right.equalTo(_codeBtn.mas_left);
    }];
    


    
    UIView *phoneViewBorder = [UIView new];
    phoneViewBorder.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [phoneView addSubview:phoneViewBorder];
    [phoneViewBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(phoneView);
        make.bottom.equalTo(phoneView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    
    
    
    
    UIView *codeView = [UIView new];
    [self.view addSubview:codeView];
    
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(48.5);
        make.right.equalTo(self.view.mas_right).with.offset(-48.5);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@60);
        make.top.equalTo(phoneView.mas_bottom).with.offset(20);
    }];
    
    UIImageView *iconCode = [UIImageView new];
    iconCode.image = [UIImage imageNamed:@"icon_code"];
    [codeView addSubview:iconCode];
    
    [iconCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@13.5);
        make.height.equalTo(@15);
        make.left.equalTo(codeView.mas_left);
        make.centerY.equalTo(codeView.mas_centerY).with.offset(5);
    }];
    
    _codeField = [UITextField new];
    _codeField.textColor = [UIColor whiteColor];
    _codeField.placeholder =@"请输入验证码";
    _codeField.clearButtonMode=UITextFieldViewModeWhileEditing;
    NSMutableAttributedString *codePlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#ffffff" alpha:0.6]}];
    _codeField.attributedPlaceholder = codePlaceholderString;
    [codeView addSubview:_codeField];

    _codeField.keyboardType = UIKeyboardTypeNumberPad;
    
    _codeField.delegate = self;
    
    [_codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconCode.mas_right).with.offset(10);
        make.centerY.equalTo(iconCode.mas_centerY);
        make.right.equalTo(codeView.mas_right);
    }];
    
    UIView *codeViewBorder = [UIView new];
    codeViewBorder.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [codeView addSubview:codeViewBorder];
    [codeViewBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(codeView);
        make.bottom.equalTo(codeView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    

    
    UIView *txtView = [UIView new];
//    txtView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:txtView];
    
    [txtView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(self.view.mas_left).with.offset(48.5);
        make.right.equalTo(self.view.mas_right).with.offset(-48.5);
        make.top.equalTo(codeView.mas_bottom).with.offset(44);
    }];
    
    
    _selecgBtn = [UIButton new];
    [_selecgBtn setImage: [UIImage imageNamed:@"Selected_off"] forState:UIControlStateNormal];
    [_selecgBtn setImage: [UIImage imageNamed:@"Selected_on"] forState:UIControlStateSelected];
    [txtView addSubview:_selecgBtn];
    [_selecgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.left.equalTo(txtView.mas_left);
        make.centerY.equalTo(txtView.mas_centerY).with.offset(0);
    }];
    
    [_selecgBtn addTarget:self action:@selector(argeeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *lbl = [UILabel new];
    lbl.textColor = [UIColor colorWithHexString:@"#DDDDDD"];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"已阅读并同意《注册协议》《隐私政策》"attributes: @{NSFontAttributeName: [UIFont systemFontOfSize: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0]}];
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:180/255.0 green:109/255.0 blue:250/255.0 alpha:1.000000]} range:NSMakeRange(6, 12)];
    lbl.attributedText = string;
    [self.view addSubview:lbl];
    
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selecgBtn.mas_right).with.offset(10);
        make.centerY.equalTo(_selecgBtn.mas_centerY);
        make.right.equalTo(txtView.mas_right);
    }];
    
    
    
    UIButton *commitBtn = [UIButton new];
    [commitBtn setTitle:@"登 陆" forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    commitBtn.layer.cornerRadius = 5;
    commitBtn.layer.masksToBounds = YES;
    [self.view addSubview:commitBtn];
    [commitBtn gradientButtonWithSize:CGSizeMake(278, 44) colorArray:@[[UIColor colorWithHexString:@"#4DCBFF"],[UIColor colorWithHexString:@"#BE4EFF"]] percentageArray:@[@(0.1),@(1)] gradientType:GradientFromLeftToRight];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.width.equalTo(@278);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(txtView.mas_bottom).with.offset(24);
    }];
    
    [commitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)argeeBtn:(UIButton*)btn{
    [btn setSelected:!btn.selected];
}

-(void)commit{
    

    if (_loginField.text.length != 11) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"手机号不正确"];
        return;
    }
    
    if (_codeField.text.length != 6) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"验证码不正确"];
        return;
    }
    
    if (!_selecgBtn.selected) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请同意注册协议和隐私政策"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    BizStore *biz = [BizStore new];
    
    [biz RequestLoginWithPhone:_loginField.text WithCode:_codeField.text WithSuccessBlock:^(id  _Nonnull NetResultSuccessValue) {

        CacheRequestManager *cache = [CacheRequestManager new];
        [cache saveWithData:[NSString stringWithFormat:@"%@",NetResultSuccessValue] Withkey:@"token"];
        [cache saveWithData:[NSString stringWithFormat:@"%@",weakSelf.loginField.text] Withkey:@"phone"];
        [self dismissViewControllerAnimated:YES completion:^{
           
        }];
        
    } WithFailureBlock:^(id  _Nonnull NetResultFailureValue) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:NetResultFailureValue[@"message"]];
    } WithErrorBlock:^(id  _Nonnull NetResultErrorValue) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:NetResultErrorValue[@"message"]];
    }];
    
    
    

    
}

-(void)closeVc{

    [self dismissViewControllerAnimated:YES completion:^{
            
    }];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (textField == self.codeField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.codeField.text.length >= 6) {
            self.codeField.text = [textField.text substringToIndex:6];
            return NO;
        }
    }else if(textField == self.loginField){
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.loginField.text.length >= 11) {
            self.loginField.text = [textField.text substringToIndex:11];
            return NO;
        }
    }

    return YES;

}

#pragma mark -  验证码倒计时验证码60s（连续快速点击）
/** 验证码倒计时UI绘制 */
- (void)drawVerifyCodeCountdownUI:(UIButton *)sender {
    
    if (_loginField.text.length != 11) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"手机号不正确"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    BizStore *biz = [BizStore new];
    
    [biz RequestSendCodeWithPhone:_loginField.text WithSuccessBlock:^(id  _Nonnull NetResultSuccessValue) {
        
        __block int timeout = 59; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if (timeout <= 0) { //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [sender setTitle:@"重新获取" forState:UIControlStateNormal];
                    sender.backgroundColor = [UIColor colorWithHexString:@"#B46DFA"];
                    sender.userInteractionEnabled = YES;
                });
            } else {
                int seconds = timeout;
                NSString *strTime = [NSString stringWithFormat:@"%.02d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //让按钮变为不可点击的灰色
                    sender.backgroundColor = [UIColor grayColor];
                    sender.userInteractionEnabled = NO;
                    //设置界面的按钮显示 根据自己需求设置
    //                [UIView beginAnimations:nil context:nil];
    //                [UIView setAnimationDuration:1];
                    [sender setTitle:[NSString stringWithFormat:@"00:%@",strTime] forState:UIControlStateNormal];
    //                [UIView commitAnimations];
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
        
    } WithFailureBlock:^(id  _Nonnull NetResultFailureValue) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:NetResultFailureValue[@"message"]];
    } WithErrorBlock:^(id  _Nonnull NetResultErrorValue) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:NetResultErrorValue[@"message"]];
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
