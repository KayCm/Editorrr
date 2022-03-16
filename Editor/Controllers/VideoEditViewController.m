//
//  VideoEditViewController.m
//  Editor
//
//  Created by Kai on 2022/2/25.
//

#import "VideoEditViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIColor+Extension.h"
#import "UIButton+Gradient.h"
#import "Masonry.h"
#import "SVProgressHUD.h"
#import "FFMpegCommand.h"
#import "TZImagePickerController.h"


@interface VideoEditViewController ()

@property(nonatomic,strong)UIButton *commitBtn;
@property(nonatomic,strong)UIButton *soundBtn;
@property(nonatomic,strong)UIButton *fullBtn;
@property(nonatomic,strong)UIButton *PlayBtn;

@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)UIView *playLayer;

@property(nonatomic,strong)UIView *actBar;
@property(nonatomic,strong)UIButton *actBarSwitchBtn;

@property(nonatomic,strong)UIButton *deleteVoiceBtn;
@property(nonatomic,strong)UIButton *flipHorizontalBtn;
@property(nonatomic,strong)UIButton *flipVerticalBtn;
@property(nonatomic,strong)UIButton *speedPlusBtn;
@property(nonatomic,strong)UIButton *speedMinusBtn;
@property(nonatomic,strong)UIButton *smartBorderBtn;
@property(nonatomic,strong)UIButton *smartClearBtn;

@property(nonatomic,strong)NSString *finalUrl;


//flip_vertical





@end

@implementation VideoEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#333333"];
    
    self.title = @"编辑";
    
    [self viewSetup];
}

