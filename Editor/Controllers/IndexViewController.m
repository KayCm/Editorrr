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
#import "VideoEditorViewController.h"

@interface IndexViewController ()<UITextViewDelegate,TZImagePickerControllerDelegate>
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
    
    [self delFiles];
        
}

-(void)viewSetup{
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.navigationController.navigationBar setHidden:YES];
    
    UIWindow *window = [UIApplication.sharedApplication.windows firstObject];
    NSLog(@"top == %f",window.safeAreaInsets.top);
    
    
    UIButton *SourceMake = [UIButton new];
    [SourceMake setTitle:@"素材加工" forState:UIControlStateNormal];
    SourceMake.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    SourceMake.layer.cornerRadius = 5;
    SourceMake.layer.masksToBounds = YES;
    [self.view addSubview:SourceMake];
    [SourceMake gradientButtonWithSize:CGSizeMake(278, 44) colorArray:@[[UIColor colorWithHexString:@"#4DCBFF"],[UIColor colorWithHexString:@"#BE4EFF"]] percentageArray:@[@(0.1),@(1)] gradientType:GradientFromLeftToRight];
    [SourceMake mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.width.equalTo(@278);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).with.offset(-window.safeAreaInsets.top);
    }];
    
    
    UIButton *LocalPhotos = [UIButton new];
    [LocalPhotos setTitle:@"本地相册" forState:UIControlStateNormal];
    LocalPhotos.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    LocalPhotos.layer.cornerRadius = 5;
    LocalPhotos.layer.masksToBounds = YES;
    [self.view addSubview:LocalPhotos];
    [LocalPhotos gradientButtonWithSize:CGSizeMake(278, 44) colorArray:@[[UIColor colorWithHexString:@"#4DCBFF"],[UIColor colorWithHexString:@"#BE4EFF"]] percentageArray:@[@(0.1),@(1)] gradientType:GradientFromLeftToRight];
    [LocalPhotos mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.width.equalTo(@278);
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(SourceMake.mas_top).with.offset(-20);
    }];
    
    
    
    UIButton *DouYinDownLoad = [UIButton new];
    [DouYinDownLoad setTitle:@"抖音下载" forState:UIControlStateNormal];
    DouYinDownLoad.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    DouYinDownLoad.layer.cornerRadius = 5;
    DouYinDownLoad.layer.masksToBounds = YES;
    [self.view addSubview:DouYinDownLoad];
    [DouYinDownLoad gradientButtonWithSize:CGSizeMake(278, 44) colorArray:@[[UIColor colorWithHexString:@"#4DCBFF"],[UIColor colorWithHexString:@"#BE4EFF"]] percentageArray:@[@(0.1),@(1)] gradientType:GradientFromLeftToRight];
    [DouYinDownLoad mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.width.equalTo(@278);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(SourceMake.mas_bottom).with.offset(20);
    }];
    
    [LocalPhotos addTarget:self action:@selector(openImgLibrary) forControlEvents:UIControlEventTouchUpInside];
    
    
}


-(void)openImgLibrary{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.allowPickingImage = NO;
    imagePickerVc.allowPickingMultipleVideo = YES;
    __weak typeof(self) weakSelf = self;
    
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        NSMutableArray *arr = [NSMutableArray new];
        
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        
        __block NSString *str = @"";
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_t group = dispatch_group_create();

        for (int i = 0; i< [assets count]; i++) {
            
            PHAsset *asset = [assets objectAtIndex:i];
            NSLog(@"%@",asset);
            PHImageManager *manager = [PHImageManager defaultManager];
            dispatch_group_enter(group);
            dispatch_group_async(group, queue, ^{
                [manager requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                    AVURLAsset *urlAsset = (AVURLAsset *)asset;
                    NSURL *url = urlAsset.URL;
                    NSLog(@"%@",url);
                    str = [NSString stringWithFormat:@"%@file '%@'\n",str,url];
                    
                    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
                
                    NSDictionary *dict = @{@"photo":photos[i],@"url":url,@"duration":@((int)item.asset.duration.value/item.asset.duration.timescale)};
                    
                    [arr addObject:dict];
                    
                    dispatch_group_leave(group);
                }];
            });
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            
            VideoEditorViewController *ve = [VideoEditorViewController new];
            ve.assets = arr;
            [weakSelf.navigationController pushViewController:ve animated:YES];
        });
    
       
    }];
    
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
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
//        if([[filename pathExtension] isEqualToString:extension]) {
            NSLog(@"delete %@",filename);
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:nil];
//        }
    }
    
}


@end
