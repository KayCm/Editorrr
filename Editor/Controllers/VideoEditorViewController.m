//
//  VideoEditorViewController.m
//  Editor
//
//  Created by Kai on 2022/4/22.
//
#import "Masonry.h"
#import "FFMpegCommand.h"
#import "SVProgressHUD.h"
#import "UIColor+Extension.h"
#import "UIButton+Gradient.h"
#import "VideoEditorViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "VideoCollectionViewCell.h"

@interface VideoEditorViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)UIView *playLayer;
@property(nonatomic,strong)UICollectionView *vidCollectionView;
@property(nonatomic,strong)NSString *finalUrl;
@end

@implementation VideoEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self viewSetup];
    
    [self playerSet];
}

-(void)viewSetup{
    
    [self.navigationController.navigationBar setHidden:YES];
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat navBar_Height =  self.navigationController.navigationBar.frame.size.height;
    UIWindow *window = [UIApplication.sharedApplication.windows firstObject];
    NSLog(@"top == %f",window.safeAreaInsets.top);
    NSLog(@"bottom == %f",window.safeAreaInsets.bottom);
    
    
    UIView *topCtrbar = [UIView new];
    topCtrbar.backgroundColor = [UIColor colorWithHexString:@"#171616"];
    [self.view addSubview:topCtrbar];
    
    [topCtrbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.height.equalTo(@(navBar_Height+window.safeAreaInsets.top));
    }];
    
    
    UIView *navView = [UIView new];
    [self.view addSubview:navView];
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(window.safeAreaInsets.top);
        make.height.equalTo(@(navBar_Height));
    }];
    
    
    
    
    UIButton *backBtn = [UIButton new];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(38.5/2));
        make.width.equalTo(@(26.5/2));
        make.centerY.equalTo(navView.mas_centerY);
        make.left.equalTo(navView.mas_left).with.offset(16);
    }];
    [backBtn addTarget:self action:@selector(navBack) forControlEvents:UIControlEventTouchUpInside];
    
    

    UIButton *vidSend = [UIButton new];
    vidSend.layer.cornerRadius = 5;
    vidSend.layer.masksToBounds = YES;
    [vidSend setTitle:@"发布至抖音" forState:UIControlStateNormal];
    [vidSend.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [vidSend gradientButtonWithSize:CGSizeMake(75, 24) colorArray:@[[UIColor colorWithHexString:@"#4DCBFF"],[UIColor colorWithHexString:@"#BE4EFF"]] percentageArray:@[@(0.1),@(1)] gradientType:GradientFromLeftToRight];
    [navView addSubview:vidSend];
    [vidSend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@24);
        make.width.equalTo(@75);
        make.centerY.equalTo(navView.mas_centerY);
        make.right.equalTo(navView.mas_right).with.offset(-16);
    }];
    
    [vidSend addTarget:self action:@selector(videoEdit) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *vidEdit = [UIButton new];
    vidEdit.layer.cornerRadius = 5;
    vidEdit.layer.masksToBounds = YES;
    [vidEdit setTitle:@"视频处理" forState:UIControlStateNormal];
    [vidEdit.titleLabel setFont:[UIFont systemFontOfSize:11]];
    vidEdit.backgroundColor = [UIColor colorWithHexString:@"#414141"];
    [navView addSubview:vidEdit];
    [vidEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@24);
        make.width.equalTo(@75);
        make.centerY.equalTo(navView.mas_centerY);
        make.right.equalTo(vidSend.mas_left).with.offset(-16);
    }];
    
    [vidEdit addTarget:self action:@selector(commandRun) forControlEvents:UIControlEventTouchUpInside];
    
    
    _playLayer = [UIView new];
    _playLayer.backgroundColor = [UIColor colorWithHexString:@"#181818"];
    [self.view addSubview:_playLayer];
    
    [_playLayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(navView.mas_bottom).with.offset(0);
        make.height.equalTo(_playLayer.mas_width).multipliedBy(1.1);
    }];
    
    
    
    UIView *ctrView = [UIView new];
    ctrView.backgroundColor = [UIColor colorWithHexString:@"#171616"];
    [self.view addSubview:ctrView];
    
    [ctrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_playLayer.mas_bottom);
        make.height.equalTo(@40);
    }];
    
    UIButton *playBtn = [UIButton new];
    [playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    [ctrView addSubview:playBtn];
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ctrView.mas_centerX).with.offset(0);
        make.centerY.equalTo(ctrView.mas_centerY);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
    }];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.vidCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:self.vidCollectionView];
    self.vidCollectionView.dataSource = self;
    self.vidCollectionView.delegate   = self;
    [self.vidCollectionView registerClass:[VideoCollectionViewCell class] forCellWithReuseIdentifier:@"VideoCollectionViewCell"];
    self.vidCollectionView.backgroundColor = [UIColor blackColor];
    [self.vidCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(ctrView.mas_bottom);
        make.height.equalTo(@100);
    }];
    UILongPressGestureRecognizer *longPresssGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMethod:)];
    [self.vidCollectionView addGestureRecognizer:longPresssGes];
    
    
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"#181818"];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.height.equalTo(@(window.safeAreaInsets.bottom));
    }];
    
    UIView *bottomCtrView = [UIView new];
    bottomCtrView.backgroundColor = [UIColor colorWithHexString:@"#181818"];
    [self.view addSubview:bottomCtrView];
    
    [bottomCtrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(bottomView.mas_top).with.offset(0);
        make.height.equalTo(@60);
    }];
    
   
}


