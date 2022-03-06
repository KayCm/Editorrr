//
//  MainViewController.m
//  Editor
//
//  Created by Kai on 2022/2/25.
//

#import "MainViewController.h"
#import "Masonry.h"
#import "EffectViewCell.h"
#import "FFMpegCommand.h"
#import "VideoEditViewController.h"
#import "SVProgressHUD.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayerViewController.h"
#import "TZImagePickerController.h"
#import "GetVideoViewController.h"

@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,TZImagePickerControllerDelegate>{
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    UIButton *btn5;
    UIButton *btn6;
    UIButton *btn7;
    UIButton *btn8;
    UIButton *btn9;
    int playTime;
    bool isHorizontal;
    
}

@property(nonatomic,strong)AVPlayer *player;

@property(nonatomic,strong)UIView *videoBg;

@property(nonatomic,strong)UIButton *playBtn;

@property(nonatomic,strong)NSString *selectUrl;

@property(nonatomic,strong)NSString *logoPic;

@property(nonatomic,strong)NSArray *effectArr;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self viewSetup];
    
    _effectArr = @[@"去水印",@"智能清洗",@"智能边框",@"背景模糊",@"去除边框",@"智能加速",@"智能慢放",@"智能压缩",@"智能反转",@"去除声"];
    
//    _selectUrl = BundlePath(@"2022.mp4");
    
    
}


#pragma mark - 界面设定
- (void)viewSetup{
    
    UIView *navBar = [UIView new];
    navBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navBar];
    
    [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.height.equalTo(@(88));
    }];
    
    
    UIView *navTitle = [UIView new];
    navTitle.backgroundColor = [UIColor whiteColor];
    [navBar addSubview:navTitle];
    
    [navTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(navBar.mas_bottom).with.offset(0);
        make.height.equalTo(@(44));
    }];
    
    
    
    UILabel *navTitleLbl = [UILabel new];
