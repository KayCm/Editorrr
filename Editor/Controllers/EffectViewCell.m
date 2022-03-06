//
//  EffectViewCell.m
//  Editor
//
//  Created by Kai on 2022/2/25.
//

#import "EffectViewCell.h"
#import "Masonry.h"

@implementation EffectViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIView *bg = [UIView new];
        bg.backgroundColor = [UIColor lightGrayColor];
        bg.layer.cornerRadius = 5;
        [self addSubview:bg];
        
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(5);
            make.right.equalTo(self.mas_right).with.offset(-5);
            make.top.equalTo(self.mas_top).with.offset(2.5);
            make.bottom.equalTo(self.mas_bottom).with.offset(-5);
        }];
        
        
        _lbl = [[UILabel alloc] init];
        _lbl.textAlignment = NSTextAlignmentCenter;
        _lbl.font = [UIFont systemFontOfSize:12];
        [bg addSubview:_lbl];
        
        [_lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bg.mas_centerX).with.offset(0);
            make.centerY.equalTo(bg.mas_centerY).with.offset(0);
            make.height.equalTo(@24);
            make.width.equalTo(bg.mas_width);
        }];
        
       
        
    }
    
    return self;
 
    
    
    return self;
}

@end
