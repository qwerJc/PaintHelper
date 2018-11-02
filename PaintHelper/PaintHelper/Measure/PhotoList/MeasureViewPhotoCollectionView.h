//
//  MeasureViewPhotoCollectionView.h
//  PaintHelper
//
//  Created by 贾辰 on 2018/11/2.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PHAssetCollection;

NS_ASSUME_NONNULL_BEGIN

@protocol MeasureViewPhotoListDelegate <NSObject>

- (void)showMeasureViewWithImage:(UIImage *)image;

@end

@interface MeasureViewPhotoCollectionView : UIView
@property (weak, nonatomic) id<MeasureViewPhotoListDelegate> delegate;
- (void)setAlbumData:(PHAssetCollection *)album;
@end

NS_ASSUME_NONNULL_END
