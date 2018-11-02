//
//  MeasureViewPhotoCollectionViewCell.m
//  PaintHelper
//
//  Created by 贾辰 on 2018/11/2.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "MeasureViewPhotoCollectionViewCell.h"
#import <Photos/Photos.h>

@interface MeasureViewPhotoCollectionViewCell()
@property (strong, nonatomic) UIImageView *imgvPhoto;
@end

@implementation MeasureViewPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _imgvPhoto = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_imgvPhoto];
}

- (void)setupWithAsset:(PHAsset *)asset {
    PHImageRequestOptions *option=[[PHImageRequestOptions alloc] init];
    option.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
    [imageManager requestImageForAsset:asset
                            targetSize:CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))
                           contentMode:PHImageContentModeAspectFill
                               options:option
                         resultHandler:^(UIImage *result, NSDictionary *info) {
                             [self.imgvPhoto setImage:result];
                         }];
}

@end
