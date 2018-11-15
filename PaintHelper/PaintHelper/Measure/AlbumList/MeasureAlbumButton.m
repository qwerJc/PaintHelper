//
//  MeasureAlbumButton.m
//  PaintHelper
//
//  Created by 贾辰 on 2018/11/12.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "MeasureAlbumButton.h"

@interface MeasureAlbumButton()
@property (strong, nonatomic) UIButton *btn;
@end
@implementation MeasureAlbumButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor grayColor];
    
    _btn = [[UIButton alloc] initWithFrame:self.bounds];
    [_btn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [self addSubview:_btn];
}

@end