//    navTitleLbl.backgroundColor = [UIColor redColor]
    navTitleLbl.text = @"视频编辑";
    navTitleLbl.font = [UIFont boldSystemFontOfSize:20];
    navTitleLbl.textAlignment = NSTextAlignmentCenter;
    [navTitle addSubview:navTitleLbl];
    [navTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(navTitle.mas_centerY);
        make.centerX.equalTo(navTitle.mas_centerX);
        make.height.equalTo(@24);
        make.width.equalTo(@200);
    }];
    
    
    _videoBg = [UIView new];
    _videoBg.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:_videoBg];
    [_videoBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(navBar.mas_bottom).with.offset(5);
        make.height.equalTo(@(SCREEN_WIDTH*0.5625));
    }];
    
    //NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"2022" ofType:@"mp4"];
    self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:@""]];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    playerLayer.bounds = CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_WIDTH*0.5625);
    playerLayer.position = CGPointMake(SCREEN_WIDTH/2, SCREEN_WIDTH*0.5625/2);
    [_videoBg.layer addSublayer:playerLayer];
    
    
    UIView *playToolsView = [UIView new];
    playToolsView.backgroundColor = [UIColor blackColor];
    playToolsView.alpha = 0.5;
    [_videoBg addSubview:playToolsView];
    
    
    [playToolsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_videoBg);
        make.bottom.equalTo(_videoBg.mas_bottom);
        make.height.equalTo(@40);
    }];
    
    
    
    _playBtn = [UIButton new];
    [_playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [_playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    [playToolsView addSubview:_playBtn];
    
    [_playBtn addTarget:self action:@selector(playerSet) forControlEvents:UIControlEventTouchUpInside];
    
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(playToolsView.mas_centerY);
        make.left.equalTo(playToolsView.mas_left).with.offset(10);
        make.height.width.equalTo(@24);
        
    }];
    
    
    UIButton *selectBtn = [UIButton new];
    [selectBtn setImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
    [self.view addSubview:selectBtn];
    [selectBtn addTarget:self action:@selector(openImgLibrary) forControlEvents:UIControlEventTouchUpInside];
    
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_videoBg.mas_bottom).with.offset(5);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.width.equalTo(@22);
        make.height.equalTo(@22);
    }];
    
    
    UIButton *addBtn = [UIButton new];
    [addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.view addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addWithDownLoad) forControlEvents:UIControlEventTouchUpInside];
    
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_videoBg.mas_bottom).with.offset(5);
        make.right.equalTo(selectBtn.mas_left).with.offset(-20);
        make.width.equalTo(@22);
        make.height.equalTo(@22);
    }];
    

    
    
    UILabel *effectLbl = [UILabel new];
    effectLbl.text = @"效果选择";
    effectLbl.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:effectLbl];
    
    [effectLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(selectBtn.mas_bottom).with.offset(5);
        make.height.equalTo(@(24));
    }];
    
    
    UIView *effectListView = [UIView new];
    [self.view addSubview:effectListView];
    
    [effectListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(5);
        make.right.equalTo(self.view.mas_right).with.offset(-5);
        make.top.equalTo(effectLbl.mas_bottom).with.offset(10);
        make.height.equalTo(@(230));
    }];
    
    
    btn1 = [UIButton new];
    [btn1 setTitle:@"水平翻转" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [effectListView addSubview:btn1];
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(effectListView.mas_top);
        make.left.equalTo(effectListView.mas_left);
        make.height.equalTo(@50);
        make.width.equalTo(@90);
    }];
    
    btn2 = [UIButton new];
    [btn2 setTitle:@"垂直翻转" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [effectListView addSubview:btn2];
    btn2.tag = 2;
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(effectListView.mas_top);
        make.left.equalTo(btn1.mas_right);
        make.height.equalTo(@50);
        make.width.equalTo(@90);
    }];
    
    
    btn3 = [UIButton new];
    [btn3 setTitle:@"加速" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [effectListView addSubview:btn3];
    btn3.tag = 3;
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(effectListView.mas_top);
        make.left.equalTo(btn2.mas_right);
        make.height.equalTo(@50);
        make.width.equalTo(@90);
    }];
    
    btn4 = [UIButton new];
    [btn4 setTitle:@"减速" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [effectListView addSubview:btn4];
    btn4.tag = 4;
    [btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(effectListView.mas_top);
        make.left.equalTo(btn3.mas_right);
        make.height.equalTo(@50);
        make.width.equalTo(@90);
    }];
    
    btn5 = [UIButton new];
    [btn5 setTitle:@"裁剪*" forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [effectListView addSubview:btn5];
    btn5.tag = 5;
    [btn5 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn4.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@50);
        make.width.equalTo(@90);
    }];
    
    btn6 = [UIButton new];
    [btn6 setTitle:@"尾部logo删除" forState:UIControlStateNormal];
    [btn6 setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [btn6 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [effectListView addSubview:btn6];
    btn6.tag = 6;
    [btn6 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn4.mas_bottom).with.offset(10);
        make.left.equalTo(btn5.mas_right);
        make.height.equalTo(@50);
        make.width.equalTo(@140);
    }];
    
    
    btn7 = [UIButton new];
    [btn7 setTitle:@"添加图片logo" forState:UIControlStateNormal];
    [btn7 setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [btn7 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [effectListView addSubview:btn7];
    btn7.tag = 7;
    [btn7 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn4.mas_bottom).with.offset(10);
        make.left.equalTo(btn6.mas_right);
        make.height.equalTo(@50);
        make.width.equalTo(@160);
    }];
    
    
    btn8 = [UIButton new];
    [btn8 setTitle:@"除声" forState:UIControlStateNormal];
    [btn8 setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [btn8 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [effectListView addSubview:btn8];
    btn8.tag = 8;
    [btn8 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn5.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@50);
        make.width.equalTo(@90);
    }];
    
    
    btn9 = [UIButton new];
    [btn9 setTitle:@"将竖向视频输出成横向视频(耗时较长)" forState:UIControlStateNormal];
    [btn9 setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [btn9 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [effectListView addSubview:btn9];
    btn9.tag = 9;
    [btn9 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    [btn9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn8.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@50);
        make.width.equalTo(@345);
    }];
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    // 设置item的行间距和列间距
//    layout.minimumInteritemSpacing = 0;
//    layout.minimumLineSpacing = 0;
//    // 设置item的大小
//    CGFloat itemW = (SCREEN_WIDTH - 60) /4 ;
//    layout.itemSize = CGSizeMake(itemW, itemW);
//    // 设置每个分区的 上左下右 的内边距
//    // 设置滚动条方向
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    UICollectionView *effectListView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
//    effectListView.showsVerticalScrollIndicator = NO;
//    effectListView.showsHorizontalScrollIndicator = NO;
////    effectListView.scrollEnabled = YES;
////    effectListView.pagingEnabled = YES;
//    //注册cell
//    [effectListView registerClass:[EffectViewCell class] forCellWithReuseIdentifier:@"EffectViewCell"];
//    effectListView.delegate = self;
//    effectListView.dataSource = self;
////    effectListView.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:effectListView];
//    [effectListView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset(5);
//        make.right.equalTo(self.view.mas_right).with.offset(-5);
//        make.top.equalTo(effectLbl.mas_bottom).with.offset(10);
//        make.height.equalTo(@(itemW*2));
//    }];
    
    
    UIView *cmdBar = [UIView new];
//    cmdBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:cmdBar];
    
    [cmdBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.top.equalTo(effectListView.mas_bottom).with.offset(30);
        make.height.equalTo(@80);
    }];
    
    
    
    UIButton *playBtn = [UIButton new];
    playBtn.backgroundColor = [UIColor whiteColor];
    [playBtn setTitle:@"预览" forState:UIControlStateNormal];
    [playBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [playBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [cmdBar addSubview:playBtn];
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cmdBar.mas_centerY).with.offset(0);
        make.right.equalTo(cmdBar.mas_centerX);
        make.width.equalTo(@200);
        make.height.equalTo(@50);
    }];
    [playBtn addTarget:self action:@selector(playPre) forControlEvents:UIControlEventTouchUpInside];

    
    
    
