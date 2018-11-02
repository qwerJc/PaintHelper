//
//  MeasureViewPhotoCollectionViewCell.h
//  PaintHelper
//
//  Created by 贾辰 on 2018/11/2.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PHAsset;

NS_ASSUME_NONNULL_BEGIN

@interface MeasureViewPhotoCollectionViewCell : UICollectionViewCell
- (void)setupWithAsset:(PHAsset *)asset;
@end

NS_ASSUME_NONNULL_END
