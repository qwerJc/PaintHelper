//
//  ModelLoactor.h
//  同步
//
//  Created by 贾辰 on 2018/9/6.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].nativeBounds.size.width / [UIScreen mainScreen].nativeScale)
#define SCREEN_HEIGHT ([UIScreen mainScreen].nativeBounds.size.height / [UIScreen mainScreen].nativeScale)

static NSInteger const kMiddleButtonWidth = 60;
static NSInteger const kMiddleButtonHeight = 30;

static NSInteger const kSamallButtonWidth = 60;
static NSInteger const kSamallButtonHeight = 30;

@interface ModelLoactor : NSObject

@end