//    UIButton *commitBtn = [UIButton new];
//    commitBtn.backgroundColor = [UIColor whiteColor];
//    [commitBtn setTitle:@"保存" forState:UIControlStateNormal];
//    [commitBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
//    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    [cmdBar addSubview:commitBtn];
//
//    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(cmdBar.mas_centerY).with.offset(0);
//        make.left.equalTo(cmdBar.mas_centerX);
//        make.width.equalTo(@200);
//        make.height.equalTo(@50);
//    }];
//
//    [commitBtn addTarget:self action:@selector(command) forControlEvents:UIControlEventTouchUpInside];
//
    //[self playerSet];
    
    [self delFiles];
    
}

-(void)playPre{
    if (!_selectUrl) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"未选择任何视频"];
        return;
    }
    
    [self.player pause];
    
    [self.playBtn setSelected:NO];
    
    [SVProgressHUD show];
    
    NSMutableArray *arr = [NSMutableArray new];
    
    FFMpegCommand *ff = [FFMpegCommand new];
    
    NSString *fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
    
    NSString *inputUrl = _selectUrl;
    
    
    if (btn1.selected) {
        
        NSString *cmd =  [ff ffmpeg_command_flip_horizontalWithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        
        [arr addObject:cmd];
        
        inputUrl = DocumentPath(fileName);
         
    }
    
    if (btn2.selected) {
        
        fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
        
        NSString *cmd =  [ff ffmpeg_command_flip_verticalWithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        
        [arr addObject:cmd];
        
        inputUrl = DocumentPath(fileName);
        
    }
    
    if (btn6.selected) {
        
        fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
        
        NSString *cmd;// =  [ff ffmpeg_command_ScaleTargetHeightWithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        
        cmd =  [ff ffmpeg_command_DelEndLogoWithInPut:inputUrl WithOutPut:DocumentPath(fileName) WithTotalTime:playTime-3];
        
        [arr addObject:cmd];
        
        inputUrl = DocumentPath(fileName);
        
    }
    
    
    if (btn3.selected) {
        
        fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
        
        NSString *cmd =  [ff ffmpeg_command_SpeedPlusWithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        
        [arr addObject:cmd];
        
        inputUrl = DocumentPath(fileName);
        
    }
    
    if (btn4.selected) {
        
        fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
        
        NSString *cmd =  [ff ffmpeg_command_SpeedMinsWithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        
        [arr addObject:cmd];
        
        inputUrl = DocumentPath(fileName);
        
    }
    
    if (btn5.selected) {
        
        fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
        
        NSString *cmd;// =  [ff ffmpeg_command_ScaleTargetHeightWithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        
        
        if (isHorizontal) {
            cmd =  [ff ffmpeg_command_ScaleTargetHeightWithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        }else{
            cmd =  [ff ffmpeg_command_ScaleTargetWidthWithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        }
        
        [arr addObject:cmd];
        
        inputUrl = DocumentPath(fileName);
        
    }
    
    
    if (btn7.selected) {
        
        fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
        
        NSString *cmd =  [ff ffmpeg_command_SetLogoInPut:inputUrl WithOutPut:DocumentPath(fileName) withPic:_logoPic];
        
        [arr addObject:cmd];
        
        inputUrl = DocumentPath(fileName);
        
    }
    
    
    if (btn8.selected) {
        
        fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
        
        NSString *cmd =  [ff ffmpeg_command_DelVoiceWithInPut:inputUrl WithOutPut:DocumentPath(fileName)];
        
        [arr addObject:cmd];
        
        inputUrl = DocumentPath(fileName);
        
    }

    
    NSLog(@"%@",arr);
    
    [ff ffmpeg_commandArray:arr completionBlock:^(int result) {
        if (result == 0) {
            
            if (self->btn9.selected) {
                [self to16_9withUrl:DocumentPath(fileName)];
            }else{
                [SVProgressHUD showSuccessWithStatus:@"处理成功"];

                [SVProgressHUD dismissWithCompletion:^{
                    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:DocumentPath(fileName)]];
                    [self.player replaceCurrentItemWithPlayerItem:item];
                    [self.playBtn setSelected:YES];
                    [self.player play];

                }];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"处理失败"];
        }
    }];
    
}

-(void)btnClick:(UIButton*)btn{
    
    
    if (btn.tag == 7 && !btn.selected) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];

        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.scaleAspectFillCrop=YES;
        imagePickerVc.cropRect = CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-100, 200, 200);
        imagePickerVc.allowCrop = YES;
        
    
        // 你可以通过block或者代理，来得到用户选择的照片.
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            NSLog(@"%@",photos);
            
            PHAsset *ass = [assets firstObject];
            
            NSLog(@"%@",ass);
            
            TZImageManager *tzi = [TZImageManager new];
            
           UIImage *img =  [tzi scaleImage:[photos firstObject] toSize:CGSizeMake(200,200)];
            
            NSData *imageData = UIImagePNGRepresentation(img);
            
            [imageData writeToFile:DocumentPath(@"logo.png") atomically:YES];
            
            
//            PHAssetResource *resu = [[PHAssetResource assetResourcesForAsset:ass] firstObject];
//
//            NSString *url = [resu valueForKey:@"privateFileURL"];
//
//            NSLog(@"%@",url);
            
            self->_logoPic = DocumentPath(@"logo.png");
            
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
    
    
    if (btn.tag == 9 && isHorizontal) {
        
        NSLog(@"水平视频不能使用该选项");
        
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"水平视频不能选择该选项"];
        
        return;
    }
    

    [btn setSelected:!btn.selected];

    
}


