//
//  MeasurePhotoViewController.m
//  PaintHelper
//
//  Created by 贾辰 on 2018/11/2.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "MeasurePhotoViewController.h"

#define ScreenScare [UIScreen mainScreen].scale

@interface MeasurePhotoViewController ()
@property (strong, nonatomic) UIImageView *imgvPhoto;
@property (strong, nonatomic) UIButton *btnBack;
@end

@implementation MeasurePhotoViewController

- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _imgvPhoto = [[UIImageView alloc] initWithImage:image];
        _imgvPhoto.userInteractionEnabled = YES;
        [self.view addSubview:self.imgvPhoto];
        
        [self.view addSubview:self.btnBack];
        
        [self addGestureRecognizer];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addGestureRecognizer {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    
    pan.minimumNumberOfTouches = 2;
    
    [self.imgvPhoto addGestureRecognizer:pan];
}

#pragma mark - Gesture Action

// 两指拖拽
- (void)panAction:(UIPanGestureRecognizer *)pan{
    
    CGPoint point = [pan translationInView:pan.view];
    
    NSLog(@"Point:(%f,%f)",point.x,point.y);
  
//
//        pan.view.transform =CGAffineTransformTranslate(pan.view.transform, point.x, point.y);
//
//        [pan setTranslation:CGPointZeroinView:pan.view];
    
    CGRect frame = self.imgvPhoto.frame;
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    self.imgvPhoto.frame = frame;
    
}

#pragma mark - Btn Action
- (void)onBackAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Lazy Load
- (UIButton *)btnBack {
    if (!_btnBack) {
        _btnBack = [[UIButton alloc] initWithFrame:CGRectMake(40, 40, 44, 44)];
        [_btnBack setBackgroundColor:[UIColor grayColor]];
        [_btnBack addTarget:self action:@selector(onBackAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBack;
}
@end
