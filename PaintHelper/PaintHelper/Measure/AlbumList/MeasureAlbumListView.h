//
//  MeasureAlbumPickerView.h
//  PaintHelper
//
//  Created by 贾辰 on 2018/11/12.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PHPhotoLibrary;

NS_ASSUME_NONNULL_BEGIN

@protocol MeasureViewPhotoListDelegate <NSObject>

- (void)chooseAlbumType:(NSInteger)type;

@end

@interface MeasureAlbumListView : UIView
@property (weak, nonatomic) id<MeasureViewPhotoListDelegate> delegate;
@property (assign, nonatomic, readonly) BOOL isShow;
- (void)show;
- (void)hide;
@end

NS_ASSUME_NONNULL_END