-(void)to16_9withUrl:(NSString*)url{

    NSString *fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
    
    NSString *fileNameout = [NSString stringWithFormat:@"out%f.mp4",[[NSDate date] timeIntervalSince1970]];
    
    [SVProgressHUD show];
    
    FFMpegCommand *ff = [FFMpegCommand new];
    
    
    
    //生产背景
    NSString *fileNameBg = [NSString stringWithFormat:@"bg%f.mp4",[[NSDate date] timeIntervalSince1970]];
   
    NSString *cmd19_9  =  [ff ffmpeg_command_to16_9:url
                                         WithOutPut:DocumentPath(fileNameBg)];
    

    [ff ffmpeg_commandArray:@[cmd19_9] completionBlock:^(int result) {

        
        NSArray *arrs = @[[ff ffmpeg_command_Scale1080WithInPut:url WithOutPut:DocumentPath(fileName)],
        [ff ffmpeg_command_picInPicWithInPut:DocumentPath(fileName) WithOutPut:DocumentPath(fileNameout) withPic:DocumentPath(fileNameBg)]];

        [ff ffmpeg_commandArray:arrs completionBlock:^(int result) {
            if (result == 0) {
                [SVProgressHUD showSuccessWithStatus:@"处理成功"];

                [SVProgressHUD dismissWithCompletion:^{
                    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:DocumentPath(fileNameout)]];
                    [self.player replaceCurrentItemWithPlayerItem:item];
                    [self.playBtn setSelected:YES];
                    [self.player play];

                }];
            }else{
                [SVProgressHUD showErrorWithStatus:@"处理失败"];
            }
        }];
        
    }];
    

    
}


