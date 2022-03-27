//
//  MineViewController.m
//  Editor
//
//  Created by Kai on 2022/2/25.
//

#import "MineViewController.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "LoginViewController.h"
#import "UIButton+Gradient.h"
#import "CacheRequestManager.h"
#import "BizStore.h"
#import "AgreementViewController.h"
#import "SVProgressHUD.h"

@interface MineViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIButton *activeCodeBtn;
@property(nonatomic,strong)UILabel *accountLbl;
@property(nonatomic,strong)UIView *loginBgView;
@property(nonatomic,strong)UIView *unLoginBgView;

@property(nonatomic,strong)UIView *alertView;

@property(nonatomic,strong)UITextField *actCodeField;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self viewSetup];
    
//    [self unLoginViewSetup];
    
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
//    self.view removeFromSuperview
    
    self.tabBarController.navigationItem.title = @"我的";
    
    [_unLoginBgView removeFromSuperview];
    [_loginBgView removeFromSuperview];
    
    CacheRequestManager *cache = [CacheRequestManager new];
    NSString *token = (NSString*)[cache getWithKey:@"token"];
    
    
    
    if (token == nil) {
        NSLog(@"%@1",token);
        [self unLoginViewSetup];
    }else{
        NSLog(@"%@2",token);
        [self viewSetup];
        
        [self checking];
    }
    
    
    
}

-(void)unLoginViewSetup{
    
    _unLoginBgView = [UIView new];
    
    [self.view addSubview:_unLoginBgView];
    
    [_unLoginBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    UIButton *commitBtn = [UIButton new];
    [commitBtn setTitle:@"登 陆" forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    commitBtn.layer.cornerRadius = 5;
    commitBtn.layer.masksToBounds = YES;
    [_unLoginBgView addSubview:commitBtn];
    [commitBtn gradientButtonWithSize:CGSizeMake(278, 44) colorArray:@[[UIColor colorWithHexString:@"#4DCBFF"],[UIColor colorWithHexString:@"#BE4EFF"]] percentageArray:@[@(0.1),@(1)] gradientType:GradientFromLeftToRight];
    
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.width.equalTo(@278);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).with.offset(-44);
    }];
    
    [commitBtn addTarget:self action:@selector(gotoLogin) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *lblView = [UIView new];
    
    [_unLoginBgView addSubview:lblView];
    
    [lblView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(44);
        make.right.equalTo(self.view.mas_right).with.offset(-44);
        make.top.equalTo(commitBtn.mas_bottom).with.offset(20);
        make.height.equalTo(@40);
    }];
    
    UIView *midView = [UIView new];
    midView.backgroundColor = [UIColor colorWithHexString:@"#B46DFA"];
    [lblView addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@10);
        make.width.equalTo(@1);
        make.centerY.equalTo(lblView.mas_centerY);
        make.centerX.equalTo(lblView.mas_centerX);
    }];
    
    
    UILabel *leftLbl = [UILabel new];
    leftLbl.textAlignment = NSTextAlignmentRight;
    leftLbl.textColor = [UIColor colorWithHexString:@"#B46DFA"];
    leftLbl.font = [UIFont systemFontOfSize:12];
    leftLbl.text = @"注册协议";
    [lblView addSubview:leftLbl];
    [leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lblView.mas_left).with.offset(44);
        make.right.equalTo(midView.mas_centerX).with.offset(-5);
        make.centerY.equalTo(midView.mas_centerY).with.offset(0);
        make.height.equalTo(@40);
    }];
    
    NSDictionary *attribtDicLeft = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStrLeft = [[NSMutableAttributedString alloc]initWithString:@"注册协议" attributes:attribtDicLeft];
    leftLbl.attributedText = attribtStrLeft;
    
    
    UILabel *rightLbl = [UILabel new];
    rightLbl.textAlignment = NSTextAlignmentLeft;
    rightLbl.textColor = [UIColor colorWithHexString:@"#B46DFA"];
    rightLbl.font = [UIFont systemFontOfSize:12];
    rightLbl.text = @"隐私政策";
    [lblView addSubview:rightLbl];
    [rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lblView.mas_right).with.offset(44);
        make.left.equalTo(midView.mas_centerX).with.offset(5);
        make.centerY.equalTo(midView.mas_centerY).with.offset(0);
        make.height.equalTo(@40);
    }];

    NSDictionary *attribtDicRight = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStrRight = [[NSMutableAttributedString alloc]initWithString:@"隐私政策" attributes:attribtDicRight];
    rightLbl.attributedText = attribtStrRight;
    
    
    leftLbl.tag = 1;
    UITapGestureRecognizer *leftLblTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Agreement:)];
    leftLbl.userInteractionEnabled = YES;
    [leftLbl addGestureRecognizer:leftLblTap];
    
    rightLbl.tag = 2;
    UITapGestureRecognizer *rightLblTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Agreement:)];
    rightLbl.userInteractionEnabled = YES;
    [rightLbl addGestureRecognizer:rightLblTap];
}

