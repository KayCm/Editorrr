//
//  IndexViewController.m
//  Editor
//
//  Created by Kai on 2022/3/9.
//

#import "IndexViewController.h"
#import "UIColor+Extension.h"
#import "UIButton+Gradient.h"
#import "VideoEditViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "TZImagePickerController.h"
#import "Masonry.h"
#import "MainViewController.h"
#import "SVProgressHUD.h"
#import "GetVideoViewController.h"
#import "CacheRequestManager.h"
#import "LoginViewController.h"
#import "UIImage+Gradient.h"
#import "BizStore.h"
#import "AgreementViewController.h"

@interface IndexViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)UIButton *soundBtn;
@property(nonatomic,strong)UIButton *fullBtn;
@property(nonatomic,strong)UIButton *PlayBtn;
@property(nonatomic,strong)UIButton *commitBtn;
@property(nonatomic,strong)UIView *PlayerBgView;

@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)NSString *videoUrl;
@property(nonatomic)BOOL videoHorizontal;

@property(nonatomic,strong)AVPlayerItem *item;

@property(nonatomic,strong)UIView *alertView;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self viewSetup];
    
    [self.PlayBtn setHidden:YES];
    
        
}


-(void)viewWillAppear:(BOOL)animated{
    
    
    self.tabBarController.navigationItem.title = @"剪益";
    
    CacheRequestManager *cache = [CacheRequestManager new];
    
    NSString *token = (NSString*)[cache getWithKey:@"token"];
    
    if (token != nil) {

        BizStore *biz = [BizStore new];
        
        [biz RequestActivatingCheckWithSuccessBlock:^(id  _Nonnull NetResultSuccessValue) {
            
//            NSLog(@"%@",[NetResultSuccessValue objectForKey:@"message"]);
        
            [cache saveWithData:NetResultSuccessValue Withkey:@"activating"];
        
            
        } WithFailureBlock:^(id  _Nonnull NetResultFailureValue) {
            
        } WithErrorBlock:^(id  _Nonnull NetResultErrorValue) {
            
        }];
        
        
    }
    
    
    if (![cache getWithKey:@"agree"]) {
        [self showAgreeView];
    }
    
    
}

-(void)viewSetup{
    
    CGFloat navBar_Height =  self.navigationController.navigationBar.frame.size.height;
    UIWindow *window = [UIApplication.sharedApplication.windows firstObject];
    NSLog(@"top == %f",window.safeAreaInsets.top);
    
    //[self.navigationController.navigationBar setHidden:YES];
    
    UIView *bg = [UIView new];
    bg.backgroundColor = [UIColor colorWithHexString:@"#000000"];
    [self.view addSubview:bg];
    
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(window.safeAreaInsets.top+navBar_Height+44);
        make.height.equalTo(@(SCREEN_WIDTH+20));
    }];
    
    
    //return;
    
    _PlayerBgView = [UIView new];
    _PlayerBgView.backgroundColor = [UIColor redColor];
    [bg addSubview:_PlayerBgView];
    
    [_PlayerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bg);
        make.top.equalTo(bg.mas_top).with.offset(10);
        make.height.equalTo(bg.mas_width);
    }];
    
    [self addPlay];
    
    _selectBtn = [UIButton new];
    [_selectBtn setImage:[UIImage imageNamed:@"index_open"] forState:UIControlStateNormal];
    
    [_selectBtn setTitle:@"选择视频" forState:UIControlStateNormal];
    
    [_PlayerBgView addSubview:_selectBtn];
    
    [_selectBtn addTarget:self action:@selector(showSlect) forControlEvents:UIControlEventTouchUpInside];
    

//    selectBtn.backgroundColor = [UIColor redColor];
    
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_PlayerBgView.mas_centerX);
        make.centerY.equalTo(_PlayerBgView.mas_centerY);
        make.height.equalTo(@112.5);
        make.width.equalTo(@100.5);
    }];
    
    
    