-(void)commandRun{
    
    [SVProgressHUD show];
    
    float timeName = [[NSDate date] timeIntervalSince1970];
    
    NSMutableArray *arr = [NSMutableArray new];
    
    NSString *str = @"";
    for (int i = 0;i<self.assets.count;i++) {
        
        NSDictionary *dict = [self.assets objectAtIndex:i];
        
        NSString *name = [NSString stringWithFormat:@"%f-%d.mp4",timeName,i];
        
        NSString *cmd =  [NSString stringWithFormat:@"ffmpeg -i %@ -s hd720 -r 30000/1001 -video_track_timescale 30k -c:a copy %@",
                          dict[@"url"],DocumentPath(name)];
    
        [arr addObject:cmd];
        
        str = [NSString stringWithFormat:@"%@file '%@'\n",str,DocumentPath(name)];
        
    }
    [self writeToTXTFileWithString:str fileName:@"file"];
    
    FFMpegCommand *ffMpeg = [FFMpegCommand new];
    
    NSString *fileName = [NSString stringWithFormat:@"%f.mp4",timeName];

    NSString* cmd =  [ffMpeg ffmpeg_command_manyVideo:DocumentPath(@"file.txt") WithOutPut:DocumentPath(fileName)];

    [arr addObject:cmd];
    

    __weak typeof(self) weakSelf = self;
    
    [ffMpeg ffmpeg_commandWithCmdArray:arr WithProgress:^(float result) {
        
        NSLog(@"WithProgress:%f",result);
        
    } WithCompletionBlock:^(int result) {
        
        NSLog(@"WithProgress:%d",result);
        
        if (result == 0) {
                [SVProgressHUD showSuccessWithStatus:@"处理成功"];

                [SVProgressHUD dismissWithCompletion:^{
                    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:DocumentPath(fileName)]];
                    [weakSelf.player replaceCurrentItemWithPlayerItem:item];
                    [weakSelf.player play];
                    weakSelf.finalUrl = DocumentPath(fileName);

                }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"处理失败"];
        }
        
    }];
    
}


-(void)playerSet{
    
    self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:@""]];
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
        }
        
    }];
}



-(void)navBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)videoEdit{
    
    NSLog(@"%@",self.assets);
    
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
 return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _assets.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    VideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor blackColor];
    
    NSDictionary *dict = [_assets objectAtIndex:indexPath.row];
    
    [cell.img setImage:dict[@"photo"]];
    
    return cell;
    
}

// 设置cell大小 itemSize：可以给每一个cell指定不同的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = [_assets objectAtIndex:indexPath.row];
    
    
    
    

    return CGSizeMake(100,100);
}

- (void)longPressMethod:(UILongPressGestureRecognizer *)longPressGes {
    // 判断手势状态
    switch (longPressGes.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            // 判断手势落点位置是否在路径上(长按cell时,显示对应cell的位置,如path = 1 - 0,即表示长按的是第1组第0个cell). 点击除了cell的其他地方皆显示为null
            NSIndexPath *indexPath = [self.vidCollectionView indexPathForItemAtPoint:[longPressGes locationInView:self.vidCollectionView]];
            // 如果点击的位置不是cell,break
            if (nil == indexPath) {
                break;
            }
            NSLog(@"%@",indexPath);
            // 在路径上则开始移动该路径上的cell
            [self.vidCollectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
            // 移动过程当中随时更新cell位置
            [self.vidCollectionView updateInteractiveMovementTargetPosition:[longPressGes locationInView:self.vidCollectionView]];
            break;
            
        case UIGestureRecognizerStateEnded:
            // 移动结束后关闭cell移动
            [self.vidCollectionView endInteractiveMovement];
            break;
        default:
            [self.vidCollectionView cancelInteractiveMovement];
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSDictionary *dic = self.assets[sourceIndexPath.row];
    [self.assets removeObject:dic];
    [self.assets insertObject:dic atIndex:destinationIndexPath.row];
}

// 设置minimumLineSpacing：cell上下之间最小的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
 return 0;
}

// 设置minimumInteritemSpacing：cell左右之间最小的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
 return 2;
}


- (void)writeToTXTFileWithString:(NSString *)string fileName:(NSString *)fileName {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized (self) {
            //获取沙盒路径
            NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            //获取文件路径
            NSString *fullName = [NSString stringWithFormat:@"%@.txt", fileName];
            NSString *theFilePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fullName];
            
            NSLog(@"%@",string);
            NSLog(@"%@",theFilePath);
            
            //创建文件管理器
            NSFileManager *fileManager = [NSFileManager defaultManager];
            //如果文件不存在 创建文件
            if(![fileManager fileExistsAtPath:theFilePath]){
                [@"" writeToFile:theFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:theFilePath];
//            [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
            NSData* stringData  = [[NSString stringWithFormat:@"%@\n",string] dataUsingEncoding:NSUTF8StringEncoding];
            [fileHandle writeData:stringData]; //追加写入数据
            [fileHandle closeFile];
        }
    });
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