-(void)viewSetup{
    
    CGFloat navBar_Height =  self.navigationController.navigationBar.frame.size.height;
    
    UIWindow *window = [UIApplication.sharedApplication.windows firstObject];
    NSLog(@"top == %f",window.safeAreaInsets.top);
    NSLog(@"bottom == %f",window.safeAreaInsets.bottom);

    //self.tabBarController.tabBar.frame.size.height;
    
    
    UIView *topCtrbar = [UIView new];
    topCtrbar.backgroundColor = [UIColor colorWithHexString:@"#171616"];
    [self.view addSubview:topCtrbar];
    
    [topCtrbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(navBar_Height+window.safeAreaInsets.top);
        make.height.equalTo(@34);
    }];
    
    //[topCtrbar setHidden:YES];
    
    UILabel *topLbl = [UILabel new];
    topLbl.text = @"带边框效果";
    topLbl.font = [UIFont systemFontOfSize:12];
    topLbl.textColor = [UIColor whiteColor];
    [topCtrbar addSubview:topLbl];
    [topLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topCtrbar.mas_left).with.offset(20);
        make.right.equalTo(topCtrbar.mas_centerX).with.offset(0);
        make.centerY.equalTo(topCtrbar.mas_centerY).with.offset(0);
        make.height.equalTo(@30);
    }];
    
    if(_videoHorizontal){
        topLbl.text =@"视频横向";
    }else{
        topLbl.text =@"视频竖向";
    }
    
    [topLbl setHidden:YES];
    
    UIImageView *changeIcon = [UIImageView new];
    changeIcon.image = [UIImage imageNamed:@"you"];
    [topCtrbar addSubview:changeIcon];
    
    [changeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.equalTo(@16);
        make.centerY.equalTo(topCtrbar.mas_centerY);
        make.right.equalTo(topCtrbar.mas_right).with.offset(-20);
    }];
    
    [changeIcon setHidden:YES];
    
    UIButton *changeBtn = [UIButton new];
    [changeBtn setTitle:@"更换背景" forState:UIControlStateNormal];
    changeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    changeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [topCtrbar addSubview:changeBtn];
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(changeIcon.mas_left).with.offset(0);
        make.centerY.equalTo(topCtrbar.mas_centerY).with.offset(0);
        make.height.equalTo(@30);
        make.width.equalTo(@55);
    }];
    
    [changeBtn setHidden:YES];
    changeBtn.tag = 0;
    
    [changeBtn addTarget:self action:@selector(ActionSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    _playLayer = [UIView new];
    _playLayer.backgroundColor = [UIColor colorWithHexString:@"#171616"];
    [self.view addSubview:_playLayer];
    
    [_playLayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(topCtrbar.mas_bottom).with.offset(0);
        make.height.equalTo(_playLayer.mas_width).multipliedBy(1.1);
    }];
    
    
    UIView *ctrBar = [UIView new];
    ctrBar.backgroundColor = [UIColor colorWithHexString:@"#171616"];
    [self.view addSubview:ctrBar];
    
    [ctrBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_playLayer.mas_bottom).with.offset(0);
        make.height.equalTo(@60);
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
    _PlayBtn.layer.cornerRadius = 18;
    [ctrBar addSubview:_PlayBtn];
    [_PlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ctrBar.mas_centerX).with.offset(0);
        make.centerY.equalTo(ctrBar.mas_centerY);
        make.height.equalTo(@36);
        make.width.equalTo(@36);
    }];
    
    [_PlayBtn addTarget:self action:@selector(playClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _commitBtn = [UIButton new];
    [_commitBtn setTitle:@"处理视频" forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _commitBtn.layer.cornerRadius = 5;
    _commitBtn.layer.masksToBounds = YES;
    [self.view addSubview:_commitBtn];
    [_commitBtn gradientButtonWithSize:CGSizeMake(278, 44) colorArray:@[[UIColor colorWithHexString:@"#4DCBFF"],[UIColor colorWithHexString:@"#BE4EFF"]] percentageArray:@[@(0.1),@(1)] gradientType:GradientFromLeftToRight];
    
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
//        make.width.equalTo(@130);
        make.top.equalTo(ctrBar.mas_bottom).with.offset(20);
        make.right.equalTo(self.view.mas_centerX).with.offset(-10);
        make.left.equalTo(self.view.mas_left).with.offset(10);
    }];
    
    [_commitBtn addTarget:self action:@selector(actionCommand) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *saveBtn = [UIButton new];
    [saveBtn setTitle:@"保存到相册" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    saveBtn.layer.cornerRadius = 5;
    saveBtn.layer.masksToBounds = YES;
    [self.view addSubview:saveBtn];
    [saveBtn gradientButtonWithSize:CGSizeMake(278, 44) colorArray:@[[UIColor colorWithHexString:@"#4DCBFF"],[UIColor colorWithHexString:@"#BE4EFF"]] percentageArray:@[@(0.1),@(1)] gradientType:GradientFromLeftToRight];
    
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
//        make.width.equalTo(@130);
        make.top.equalTo(ctrBar.mas_bottom).with.offset(20);
        make.left.equalTo(self.view.mas_centerX).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
    }];
    
    [saveBtn addTarget:self action:@selector(saveVideo) forControlEvents:UIControlEventTouchUpInside];
    
    [self playerSet];
    
    [self actBarSetup];
    
}

-(void)playClick{
    
    NSString *videoUrl = _finalUrl;
    
    if(!_finalUrl){
        
        videoUrl = _url;
    }
    
    if (!self.PlayBtn.isSelected) {
        
        [self.PlayBtn setSelected:YES];
        
        [self.player replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:videoUrl]]];
        
        [self.player play];
    }else{
        
        [self.PlayBtn setSelected:NO];
        
        [self.player pause];
        
    }
    
    
}


-(void)saveVideo{
    
    if(!_finalUrl){
        
        _finalUrl = _url;
    }
    
    
    BOOL videoCompatible = UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(_finalUrl);
    //检查视频能否保存至相册
    if (videoCompatible) {
        UISaveVideoAtPathToSavedPhotosAlbum(_finalUrl, self,
    @selector(video:didFinishSavingWithError:contextInfo:), nil);
    } else {
        NSLog(@"该视频无法保存至相册");
    }
    
    
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"保存视频失败：%@", error);
    } else {
        NSLog(@"保存视频成功");
        
        [SVProgressHUD showSuccessWithStatus:@"保存视频成功" ];
    }
}

