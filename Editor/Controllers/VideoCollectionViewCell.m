//
//  VideoCollectionViewCell.m
//  Editor
//
//  Created by Kai on 2022/5/5.
//

#import "VideoCollectionViewCell.h"

@implementation VideoCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
     self.contentView.backgroundColor = [UIColor clearColor];
     [self initView];
    }
    return self;
}

-(void)initView{
    _img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];;
    
    _img.backgroundColor = [UIColor blackColor];
    
//    _img.layer.borderColor = [UIColor whiteColor].CGColor;
//    
//    _img.layer.borderWidth = 2;
    
    [self addSubview:_img];
    
}

@end