-(void)command{
    
    
    
    
    if (!_selectUrl) {
        
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"未选择任何视频"];
        
        return;
    }
    
    
    [self playerStop];
    
    NSString *fileName = [NSString stringWithFormat:@"%f.mp4",[[NSDate date] timeIntervalSince1970]];
    
    [SVProgressHUD show];
    
    FFMpegCommand *ff = [FFMpegCommand new];

    //分辨率修改
    //NSString *str = [NSString stringWithFormat:@"ffmpeg -i %@ -s 640x480 %@",BundlePath(@"2022.mp4"),DocumentPath(@"91.mp4")];
    
    
    //视频加减速 setpts=4*PTS 减速4倍  setpts=0.25*PTS 加速4倍
//    NSString *str = [NSString stringWithFormat:
//                     @"ffmpeg -i %@ -s 1920x1080 -vf setpts=4*PTS %@",_selectUrl,DocumentPath(fileName)];
    
    //音视频同时加/减速
//    NSString *str = [NSString stringWithFormat:
//                     @"ffmpeg -i %@ -filter_complex [0:v]setpts=0.5*PTS[v];[0:a]atempo=2.0[a] -map [v] -map [a] %@",
//                     _selectUrl,
//                     DocumentPath(fileName)];
    
    //视频分辨率调整 给视频上下左右添加50像素黑边
    //scale:将视频缩小到620*476，给即将添加的黑边预留像素
    //pad: “宽”、“高”、“X坐标”和“Y坐标”，宽和高指的是输入视频尺寸（包含加黑边的尺寸），XY指的是视频所在位置
//    NSString *str = [NSString stringWithFormat:@"ffmpeg -i %@ -vf scale=640:480,setdar=4:3,pad=640:780:0:150:black %@ -hide_banner",_selectUrl,
//                     DocumentPath(fileName)];
    
    
//    NSString *str = [NSString stringWithFormat:@"ffmpeg -i %@ -vf boxblur=20:1:cr=0:ar=0 %@",
//                     _selectUrl,
//                     DocumentPath(fileName)];
    
    
//
    
//    //水平反转
//    NSString *str = [NSString stringWithFormat:@"ffmpeg -i %@ -vf hflip -y %@",_selectUrl,
//                                          DocumentPath(fileName)];
    
    
    
    //视频水印
