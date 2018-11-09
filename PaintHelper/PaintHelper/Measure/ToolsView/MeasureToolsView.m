//
//  MeasureToolsVIew.m
//  PaintHelper
//
//  Created by 贾辰 on 2018/11/6.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "MeasureToolsView.h"
#import "ModelLoactor.h"

@interface MeasureToolsView()
@property (strong, nonatomic) UIView *viewToolsList;
@end

@implementation MeasureToolsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor colorWithRed:111.0/255.0 green:222.0/255.5 blue:22.0/255.5 alpha:0.2];
    
    UIButton *btnFullScreen = [[UIButton alloc] initWithFrame:self.bounds];
    [btnFullScreen addTarget:self action:@selector(onCloseAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnFullScreen];
    
    _viewToolsList = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/4, SCREEN_HEIGHT)];
    _viewToolsList.backgroundColor = [UIColor greenColor];
    [self addSubview:_viewToolsList];
        
}

- (void)setOffsetRate:(CGFloat)rate {

    CGRect frame = self.layer.frame;
    frame.origin.x = -SCREEN_WIDTH * (1-rate);
    self.layer.frame = frame;
//
//    CGRect viewToolsFrame = _viewToolsList.frame;
//    viewToolsFrame.origin.x = SCREEN_WIDTH/2 * rate;
//    _viewToolsList.frame = viewToolsFrame;
}

- (void)show {
    CGRect frame = self.frame;
    frame.origin.x = -SCREEN_WIDTH ;
    self.frame = frame;
    
    [self setHidden:NO];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.frame;
        frame.origin.x = 0 ;
        self.frame = frame;
    }];
}

- (void)onCloseAction {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.frame;
        frame.origin.x = -SCREEN_WIDTH ;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self setHidden:YES];
    }];
}
@end
