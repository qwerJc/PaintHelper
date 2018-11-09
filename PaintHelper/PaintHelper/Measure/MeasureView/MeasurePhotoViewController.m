//
//  MeasurePhotoViewController.m
//  PaintHelper
//
//  Created by 贾辰 on 2018/11/2.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "MeasurePhotoViewController.h"
#import "ModelLoactor.h"
#import "MeasureToolsView.h"
#import "PickColorView.h"

#define ScreenScare [UIScreen mainScreen].scale

@interface MeasurePhotoViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imgvPhoto;
@property (strong, nonatomic) UIButton *btnBack;

@property (strong, nonatomic) MeasureToolsView *viewTools;
@property (strong, nonatomic) PickColorView *viewPickColor;
@property (strong, nonatomic) UIView *viewMeasure;
@end

@implementation MeasurePhotoViewController

- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _imgvPhoto = [[UIImageView alloc] initWithImage:image];
        _imgvPhoto.userInteractionEnabled = YES;
//        [self.view addSubview:self.imgvPhoto];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentSize = image.size;
        _scrollView.delegate = self;
        [_scrollView setMinimumZoomScale:1/[UIScreen mainScreen].scale];
        [_scrollView setMaximumZoomScale:10];
        [_scrollView setZoomScale:1/[UIScreen mainScreen].scale animated:YES];
        _scrollView.panGestureRecognizer.minimumNumberOfTouches = 2;
        [self.view addSubview:_scrollView];
        [_scrollView addSubview:_imgvPhoto];
        
        [self.view addSubview:self.btnBack];
        
        [self addGestureRecognizer];
        
        _viewTools = [[MeasureToolsView alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.view addSubview:_viewTools];
        
        _viewMeasure = [[UIView alloc] initWithFrame:self.view.bounds];
        _viewMeasure.userInteractionEnabled = NO;
        [self.view addSubview:_viewMeasure];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 99, 200, 1)];
        [lbl setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:lbl];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imgvPhoto;
}


// called before the scroll view begins zooming its content缩放开始的时候调用
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2) {
    NSLog(@"%s",__func__);
}

// scale between minimum and maximum. called after any 'bounce' animations缩放完毕的时候调用。
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    //把当前的缩放比例设进ZoomScale，以便下次缩放时实在现有的比例的基础上
    NSLog(@"scale is %f",scale);
    [_scrollView setZoomScale:scale animated:NO];
}

// 缩放时调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // 可以实时监测缩放比例
    NSLog(@"......scale is %f",scrollView.zoomScale);
    
}

- (void)addGestureRecognizer {
//    // 拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    pan.minimumNumberOfTouches = 1;
    [_scrollView addGestureRecognizer:pan];
//
//    // 缩放手势
//    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
//    [self.imgvPhoto addGestureRecognizer:pinchGestureRecognizer];
    
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
//    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//    [_scrollView addGestureRecognizer:swipeRight];
    
    UIScreenEdgePanGestureRecognizer *edgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgeSwipeAction:)];
    edgeGesture.edges = UIRectEdgeLeft;
    [_scrollView addGestureRecognizer:edgeGesture];
    
//    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPressAction:)];
//    longTap.minimumPressDuration = 0.1;
//    [_scrollView addGestureRecognizer:longTap];

}

#pragma mark - Gesture Action

- (void)edgeSwipeAction:(UIScreenEdgePanGestureRecognizer *)recognizer {
    
    CGPoint point = [recognizer translationInView:recognizer.view];
    CGFloat rate = point.x * 0.5 / SCREEN_WIDTH;
    if (rate > 1) {
        rate = 1;
    }
    NSLog(@"触发 边缘滑动 : %f",point.x);
    [self.viewTools show];
}

- (void)onLongPressAction:(UILongPressGestureRecognizer *)recognizer {
    UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
    CGPoint loactionPoint = [recognizer locationInView:_viewMeasure];
//    CGPoint loactionPoint = [self.view convertPoint:temPoint toView:window];
//
    CGPoint colorPoint = [recognizer locationInView:_imgvPhoto];
    
    NSLog(@"colorPoint :(%f,%f)",colorPoint.x,colorPoint.y);
    NSLog(@"loactionPoint :(%f,%f)",loactionPoint.x,loactionPoint.y);
//    NSLog(@"%@",);
    
//    [self.viewPickColor showWithPoint:point ColorValue:[self getColorWithImg:self.imgvPhoto.image andPoint:point]];
    [self.viewPickColor showWithPoint:colorPoint image:self.imgvPhoto.image locationPoint:loactionPoint];
}

- (void)panAction:(UIPanGestureRecognizer *)recognizer {
    CGPoint loactionPoint = [recognizer locationInView:_viewMeasure];
    CGPoint colorPoint = [recognizer locationInView:_imgvPhoto];
    
    NSLog(@"colorPoint :(%f,%f)",colorPoint.x,colorPoint.y);
    NSLog(@"loactionPoint :(%f,%f)",loactionPoint.x,loactionPoint.y);
    
    [self.viewPickColor showWithPoint:colorPoint image:self.imgvPhoto.image locationPoint:loactionPoint];
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

- (PickColorView *)viewPickColor {
    if (!_viewPickColor) {
        _viewPickColor = [[PickColorView alloc] init];
        [self.view addSubview:_viewPickColor];
    }
    return _viewPickColor;
}
@end