-(void)actBarSetup{
    
    _actBar = [UIView new];
    _actBar.backgroundColor = [UIColor colorWithHexString:@"#ffffff" alpha:0.2];
    [self.view addSubview:_actBar];
    _actBar.layer.cornerRadius = 25;
    _actBar.layer.masksToBounds = YES;
    
    [_actBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_playLayer.mas_bottom).with.offset(-10);
        make.right.equalTo(_playLayer.mas_right).with.offset(-10);
        make.width.equalTo(@75);
        make.height.equalTo(@50);
    }];
    
    
    _actBarSwitchBtn = [UIButton new];
    [_actBarSwitchBtn setImage:[UIImage imageNamed:@"btn_up"] forState:UIControlStateNormal];
    [_actBarSwitchBtn setImage:[UIImage imageNamed:@"btn_down"] forState:UIControlStateSelected];
    [_actBar addSubview:_actBarSwitchBtn];
    
    [_actBarSwitchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@38.5);
        make.height.equalTo(@26.5);
        make.centerX.equalTo(_actBar.mas_centerX);
        make.bottom.equalTo(_actBar.mas_bottom).with.offset(-12.5);
    }];
    
    [_actBarSwitchBtn addTarget:self action:@selector(upDown:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _deleteVoiceBtn = [UIButton new];
    [_deleteVoiceBtn setTitle:@"去除声音" forState:UIControlStateNormal];
    _deleteVoiceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [_deleteVoiceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deleteVoiceBtn setTitleColor:[UIColor colorWithHexString:@"#BE4EFF"] forState:UIControlStateSelected];
    _deleteVoiceBtn.tag = 1;
    [_deleteVoiceBtn addTarget:self action:@selector(ActionSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_actBar addSubview:_deleteVoiceBtn];
    [_deleteVoiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.height.equalTo(@35);
        make.centerX.equalTo(_actBar.mas_centerX);
        make.bottom.equalTo(_actBarSwitchBtn.mas_top).with.offset(-15);
    }];
    
    _flipHorizontalBtn = [UIButton new];
    [_flipHorizontalBtn setTitle:@"智能翻转" forState:UIControlStateNormal];
    _flipHorizontalBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [_flipHorizontalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_flipHorizontalBtn setTitleColor:[UIColor colorWithHexString:@"#BE4EFF"] forState:UIControlStateSelected];
    _flipHorizontalBtn.tag = 2;
    [_flipHorizontalBtn addTarget:self action:@selector(ActionSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_actBar addSubview:_flipHorizontalBtn];
    [_flipHorizontalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.height.equalTo(@35);
        make.centerX.equalTo(_actBar.mas_centerX);
        make.bottom.equalTo(_deleteVoiceBtn.mas_top).with.offset(-10);
    }];
    
    _flipVerticalBtn = [UIButton new];
    [_flipVerticalBtn setTitle:@"上下翻转" forState:UIControlStateNormal];
    _flipVerticalBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [_flipVerticalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_flipVerticalBtn setTitleColor:[UIColor colorWithHexString:@"#BE4EFF"] forState:UIControlStateSelected];
    _flipVerticalBtn.tag = 3;
    [_flipVerticalBtn addTarget:self action:@selector(ActionSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_actBar addSubview:_flipVerticalBtn];
    [_flipVerticalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.height.equalTo(@35);
        make.centerX.equalTo(_actBar.mas_centerX);
        make.bottom.equalTo(_flipHorizontalBtn.mas_top).with.offset(-10);
    }];
    
    _speedMinusBtn = [UIButton new];
    [_speedMinusBtn setTitle:@"智能减速" forState:UIControlStateNormal];
    _speedMinusBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [_speedMinusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_speedMinusBtn setTitleColor:[UIColor colorWithHexString:@"#BE4EFF"] forState:UIControlStateSelected];
    _speedMinusBtn.tag = 4;
    [_speedMinusBtn addTarget:self action:@selector(ActionSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_actBar addSubview:_speedMinusBtn];
    [_speedMinusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.height.equalTo(@35);
        make.centerX.equalTo(_actBar.mas_centerX);
        make.bottom.equalTo(_flipVerticalBtn.mas_top).with.offset(-10);
    }];
    
    _speedPlusBtn = [UIButton new];
    [_speedPlusBtn setTitle:@"智能加速" forState:UIControlStateNormal];
    _speedPlusBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [_speedPlusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_speedPlusBtn setTitleColor:[UIColor colorWithHexString:@"#BE4EFF"] forState:UIControlStateSelected];
    _speedPlusBtn.tag = 5;
    [_speedPlusBtn addTarget:self action:@selector(ActionSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_actBar addSubview:_speedPlusBtn];
    [_speedPlusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.height.equalTo(@35);
        make.centerX.equalTo(_actBar.mas_centerX);
        make.bottom.equalTo(_speedMinusBtn.mas_top).with.offset(-10);
    }];
    
    _smartBorderBtn = [UIButton new];
    [_smartBorderBtn setTitle:@"智能背景" forState:UIControlStateNormal];
    _smartBorderBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [_smartBorderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_smartBorderBtn setTitleColor:[UIColor colorWithHexString:@"#BE4EFF"] forState:UIControlStateSelected];
    _smartBorderBtn.tag = 6;
    [_smartBorderBtn addTarget:self action:@selector(ActionSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_actBar addSubview:_smartBorderBtn];
    [_smartBorderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.height.equalTo(@35);
        make.centerX.equalTo(_actBar.mas_centerX);
        make.bottom.equalTo(_speedPlusBtn.mas_top).with.offset(-10);
    }];
    
    _smartClearBtn = [UIButton new];
    [_smartClearBtn setTitle:@"智能清洗" forState:UIControlStateNormal];
    _smartClearBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [_smartClearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_smartClearBtn setTitleColor:[UIColor colorWithHexString:@"#BE4EFF"] forState:UIControlStateSelected];
    _smartClearBtn.tag = 7;
    [_smartClearBtn addTarget:self action:@selector(ActionSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_actBar addSubview:_smartClearBtn];
    [_smartClearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.height.equalTo(@35);
        make.centerX.equalTo(_actBar.mas_centerX);
        make.bottom.equalTo(_smartBorderBtn.mas_top).with.offset(-10);
    }];
    
    
    
    
}

-(void)ActionSelect:(UIButton*)sender{
    
    if (sender.tag == 7) {
        
        [sender setSelected:!sender.selected];
        
        [self.deleteVoiceBtn setSelected:NO];
        [self.flipHorizontalBtn setSelected:NO];
        [self.flipVerticalBtn setSelected:NO];
        [self.speedPlusBtn setSelected:NO];
        [self.speedMinusBtn setSelected:NO];
        [self.smartBorderBtn setSelected:NO];
        
        
    }else if (sender.tag == 6 && !sender.selected) {
        
        [self.smartClearBtn setSelected:NO];
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.scaleAspectFillCrop=YES;
        imagePickerVc.cropRect = CGRectMake(self.view.frame.size.width/2-1080/2, self.view.frame.size.height/2-1920/2, 1080, 1920);
        imagePickerVc.allowCrop = YES;
         //你可以通过block或者代理，来得到用户选择的照片.
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//            NSLog(@"%@",photos);
//            PHAsset *ass = [assets firstObject];
//            NSLog(@"%@",ass);
            TZImageManager *tzi = [TZImageManager new];
            UIImage *img =  [tzi scaleImage:[photos firstObject] toSize:CGSizeMake(1080,1920)];
            NSData *imageData = UIImagePNGRepresentation(img);
            [imageData writeToFile:DocumentPath(@"bg.png") atomically:YES];
            
            [sender setSelected:!sender.selected];
            
    //            PHAssetResource *resu = [[PHAssetResource assetResourcesForAsset:ass] firstObject];
    //
    //            NSString *url = [resu valueForKey:@"privateFileURL"];
    //
    //            NSLog(@"%@",url);
            
    //            self->_logoPic = DocumentPath(@"logo.png");
            
        }];
        
        [self presentViewController:imagePickerVc animated:YES completion:^{
            
            
        }];
        
    }else{
        
        [self.smartClearBtn setSelected:NO];
        
        [sender setSelected:!sender.selected];
        
    }
    
    
   
    
    
}