//    selectBtn.imageEdgeInsets = UIEdgeInsetsMake(-100,0, 100, 0);
////
//    selectBtn.titleEdgeInsets = UIEdgeInsetsMake( 50, 0,-50,0);
//
    
    UIView *ctrBar = [UIView new];
    ctrBar.backgroundColor = [UIColor blackColor];
    [bg addSubview:ctrBar];
    
    [ctrBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bg);
        make.bottom.equalTo(_PlayerBgView.mas_bottom).with.offset(0);
        make.height.equalTo(@50);
    }];
    
    
    
    _soundBtn = [UIButton new];
    [_soundBtn setImage:[UIImage imageNamed:@"sound"] forState:UIControlStateNormal];
    [ctrBar addSubview:_soundBtn];
    [_soundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ctrBar.mas_left).with.offset(28);
        make.centerY.equalTo(ctrBar.mas_centerY);
        make.height.equalTo(@15);
        make.width.equalTo(@17);
    }];
    
    [_soundBtn setHidden:YES];
    
    _fullBtn = [UIButton new];
    [_fullBtn setImage:[UIImage imageNamed:@"full"] forState:UIControlStateNormal];
    [ctrBar addSubview:_fullBtn];
    [_fullBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ctrBar.mas_right).with.offset(-28);
        make.centerY.equalTo(ctrBar.mas_centerY);
        make.height.equalTo(@16);
        make.width.equalTo(@16);
    }];
    
    [_fullBtn setHidden:YES];
    
    _PlayBtn = [UIButton new];
    [_PlayBtn setImage:[UIImage imageNamed:@"index_play"] forState:UIControlStateNormal];
    [_PlayBtn setImage:[UIImage imageNamed:@"index_pause"] forState:UIControlStateSelected];
    _PlayBtn.backgroundColor = [UIColor whiteColor];
    _PlayBtn.layer.cornerRadius = 15;
    [ctrBar addSubview:_PlayBtn];
    [_PlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ctrBar.mas_centerX).with.offset(0);
        make.centerY.equalTo(ctrBar.mas_centerY);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
    }];
    
    [_PlayBtn addTarget:self action:@selector(playyy) forControlEvents:UIControlEventTouchUpInside];
    
    
    _commitBtn = [UIButton new];
    [_commitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _commitBtn.layer.cornerRadius = 5;
    _commitBtn.layer.masksToBounds = YES;
    [self.view addSubview:_commitBtn];
    [_commitBtn gradientButtonWithSize:CGSizeMake(278, 44) colorArray:@[[UIColor colorWithHexString:@"#4DCBFF"],[UIColor colorWithHexString:@"#BE4EFF"]] percentageArray:@[@(0.1),@(1)] gradientType:GradientFromLeftToRight];
    
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.width.equalTo(@278);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(bg.mas_bottom).with.offset(44);
    }];
    
    [_commitBtn addTarget:self action:@selector(videoEdit) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [self addPlay];
    
}


-(void)addPlay{
    
    //NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"2022" ofType:@"mp4"];
    
//    self.player = [AVPlayer playerWithPlayerItem:_item];
    
    self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:@""]];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    playerLayer.bounds = CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_WIDTH);
    playerLayer.position = CGPointMake(SCREEN_WIDTH/2, SCREEN_WIDTH/2);
    [_PlayerBgView.layer addSublayer:playerLayer];
    
    
    __weak typeof(self) weakSelf = self;
    
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, NSEC_PER_SEC) queue:NULL usingBlock:^(CMTime time) {
        CGFloat progress = CMTimeGetSeconds(weakSelf.player.currentItem.currentTime)/CMTimeGetSeconds(weakSelf.player.currentItem.duration);
        
        if (progress == 1.0f) {
//            [weakSelf.player pause];
//            [weakSelf.playBtn setSelected:NO];
            [weakSelf.selectBtn setHidden:NO];
            [weakSelf.PlayBtn setSelected:NO];
        }
        
        NSLog(@"%f",progress);
        
    }];
    
}

-(void)playyy{
    
    if(!_videoUrl){
        
        
        
        return;
    }
    
    if (!self.PlayBtn.isSelected) {
        [self.selectBtn setHidden:YES];
        
        [self.PlayBtn setSelected:YES];
        
        [self.player replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:_videoUrl]]];
        
        [self.player play];
    }else{
        
        [self.selectBtn setHidden:NO];
        
        [self.PlayBtn setSelected:NO];
        
        [self.player pause];
        
    }
    
    

    
    
    
}