//    NSString *str = [NSString stringWithFormat:@"ffmpeg -i %@ -i %@ -filter_complex overlay=0:0 -max_muxing_queue_size 1024 %@",_selectUrl,BundlePath(@"2022.mp4"),DocumentPath(fileName)];

    NSString *str;
    
    //str =  [ff getCommand:4 withInPut:_selectUrl withOutPut:DocumentPath(fileName) withOtherRes:@[BundlePath(@"she.png")]];
    
   
    
    
    NSArray *arrs;// = @[[ff ffmpeg_command_ScaleWithInPut:_selectUrl WithOutPut:DocumentPath(fileName)]];
    
    [ff ffmpeg_commandArray:arrs completionBlock:^(int result) {
        if (result == 0) {
            [SVProgressHUD showSuccessWithStatus:@"处理成功"];

            [SVProgressHUD dismissWithCompletion:^{
                PlayerViewController *play = [PlayerViewController new];
//                play.view.backgroundColor = [UIColor whiteColor];
                play.fileName = fileName;
                [self.navigationController pushViewController:play animated:YES];
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"处理失败"];
        }
    }];
    
//    str = [ff getCommand:5 withInPut:_selectUrl withOutPut:DocumentPath(fileName) withOtherRes:@[]];
//
//
//    [ff ffmpeg_command:str completionBlock:^(int result) {
//
//        NSLog(@"status:%d",result);
//
//        if (result == 0) {
//            [SVProgressHUD showSuccessWithStatus:@"处理成功"];
//
//            [SVProgressHUD dismissWithCompletion:^{
//                PlayerViewController *play = [PlayerViewController new];
////                play.view.backgroundColor = [UIColor whiteColor];
//                play.fileName = fileName;
//                [self.navigationController pushViewController:play animated:YES];
//            }];
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"处理失败"];
//        }
//    }];
    
}

#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_effectArr count];
    ;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //创建item 从缓存池中拿 Item
    EffectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EffectViewCell" forIndexPath:indexPath];
    if(!cell){
        cell = [[EffectViewCell alloc] init];
    }
    
    cell.lbl.text = _effectArr[indexPath.row];

    return cell;
    
}

-(void)gotoEdit{
    
    
    VideoEditViewController *ve = [VideoEditViewController new];
    
    
    [self.navigationController pushViewController:ve animated:YES];
    
}

-(void)playerSet{
    

    [self.player play];
    
    [_playBtn setSelected:YES];
    
}

-(void)playerStop{
    [self.player pause];
    
    [_playBtn setSelected:NO];
}


-(void)openImgLibrary{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];

    imagePickerVc.allowPickingImage = NO;
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSLog(@"%@",photos);
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


-(void)addWithDownLoad{
    
    GetVideoViewController *add = [GetVideoViewController new];
    
    [self presentViewController:add animated:YES completion:^{
            
    }];
    
    
}



- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset{
    
    NSLog(@"%@",coverImage);
    NSLog(@"%@",asset);
    

    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
               
    
    PHImageManager *manager = [PHImageManager defaultManager];
    [manager requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        AVURLAsset *urlAsset = (AVURLAsset *)asset;

        NSURL *url = urlAsset.URL;
        NSData *data = [NSData dataWithContentsOfURL:url];

        NSLog(@"%@",url);
        NSLog(@"%@",data);
        
        // file:///var/mobile/Media/DCIM/100APPLE/IMG_0403.MOV
        
        self->_selectUrl = [NSString stringWithFormat:@"%@",url] ;
        
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
        
        NSLog(@"%@",item);
        CGSize videoSize = CGSizeZero;
        NSArray *arr =  asset.tracks;
        
        for (AVAssetTrack *t in arr) {
            if ([t.mediaType isEqualToString:AVMediaTypeVideo]) {
                videoSize = t.naturalSize;
            }
        }
        
        self->isHorizontal = false;
        
        if (videoSize.width > videoSize.height) {
            self->isHorizontal = true;
        }
        
        self->playTime = (int)item.asset.duration.value/item.asset.duration.timescale;
        
        //NSLog(@"%lld",self->playTime.value/self->playTime.timescale);
        
        [self.player replaceCurrentItemWithPlayerItem:item];
        
        [self.player play];
    
        
        
    }];
    
    [self.playBtn setSelected:YES];
    
}

-(void)delFiles{
    
    NSString *extension =@"mp4";
    
    NSFileManager*fileManager = [NSFileManager defaultManager];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    NSString*documentsDirectory = [paths objectAtIndex:0];

    NSArray*contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:nil];

    NSEnumerator*enumerator = [contents objectEnumerator];

    NSString*filename;

    while((filename = [enumerator nextObject])) {
        NSLog(@"filename %@",filename);
        if([[filename pathExtension] isEqualToString:extension]) {
            NSLog(@"delete %@",filename);
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:nil];
        }
    }
    
}

@end
