//
//  EffectViewCell.m
//  Editor
//
//  Created by Kai on 2022/2/25.
//

#import "EffectViewCell.h"

@implementation EffectViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    lbl.text = @"aabbcc123";
    [self addSubview:lbl];
    
    
    return self;
}

@end
