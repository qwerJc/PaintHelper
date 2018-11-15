//
//  PickColorView.m
//  PaintHelper
//
//  Created by 贾辰 on 2018/11/9.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "PickColorView.h"

@interface PickColorView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) UIImageView *imgvNearbyArea;
@property (strong, nonatomic) UILabel *lblColorInfo;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray<UIColor *> *arrColor;
@end
@implementation PickColorView

- (instancetype)initWithFrame:(CGRect)frame {
    frame.size.width = 180;
    frame.size.height = 110;
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        
        _arrColor = [NSMutableArray arrayWithCapacity:100];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor grayColor];
    
}

- (void)showWithPoint:(CGPoint)point image:(UIImage *)img locationPoint:(CGPoint)locatePoint{
    CGRect frame = self.frame;
    frame.origin.x = locatePoint.x;
    frame.origin.y = locatePoint.y;
    self.frame = frame;
    
    [self.lblColorInfo setHidden:NO];
    [self.lblColorInfo setText:[self getColorWithImg:img andPoint:point]];
    
    [self getArrColorWithImg:img andPoint:point];
    
//    [self.imgvNearbyArea setHidden:NO];
//    [self.imgvNearbyArea setImage:[self getPartOfImage:img andPoint:point]];
    
    [self.collectionView reloadData];
    
}

- (NSString *)getColorWithImg:(UIImage *)img andPoint:(CGPoint)point {
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = img.CGImage;
    NSUInteger width = img.size.width;
    NSUInteger height = img.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    CGFloat red   = (CGFloat)pixelData[0];
    CGFloat green = (CGFloat)pixelData[1];
    CGFloat blue  = (CGFloat)pixelData[2];
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0;
    //    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    NSString *string = [NSString stringWithFormat:@"红:%.1f, \n绿:%.1f, \n蓝:%.1f, \nAplha:%.1f ",red,green,blue,alpha];
    return string;
}

- (void)getArrColorWithImg:(UIImage *)img andPoint:(CGPoint)point1 {
    _arrColor = [NSMutableArray arrayWithCapacity:81];
    for (int i = 0; i < 81 ; i++) {
        CGPoint point = CGPointMake(point1.x - 4, point1.y - 4);
        point.x += i % 9;
        point.y += i / 9;
        NSLog(@"(%f,%f)",point.x, point.y);
        
        NSInteger pointX = trunc(point.x);
        NSInteger pointY = trunc(point.y);
        CGImageRef cgImage = img.CGImage;
        NSUInteger width = img.size.width;
        NSUInteger height = img.size.height;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        int bytesPerPixel = 4;
        int bytesPerRow = bytesPerPixel * 1;
        NSUInteger bitsPerComponent = 8;
        unsigned char pixelData[4] = { 0, 0, 0, 0 };
        CGContextRef context = CGBitmapContextCreate(pixelData,
                                                     1,
                                                     1,
                                                     bitsPerComponent,
                                                     bytesPerRow,
                                                     colorSpace,
                                                     kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
        CGColorSpaceRelease(colorSpace);
        CGContextSetBlendMode(context, kCGBlendModeCopy);
        
        // Draw the pixel we are interested in onto the bitmap context
        CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
        CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
        CGContextRelease(context);
        
        [_arrColor addObject:[UIColor colorWithRed:(CGFloat)pixelData[0]/255.0 green:(CGFloat)pixelData[1]/255.0 blue:(CGFloat)pixelData[2]/255.0 alpha:(CGFloat)pixelData[3]/255.0]];
    }
}

- (UIImage *)getPartOfImage:(UIImage *)img andPoint:(CGPoint)point{

    CGRect rect = CGRectMake(point.x - 2, point.y - 2, 4, 4);
    CGImageRef imageRef = img.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *retImg = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    return retImg;
}

#pragma mark - Collection Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 81;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = _arrColor[indexPath.row];
    if (indexPath.row == 40) {
        [cell.layer setBorderWidth:2.0];
        [cell.layer setBorderColor:[UIColor blackColor].CGColor];
    }else {
        [cell.layer setBorderWidth:0];
    }
//    [cell setBackgroundColor:_arrColor[indexPath.row]];
//    cell.backgroundColor = [UIColor colorWithRed:0.78902 green: 0.560784 blue:0.0580392 alpha:1];
//    cell.backgroundColor = [UIColor colorWithRed:111.0/255.0 green:222.0/255.5 blue:22.0/255.5 alpha:1];
    return cell;
}

#pragma mark - Lazy Load
- (UIImageView *)imgvNearbyArea {
    if (!_imgvNearbyArea) {
        _imgvNearbyArea = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 80, 80)];
        _imgvNearbyArea.backgroundColor = [UIColor whiteColor];
        [self addSubview:_imgvNearbyArea];
        
        [_imgvNearbyArea setHidden:YES];
    }
    return _imgvNearbyArea;
}

- (UILabel *)lblColorInfo {
    if (!_lblColorInfo) {
        _lblColorInfo = [[UILabel alloc] initWithFrame:CGRectMake(115, 0, 65, 90)];
        [_lblColorInfo setHidden:YES];
        [_lblColorInfo setFont:[UIFont systemFontOfSize:14.0]];
        _lblColorInfo .numberOfLines = 4;
        [self addSubview:_lblColorInfo];
    }
    return _lblColorInfo;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.itemSize = CGSizeMake(10.0, 10.0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 5, 100, 100) collectionViewLayout:flowLayout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

@end
