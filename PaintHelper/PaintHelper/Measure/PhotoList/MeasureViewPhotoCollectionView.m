//
//  MeasureViewPhotoCollectionView.m
//  PaintHelper
//
//  Created by 贾辰 on 2018/11/2.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "MeasureViewPhotoCollectionView.h"
#import "ModelLoactor.h"
#import <Photos/Photos.h>
#import "MeasureViewPhotoCollectionViewCell.h"

@interface MeasureViewPhotoCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) PHFetchResult *assetsFetchResults;
@end

@implementation MeasureViewPhotoCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 4.0;
    layout.minimumInteritemSpacing = 4.0;
    layout.itemSize = CGSizeMake((CGRectGetWidth(self.frame) - 4*5)/3 , 100);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(4.f, 4.f, self.bounds.size.width - 8.f, self.bounds.size.height - 8.f) collectionViewLayout:layout];
    [self.collectionView registerClass:[MeasureViewPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"VideoListCollectionViewCell"];
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor orangeColor];
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
}

- (void)setAlbumData:(PHAssetCollection *)album {
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    _assetsFetchResults = [PHAsset fetchAssetsInAssetCollection:album options:options];
    
}
#pragma mark - Collection Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_assetsFetchResults count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MeasureViewPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoListCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    [cell setupWithAsset:_assetsFetchResults[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    option.resizeMode = PHImageRequestOptionsResizeModeNone;
    
    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
    [imageManager requestImageForAsset:_assetsFetchResults[indexPath.row]
                            targetSize:CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))
                           contentMode:PHImageContentModeAspectFill
                               options:option
                         resultHandler:^(UIImage *result, NSDictionary *info) {
                             if ([self.delegate respondsToSelector:@selector(showMeasureViewWithImage:)]) {
                                 [self.delegate showMeasureViewWithImage:result];
                             }
                         }];
}

@end