-(void)selectVideo{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    imagePickerVc.allowPickingImage = NO;
    __weak typeof(self) weakSelf = self;
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
    
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
                
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            AVURLAsset *urlAsset = (AVURLAsset *)asset;

            NSURL *url = urlAsset.URL;  //NSData *data = [NSData dataWithContentsOfURL:url];
            weakSelf.videoUrl = [NSString stringWithFormat:@"%@",url];
//            AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
            
            weakSelf.item = [AVPlayerItem playerItemWithURL:url];
            
            CGSize videoSize = CGSizeZero;
            NSArray *arr =  asset.tracks;
            for (AVAssetTrack *t in arr) {
                if ([t.mediaType isEqualToString:AVMediaTypeVideo]) {
                    videoSize = t.naturalSize;
                }
            }
            
            weakSelf.videoHorizontal = false;
            if (videoSize.width > videoSize.height) {
                weakSelf.videoHorizontal = true;
            }
            //self->playTime = (int)item.asset.duration.value/item.asset.duration.timescale;
            //NSLog(@"%lld",self->playTime.value/self->playTime.timescale);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.selectBtn setHidden:YES];
                
                [weakSelf.PlayBtn setHidden:NO];
                
                [weakSelf.player replaceCurrentItemWithPlayerItem:weakSelf.item];
                
                [weakSelf.player play];
                
                [weakSelf.PlayBtn setSelected:YES];
           });
        
        }];
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)downloadVideo{
    
    __weak typeof(self) weakSelf = self;
    
    
    CacheRequestManager *cache = [CacheRequestManager new];
    
    if (![[NSString stringWithFormat:@"%@",[cache getWithKey:@"activating"]] isEqualToString:@"1"]) {

        [SVProgressHUD showErrorWithStatus:@"账号未激活"];
        
        return;

    }
    
    
    
    GetVideoViewController *add = [GetVideoViewController new];
    
    add.valueBlock = ^(NSDictionary * _Nonnull value) {
        NSLog(@"%@",value);
        
        weakSelf.videoUrl = value[@"dir"] ;
        
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:value[@"dir"]]];
        CGSize videoSize = CGSizeZero;
        NSArray *arr =  item.asset.tracks;
        for (AVAssetTrack *t in arr) {
            if ([t.mediaType isEqualToString:AVMediaTypeVideo]) {
                videoSize = t.naturalSize;
            }
        }
        
        
        weakSelf.videoHorizontal = false;
        if (videoSize.width > videoSize.height) {
            weakSelf.videoHorizontal = true;
        }
        
//        self->isHorizontal = false;
//        if (videoSize.width > videoSize.height) {
//            self->isHorizontal = true;
//        }
//        self->playTime = (int)item.asset.duration.value/item.asset.duration.timescale;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.selectBtn setHidden:YES];
            
            [weakSelf.PlayBtn setHidden:NO];
            
            [weakSelf.player replaceCurrentItemWithPlayerItem:item];
            
            [weakSelf.player play];
            
            [weakSelf.PlayBtn setSelected:YES];
       });
        
        
        
    };
    
    [self presentViewController:add animated:YES completion:^{
            
    }];
    
}