-(void)upDown:(UIButton*)btn{
    
    __weak typeof(self) weakSelf = self;
    
    if (btn.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            
            [weakSelf.actBar mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.bottom.equalTo(weakSelf.playLayer.mas_bottom).with.offset(-10);
                make.right.equalTo(weakSelf.playLayer.mas_right).with.offset(-10);
                make.width.equalTo(@75);
                make.height.equalTo(@50);
            }];
            
            [self.view layoutIfNeeded];
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            
            [weakSelf.actBar mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.playLayer.mas_top).with.offset(20);
                make.bottom.equalTo(weakSelf.playLayer.mas_bottom).with.offset(-10);
                make.right.equalTo(weakSelf.playLayer.mas_right).with.offset(-10);
                make.width.equalTo(@75);
            }];
            
            [self.view layoutIfNeeded];
        }];
    }
    
    
    
    
    
    [btn setSelected:!btn.selected];
    
    
    
}


-(void)playerSet{
    
    self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:_url]];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.backgroundColor = [UIColor colorWithHexString:@"#171616"].CGColor;
    playerLayer.bounds = CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_WIDTH);
    playerLayer.position = CGPointMake(SCREEN_WIDTH/2, SCREEN_WIDTH/2);
    [_playLayer.layer addSublayer:playerLayer];
    
    __weak typeof(self) weakSelf = self;
    
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, NSEC_PER_SEC) queue:NULL usingBlock:^(CMTime time) {
        CGFloat progress = CMTimeGetSeconds(weakSelf.player.currentItem.currentTime)/CMTimeGetSeconds(weakSelf.player.currentItem.duration);
        
        if (progress == 1.0f) {
            [weakSelf.player pause];
            [weakSelf.PlayBtn setSelected:NO];
        }
        
    }];
    
    
    
}



