//
//  PlayerViewController.m
//  Editor
//
//  Created by Kai on 2022/2/25.
//

#import "PlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Masonry.h"


@interface PlayerViewController ()

@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)UIButton *playBtn;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self viewSetup];
}


-(void)viewSetup{
    
    
    UIView *_videoBg = [UIView new];
    _videoBg.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_videoBg];
    [_videoBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.centerY.equalTo(self.view.mas_centerY).with.offset(5);
        make.height.equalTo(@(SCREEN_WIDTH*0.5625));
    }];
    
    
    self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:DocumentPath(_fileName)]];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.backgroundColor = [UIColor whiteColor].CGColor;
    playerLayer.bounds = CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_WIDTH*0.5625);
    playerLayer.position = CGPointMake(SCREEN_WIDTH/2, SCREEN_WIDTH*0.5625/2);
    [_videoBg.layer addSublayer:playerLayer];
    
    UIView *playToolsView = [UIView new];
    playToolsView.backgroundColor = [UIColor blackColor];
    playToolsView.alpha = 0.3;
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
    
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(playToolsView.mas_centerY);
        make.left.equalTo(playToolsView.mas_left).with.offset(10);
        make.height.width.equalTo(@24);
        
    }];
    
    [self playset];
    
}


-(void)playset{
    
    [self.player play];
    
    [self.playBtn setSelected:YES];
    
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