-(void)videoEdit{
    
    
    
    if (!_videoUrl) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"未选择任何视频"];
        return;
    }
    
    
    
    [self.player pause];
    
    [self.selectBtn setHidden:NO];
    
    CacheRequestManager *cache = [CacheRequestManager new];
    
    NSString *token = (NSString*)[cache getWithKey:@"token"];

    if (token == nil) {
        
        LoginViewController *login = [LoginViewController new];
        login.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:login animated:YES completion:^{
                
        }];
       
    }else{
        VideoEditViewController *Video = [VideoEditViewController new];
        
        Video.url = _videoUrl;
        
        Video.videoHorizontal = _videoHorizontal;
        
        [self.navigationController pushViewController:Video animated:YES];
    }
    
    
    
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)showSlect{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"下载方式"
                                                                            message:nil
                                                                     preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *loaclAction = [UIAlertAction actionWithTitle:@"本地选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self selectVideo];
        
    }];
    UIAlertAction *douyinAction = [UIAlertAction actionWithTitle:@"从抖音下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self downloadVideo];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Action");
    }];
    
    [alertController addAction:loaclAction];
    [alertController addAction:douyinAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)showAgreeView{
    
    _alertView = [[UIView alloc] initWithFrame:self.view.frame];
    
    _alertView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.6];
    
    UITapGestureRecognizer *leftLblTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView)];
    _alertView.userInteractionEnabled = YES;
    [_alertView addGestureRecognizer:leftLblTap];
    
    UIWindow *rootWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [rootWindow addSubview:_alertView];
    
    UIView *bg = [UIView new];
    bg.backgroundColor = [UIColor whiteColor];
    bg.layer.cornerRadius = 7.5;
    [_alertView addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@290);
        make.width.equalTo(@300);
        make.centerX.equalTo(_alertView.mas_centerX);
        make.centerY.equalTo(_alertView.mas_centerY).with.offset(0);
    }];
    
    UILabel *title = [UILabel new];
    title.text = @"用户协议及隐私政策";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:20];
    [bg addSubview:title];

    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.left.right.equalTo(bg);
        make.top.equalTo(bg.mas_top).with.offset(10);
    }];
    
    

    
    UIView *btnView = [UIView new];
    [bg addSubview:btnView];
    
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bg);
        make.height.equalTo(@50);
        make.bottom.equalTo(bg.mas_bottom);
    }];
    
    
    NSString *message = @"            请你务必审核阅读、充分理解用户协议及隐私政策各条款，包括但不限于：为了向你提供即时通讯、内容分享等服务，我们需要收集你的设备信息、操作日志等个人信息。你可以在“设备”中查看、变更、删除个人信息并管理你的授权。你可以阅读《用户协议》和《隐私政策》了解详细信息，如你同意，请点击“同意”开始接受我们的服务。";
    
    UITextView *tv = [UITextView new];
    
    tv.text = message;
    tv.font = [UIFont systemFontOfSize:14];
    [bg addSubview:tv];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        // 设置行间距
    paragraphStyle.paragraphSpacing = 2; // 段落间距
    paragraphStyle.lineSpacing = 1;      // 行间距
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:paragraphStyle};
        NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:message attributes:attributes];
        [attrStr addAttributes:@{NSLinkAttributeName:@"《用户协议》"}range:[message rangeOfString:@"《用户协议》"]];
        [attrStr addAttributes:@{NSLinkAttributeName:@"《隐私政策》"}range:[message rangeOfString:@"《隐私政策》"]];
    tv.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor blueColor]}; // 修改可点击文字的颜色
    tv.attributedText = attrStr;
    tv.editable = NO;
    tv.scrollEnabled = NO;
    tv.delegate = self;
    
    
    
    
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bg.mas_left).with.offset(10);
        make.right.equalTo(bg.mas_right).with.offset(-10);
        make.top.equalTo(title.mas_bottom).with.offset(0);
        make.bottom.equalTo(btnView.mas_top).with.offset(-10);
    }];
    
    
//    UIView *border = [UIView new];
//    border.backgroundColor = [UIColor darkGrayColor];
//    [bg addSubview:border];
//
//    [border mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.width.equalTo(btnView);
//        make.height.equalTo(@1);
//    }];
    
    
    
    UIButton *cancel = [UIButton new];
    [cancel setTitle:@"不同意" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnView addSubview:cancel];
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnView.mas_left);
        make.right.equalTo(btnView.mas_centerX);
        make.height.equalTo(btnView);
    }];
    
    [cancel addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *agree = [UIButton new];
    agree.backgroundColor = [UIColor colorWithHexString:@"#B46DFA"];
    [agree setTitle:@"同 意" forState:UIControlStateNormal];
    agree.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [btnView addSubview:agree];
    [agree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btnView.mas_right);
        make.left.equalTo(btnView.mas_centerX);
        make.height.equalTo(btnView);
    }];
    
    [agree addTarget:self action:@selector(agree) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}

-(void)agree{
    
    [_alertView removeFromSuperview];
    
    CacheRequestManager *cache = [CacheRequestManager new];
    
    [cache saveWithData:@(1) Withkey:@"agree"];
    
}

-(void)closeView{
    [_alertView removeFromSuperview];
}

-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    
    [self closeView];
    
    NSRange range = [textView.text rangeOfString:@"《用户协议》"];
    
    if (characterRange.location == range.location) {
        AgreementViewController *agr = [AgreementViewController new];
        agr.type = 1;
        [self.navigationController pushViewController:agr animated:YES];
    }
    
    NSRange range1 = [textView.text rangeOfString:@"《隐私政策》"];
    
    if (characterRange.location == range1.location) {
        AgreementViewController *agr = [AgreementViewController new];
        agr.type = 2;
        [self.navigationController pushViewController:agr animated:YES];
    }
    
    return YES;
    
}



@end
