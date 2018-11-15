
//
//  MeasureAlbumPickerView.m
//  PaintHelper
//
//  Created by 贾辰 on 2018/11/12.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "MeasureAlbumListView.h"
#import <Photos/Photos.h>

@interface MeasureAlbumListView()

@property (strong, nonatomic) NSArray *arrAlbum;
@end

@implementation MeasureAlbumListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor grayColor];
    
    UIButton *btnCameraRoll = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2)];
    [btnCameraRoll setTitle:@"相机胶卷" forState:UIControlStateNormal];
    btnCameraRoll.tag = 0;
    [btnCameraRoll addTarget:self action:@selector(onChooseAlbumType:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnCameraRoll];
    
    UIButton *btnScreenshot = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2)];
    [btnScreenshot setTitle:@"屏幕快照" forState:UIControlStateNormal];
    btnScreenshot.tag = 1;
    [btnScreenshot addTarget:self action:@selector(onChooseAlbumType:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnScreenshot];
    
    [self setHidden:YES];
}

- (void)show {
    [self setHidden:NO];
    
    _isShow = YES;
}

- (void)hide {
    [self setHidden:YES];
    
    _isShow = NO;
}

- (void)onChooseAlbumType:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(chooseAlbumType:)]) {
        if (btn.tag == 0) {
            [self.delegate chooseAlbumType:PHAssetCollectionSubtypeSmartAlbumUserLibrary];
        }else if (btn.tag == 1){
            [self.delegate chooseAlbumType:PHAssetCollectionSubtypeSmartAlbumScreenshots];
        }
    }
}

@end