-(void)viewSetup{
    
    
    _loginBgView = [UIView new];
    
    [self.view addSubview:_loginBgView];
    
    [_loginBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    
    _activeCodeBtn = [UIButton new];
    [_activeCodeBtn setTitle:@"请点击输入激活码" forState:UIControlStateNormal];
    [_activeCodeBtn setTitleColor:[UIColor colorWithHexString:@"#B46DFA"] forState:UIControlStateNormal];
    _activeCodeBtn.layer.borderColor = [UIColor colorWithHexString:@"#B46DFA"].CGColor;
    _activeCodeBtn.layer.borderWidth = 1;
    _activeCodeBtn.layer.cornerRadius = 20;
    
    _activeCodeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    
    [_loginBgView addSubview:_activeCodeBtn];
    
    [_activeCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(44);
        make.right.equalTo(self.view.mas_right).with.offset(-44);
        make.centerY.equalTo(self.view.mas_centerY).with.offset(-80);
        make.height.equalTo(@40);
    }];
    
    [_activeCodeBtn addTarget:self action:@selector(showActivatingView) forControlEvents:UIControlEventTouchUpInside];
    
    
    CacheRequestManager *cache = [CacheRequestManager new];
    
    if ([[NSString stringWithFormat:@"%@",[cache getWithKey:@"activating"]] isEqualToString:@"1"]) {

        [UIView animateWithDuration:0.1 animations:^{
            [self.activeCodeBtn setTitle:@"已激活" forState:UIControlStateNormal];
            [self.activeCodeBtn setEnabled:NO];
        }];

    }
    
    
    
    _accountLbl = [UILabel new];
    _accountLbl.textColor = [UIColor colorWithHexString:@"#333333"];
    _accountLbl.textAlignment = NSTextAlignmentCenter;
    [_loginBgView addSubview:_accountLbl];
    _accountLbl.font = [UIFont boldSystemFontOfSize:16];
    [_accountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(44);
        make.right.equalTo(self.view.mas_right).with.offset(-44);
        make.bottom.equalTo(_activeCodeBtn.mas_top).with.offset(-20);
        make.height.equalTo(@40);
    }];
    
    //_accountLbl.text = @"188****1268";
    
    
    NSString *phone = (NSString*)[cache getWithKey:@"phone"];
    _accountLbl.text = phone;
    
    
    UIView *lblView = [UIView new];
    
    [_loginBgView addSubview:lblView];
    
    [lblView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(44);
        make.right.equalTo(self.view.mas_right).with.offset(-44);
        make.top.equalTo(_activeCodeBtn.mas_bottom).with.offset(20);
        make.height.equalTo(@40);
    }];
    
    

    
    UIView *midView = [UIView new];
    midView.backgroundColor = [UIColor colorWithHexString:@"#B46DFA"];
    [lblView addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@10);
        make.width.equalTo(@1);
        make.centerY.equalTo(lblView.mas_centerY);
        make.centerX.equalTo(lblView.mas_centerX);
    }];
    
    
    UILabel *leftLbl = [UILabel new];
    leftLbl.textAlignment = NSTextAlignmentRight;
    leftLbl.textColor = [UIColor colorWithHexString:@"#B46DFA"];
    leftLbl.font = [UIFont systemFontOfSize:12];
    leftLbl.text = @"注册协议";
    [lblView addSubview:leftLbl];
    [leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lblView.mas_left).with.offset(44);
        make.right.equalTo(midView.mas_centerX).with.offset(-5);
        make.centerY.equalTo(midView.mas_centerY).with.offset(0);
        make.height.equalTo(@40);
    }];
    
    NSDictionary *attribtDicLeft = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStrLeft = [[NSMutableAttributedString alloc]initWithString:@"注册协议" attributes:attribtDicLeft];
    leftLbl.attributedText = attribtStrLeft;
    
    
    UILabel *rightLbl = [UILabel new];
    rightLbl.textAlignment = NSTextAlignmentLeft;
    rightLbl.textColor = [UIColor colorWithHexString:@"#B46DFA"];
    rightLbl.font = [UIFont systemFontOfSize:12];
    rightLbl.text = @"隐私政策";
    [lblView addSubview:rightLbl];
    [rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lblView.mas_right).with.offset(44);
        make.left.equalTo(midView.mas_centerX).with.offset(5);
        make.centerY.equalTo(midView.mas_centerY).with.offset(0);
        make.height.equalTo(@40);
    }];

    NSDictionary *attribtDicRight = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStrRight = [[NSMutableAttributedString alloc]initWithString:@"隐私政策" attributes:attribtDicRight];
    rightLbl.attributedText = attribtStrRight;
    
    
    leftLbl.tag = 1;
    UITapGestureRecognizer *leftLblTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Agreement:)];
    leftLbl.userInteractionEnabled = YES;
    [leftLbl addGestureRecognizer:leftLblTap];
    
    rightLbl.tag = 2;
    UITapGestureRecognizer *rightLblTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Agreement:)];
    rightLbl.userInteractionEnabled = YES;
    [rightLbl addGestureRecognizer:rightLblTap];
    
    
    CGFloat tabBar_Height = self.tabBarController.tabBar.frame.size.height;
    
    NSLog(@"%f",tabBar_Height);
    
    
    UIButton *LogoutBtn = [UIButton new];
    [LogoutBtn setTitle:@"退出登陆" forState:UIControlStateNormal];
    LogoutBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    LogoutBtn.layer.cornerRadius = 5;
    LogoutBtn.layer.masksToBounds = YES;
    [_loginBgView addSubview:LogoutBtn];
    [LogoutBtn gradientButtonWithSize:CGSizeMake(278, 44) colorArray:@[[UIColor colorWithHexString:@"#4DCBFF"],[UIColor colorWithHexString:@"#BE4EFF"]] percentageArray:@[@(0.1),@(1)] gradientType:GradientFromLeftToRight];
    
    [LogoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.width.equalTo(@278);
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-(tabBar_Height+20));
    }];
    
    [LogoutBtn addTarget:self action:@selector(showLogoutView) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *versionLbl = [UILabel new];
    versionLbl.text = @"当前版本:1.0.0";
    versionLbl.textAlignment = NSTextAlignmentCenter;
    versionLbl.font = [UIFont systemFontOfSize:13];
    versionLbl.textColor = [UIColor colorWithHexString:@"#999999"];
    [_loginBgView addSubview:versionLbl];
    
    [versionLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(LogoutBtn.mas_top).with.offset(-20);
    }];
    

    
}