-(void)actionCommand{
    
    [self.player pause];
    
    [self.PlayBtn setSelected:NO];
  
    [_actBarSwitchBtn setSelected:YES];
    
    [self upDown:_actBarSwitchBtn];
    
    if (!_url) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"未选择任何视频"];
        return;
    }
    
    [SVProgressHUD show];
    
    NSMutableArray *arr = [NSMutableArray new];
    
    FFMpegCommand *ffMpeg = [FFMpegCommand new];
    
    NSString *fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
    
    NSString *inputUrl = _url;
    
    if (_flipHorizontalBtn.selected) {
        
        NSString *cmd =  [ffMpeg ffmpeg_command_flip_horizontalWithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        
        [arr addObject:cmd];
        
        inputUrl = DocumentPath(fileName);
         
    }
    
    if (_flipVerticalBtn.selected) {
        fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
        
        NSString *cmd =  [ffMpeg ffmpeg_command_flip_verticalWithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        
        [arr addObject:cmd];
        
        inputUrl = DocumentPath(fileName);
    }
    
    if (_speedPlusBtn.selected) {
        
        fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
        
        NSString *cmd =  [ffMpeg ffmpeg_command_SpeedPlusWithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        
        [arr addObject:cmd];
        
        inputUrl = DocumentPath(fileName);
        
    }
    
    if (_speedMinusBtn.selected) {
        
        fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
        
        NSString *cmd =  [ffMpeg ffmpeg_command_SpeedMinsWithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        
        [arr addObject:cmd];
        
        inputUrl = DocumentPath(fileName);
        
    }
    
    if (_deleteVoiceBtn.selected) {
        
        fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
        
        NSString *cmd =  [ffMpeg ffmpeg_command_DelVoiceWithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        
        [arr addObject:cmd];
        
        inputUrl = DocumentPath(fileName);
        
    }
    
    if (_smartBorderBtn.selected) {
        
        
        
        fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
        
//        NSString *cmd0 =  [ffMpeg ffmpeg_command_ScaleTargetHeightWithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        
        NSString *cmd0;
        
        if (_videoHorizontal) {
            cmd0 = [ffMpeg ffmpeg_command_ScaleWithHeight:608 WithWidth:1080 WithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        }else{
            cmd0 = [ffMpeg ffmpeg_command_Scale1080WithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        }
        
        
        
        [arr addObject:cmd0];
        
        inputUrl = DocumentPath(fileName);
        
        
        
        fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
        
        NSString *cmd =  [ffMpeg ffmpeg_command_SetPicBorderWithInPut:inputUrl WithOutPut:DocumentPath(fileName) withPic:DocumentPath(@"bg.png")];
        
        [arr addObject:cmd];
        
        inputUrl = DocumentPath(fileName);
        
        
    }
    
    if (_smartClearBtn.selected) {
        
        UIImage *img = [[UIImage alloc] createImageWithSize:CGSizeMake(1080, 1920) gradientColors:@[[UIColor colorWithHexString:@"#000000"],[UIColor colorWithHexString:@"#000000"]] percentage:@[@(0.1),@(1)] gradientType:GradientFromLeftTopToRightBottom];
        
        BOOL isWrite =  [UIImagePNGRepresentation(img) writeToFile:DocumentPath(@"bg.png") atomically:YES];
        
        if (isWrite) {
            NSLog(@"ok");
        }else{
            NSLog(@"not ok");
        }
        
        fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
        
        
        NSString *cmd0;
        
        if (_videoHorizontal) {
            cmd0 = [ffMpeg ffmpeg_command_ScaleWithHeight:608 WithWidth:1080 WithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        }else{
            cmd0 = [ffMpeg ffmpeg_command_Scale1080WithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        }
        
        
        fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
        
        NSString *cmd =  [ffMpeg ffmpeg_command_SetPicBorderWithInPut:inputUrl WithOutPut:DocumentPath(fileName) withPic:DocumentPath(@"bg.png")];
        
        [arr addObject:cmd];
        
        inputUrl = DocumentPath(fileName);
        
    }
    
    
    if ([arr count] <=0) {
        
        [SVProgressHUD showErrorWithStatus:@"未选择任何效果"];
        
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    [ffMpeg ffmpeg_commandWithCmdArray:arr WithProgress:^(float result) {
        
        NSLog(@"WithProgress:%f",result);
        
    } WithCompletionBlock:^(int result) {
        
        
        if (result == 0) {
//            if (self->btn9.selected) {
//                [self to16_9withUrl:DocumentPath(fileName)];
//            }else{
                [SVProgressHUD showSuccessWithStatus:@"处理成功"];

                [SVProgressHUD dismissWithCompletion:^{
                    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:DocumentPath(fileName)]];
                    [weakSelf.player replaceCurrentItemWithPlayerItem:item];
                    [weakSelf.player play];
                    [weakSelf.PlayBtn setSelected:YES];
                    
                    weakSelf.finalUrl = DocumentPath(fileName);

                }];
//            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"处理失败"];
        }
    }];
    
}

@end
