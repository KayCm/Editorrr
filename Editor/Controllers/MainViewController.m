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

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self viewSetup];
}

#pragma mark - 界面设定
- (void)viewSetup{
    
    UIView *videoBg = [UIView new];
    videoBg.backgroundColor = [UIColor redColor];
    [self.view addSubview:videoBg];
    [videoBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.height.equalTo(@(SCREEN_WIDTH*0.5625));
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置item的行间距和列间距
    layout.minimumInteritemSpacing = 15;
    layout.minimumLineSpacing = 15;
    // 设置item的大小
    CGFloat itemW = (SCREEN_WIDTH - 60) /4 ;
    layout.itemSize = CGSizeMake(itemW, itemW);
    // 设置每个分区的 上左下右 的内边距
    layout.sectionInset = UIEdgeInsetsMake(5, 10 ,5, 10);
    // 设置滚动条方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *effectListView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    effectListView.showsVerticalScrollIndicator = NO;
    effectListView.scrollEnabled = YES;
    effectListView.pagingEnabled = YES;
    //注册cell
    [effectListView registerClass:[EffectViewCell class] forCellWithReuseIdentifier:@"EffectViewCell"];
    effectListView.delegate = self;
    effectListView.dataSource = self;
    effectListView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:effectListView];
    [effectListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(videoBg.mas_bottom).with.offset(20);
        make.height.equalTo(@(itemW*2+30));
    }];
    
    
    UIButton *btn = [UIButton new];
    btn.backgroundColor = [UIColor cyanColor];
    [btn setTitle:@"Gooooo" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(effectListView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    [btn addTarget:self action:@selector(command) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)command{
    
    FFMpegCommand *ff = [FFMpegCommand new];
    
    [ff ffmpeg_command];
    
    
}

#pragma mark - data
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100
    ;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //创建item 从缓存池中拿 Item
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EffectViewCell" forIndexPath:indexPath];
    if(!cell){
        cell = [[EffectViewCell alloc] init];
    }
    CGFloat red = arc4random()%256/255.0;
    CGFloat green = arc4random()%256/255.0;
    CGFloat blue = arc4random()%256/255.0;
    cell.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];

    return cell;
    
}

@end