-(void)leftClick{
    NSLog(@"left");
}

-(void)rightClick{
    NSLog(@"right");
}


-(void)gotoLogin{
    
    LoginViewController *login = [LoginViewController new];
    login.modalPresentationStyle = UIModalPresentationFullScreen;
//    UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:login];
    
    [self presentViewController:login animated:YES completion:^{
        [self checking];
    }];
    
}

-(void)logout{
    
    
    [self closeActivatingView];
    
    CacheRequestManager *chace = [CacheRequestManager new];
    
    [chace removeWithkey:@"token"];
    
    [_unLoginBgView removeFromSuperview];
    [_loginBgView removeFromSuperview];
    
    CacheRequestManager *cache = [CacheRequestManager new];
    NSString *token = (NSString*)[cache getWithKey:@"token"];
    
    
    
    if (token == nil) {
        NSLog(@"%@1",token);
        [self unLoginViewSetup];
    }else{
        NSLog(@"%@2",token);
        [self viewSetup];
    }
    
}


-(void)showLogoutView{
    
    _alertView = [[UIView alloc] initWithFrame:self.view.frame];
    
    _alertView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.6];
    
    UITapGestureRecognizer *leftLblTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeActivatingView)];
    _alertView.userInteractionEnabled = YES;
    [_alertView addGestureRecognizer:leftLblTap];
    
    
    UIWindow *rootWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    
    [rootWindow addSubview:_alertView];
    
    UIView *bg = [UIView new];
    bg.backgroundColor = [UIColor whiteColor];
    bg.layer.cornerRadius = 7.5;
    [_alertView addSubview:bg];
    
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@165);
        make.width.equalTo(@285);
        make.centerX.equalTo(_alertView.mas_centerX);
        make.centerY.equalTo(_alertView.mas_centerY).with.offset(-50);
    }];
    
    UILabel *title = [UILabel new];
    title.text = @"是否退出登录？";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor colorWithHexString:@"#333333"];
    title.font = [UIFont boldSystemFontOfSize:18];
    [bg addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg.mas_centerX);
        make.top.equalTo(bg.mas_top).with.offset(40);
        make.left.right.equalTo(bg);
        make.height.equalTo(@30);
    }];
    
    
    UIButton *cancelBtn = [UIButton new];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [cancelBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    cancelBtn.layer.borderColor = [UIColor colorWithHexString:@"#dddddd"].CGColor;
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.cornerRadius = 33/2;
    [bg addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@33);
        make.width.equalTo(@90);
        make.top.equalTo(title.mas_bottom).with.offset(30);
        make.right.equalTo(bg.mas_centerX).with.offset(-10);
    }];
    
    [cancelBtn addTarget:self action:@selector(closeActivatingView) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *sureBtn = [UIButton new];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"#B46DFA"];
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 33/2;
    [bg addSubview:sureBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@33);
        make.width.equalTo(@90);
        make.top.equalTo(title.mas_bottom).with.offset(30);
        make.left.equalTo(bg.mas_centerX).with.offset(10);
    }];
    
    [sureBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
}



