//
//  PickColorView.h
//  PaintHelper
//
//  Created by 贾辰 on 2018/11/9.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PickColorView : UIView
- (void)showWithPoint:(CGPoint)point
                image:(UIImage *)img
        locationPoint:(CGPoint)locatePoint;
@end

NS_ASSUME_NONNULL_END