-(void)showActivatingView{
    
    _alertView = [[UIView alloc] initWithFrame:self.view.frame];
    
    _alertView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.6];
    
    UITapGestureRecognizer *leftLblTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeActivatingView)];
    _alertView.userInteractionEnabled = YES;
    [_alertView addGestureRecognizer:leftLblTap];
    
    
    UIWindow *rootWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    
    [rootWindow addSubview:_alertView];
    
    
    UIView *bg = [UIView new];
    bg.backgroundColor = [UIColor whiteColor];
    bg.layer.cornerRadius = 7.5;
    [_alertView addSubview:bg];
    
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@240);
        make.width.equalTo(@285);
        make.centerX.equalTo(_alertView.mas_centerX);
        make.centerY.equalTo(_alertView.mas_centerY).with.offset(-50);
    }];
    
    UILabel *title = [UILabel new];
    title.text = @"请输入激活码";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor colorWithHexString:@"#333333"];
    title.font = [UIFont boldSystemFontOfSize:18];
    [bg addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg.mas_centerX);
        make.top.equalTo(bg.mas_top).with.offset(40);
        make.left.right.equalTo(bg);
        make.height.equalTo(@30);
    }];
    
    
    _actCodeField = [UITextField new];
    _actCodeField.placeholder = @"请输入激活码";
    _actCodeField.delegate = self;
    [bg addSubview:_actCodeField];

    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入激活码" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#CCCCCC" alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _actCodeField.attributedPlaceholder = placeholderString;
    
//    _actCodeField.keyboardType = UIKeyboardTypeNumberPad;
    
    [_actCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bg.mas_left).with.offset(45);
        make.right.equalTo(bg.mas_right).with.offset(-45);
        make.top.equalTo(title.mas_bottom).with.offset(36);
        make.height.equalTo(@30);
    }];
    
    UIView *fieldBorder = [UIView new];
    fieldBorder.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    [bg addSubview:fieldBorder];

    [fieldBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bg.mas_left).with.offset(39);
        make.right.equalTo(bg.mas_right).with.offset(-39);
        make.top.equalTo(_actCodeField.mas_bottom).with.offset(5);
        make.height.equalTo(@0.5);
    }];
    
    UIButton *cancelBtn = [UIButton new];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [cancelBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    cancelBtn.layer.borderColor = [UIColor colorWithHexString:@"#dddddd"].CGColor;
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.cornerRadius = 33/2;
    [bg addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@33);
        make.width.equalTo(@90);
        make.top.equalTo(fieldBorder.mas_bottom).with.offset(30);
        make.right.equalTo(bg.mas_centerX).with.offset(-10);
    }];
    
    [cancelBtn addTarget:self action:@selector(closeActivatingView) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *sureBtn = [UIButton new];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"#B46DFA"];
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 33/2;
    [bg addSubview:sureBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@33);
        make.width.equalTo(@90);
        make.top.equalTo(fieldBorder.mas_bottom).with.offset(30);
        make.left.equalTo(bg.mas_centerX).with.offset(10);
    }];
    
    [sureBtn addTarget:self action:@selector(Activating) forControlEvents:UIControlEventTouchUpInside];
    
    
    return;
}

-(void)closeActivatingView{
    NSLog(@"123123");
    [_alertView removeFromSuperview];
    
}



-(void)Activating{
    
    if ([_actCodeField.text isEqualToString:@""]) {
        
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入激活码"];
        
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    BizStore *biz = [BizStore new];
    
    [biz RequestActivatingWithCdKey:_actCodeField.text WithSuccessBlock:^(id  _Nonnull NetResultSuccessValue) {
        
        [weakSelf.activeCodeBtn setTitle:@"已激活" forState:UIControlStateNormal];
        
        [weakSelf.activeCodeBtn setEnabled:NO];
        
        [SVProgressHUD showSuccessWithStatus:@"激活成功"];
        
        [weakSelf closeActivatingView];
        
        
    } WithFailureBlock:^(id  _Nonnull NetResultFailureValue) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:NetResultFailureValue[@"message"]];
    } WithErrorBlock:^(id  _Nonnull NetResultErrorValue) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:NetResultErrorValue[@"message"]];
    }];
    
    
}


-(void)checking{
    
    __weak typeof(self) weakSelf = self;
    
    BizStore *biz = [BizStore new];
    
    [biz RequestActivatingCheckWithSuccessBlock:^(id  _Nonnull NetResultSuccessValue) {
        NSLog(@"%@",NetResultSuccessValue);
        
        if (NetResultSuccessValue) {
            [UIView animateWithDuration:0.1 animations:^{
                [weakSelf.activeCodeBtn setTitle:@"已激活" forState:UIControlStateNormal];
                [weakSelf.activeCodeBtn setEnabled:NO];
            }];
        }else{

        }
        
    } WithFailureBlock:^(id  _Nonnull NetResultFailureValue) {

        NSLog(@"%@",NetResultFailureValue);
        
    } WithErrorBlock:^(id  _Nonnull NetResultErrorValue) {
       
        NSLog(@"%@",NetResultErrorValue);
        
    }];
    
    
    
    
}


-(void)Agreement:(id)sender
{
    
    
    UITapGestureRecognizer *Tap = (UITapGestureRecognizer *)sender;
    NSLog(@"``````%ld",(long)[Tap view].tag);
    AgreementViewController *agr = [AgreementViewController new];
    agr.type = [Tap view].tag;
    [self.navigationController pushViewController:agr animated:YES];
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (textField == self.actCodeField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.actCodeField.text.length >= 6) {
            self.actCodeField.text = [textField.text substringToIndex:6];
            return NO;
        }
    }

    return YES;

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
