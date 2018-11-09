//
//  PickColorView.m
//  PaintHelper
//
//  Created by 贾辰 on 2018/11/9.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "PickColorView.h"

@interface PickColorView()
@property (strong, nonatomic) UILabel *lblColorInfo;
@end
@implementation PickColorView

- (instancetype)initWithFrame:(CGRect)frame {
    frame.size.width = 120;
    frame.size.height = 70;
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
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
//    [self.lblColorInfo sizeToFit];
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
    NSString *string = [NSString stringWithFormat:@"Red:%.1f, \nGreen:%.1f, \nBlue:%.1f, \nAplha:%.1f ",red,green,blue,alpha];
    return string;
}
#pragma mark - Lazy Load
- (UILabel *)lblColorInfo {
    if (!_lblColorInfo) {
        _lblColorInfo = [[UILabel alloc] initWithFrame:self.bounds];
        [_lblColorInfo setHidden:YES];
        [_lblColorInfo setFont:[UIFont systemFontOfSize:14.0]];
        _lblColorInfo .numberOfLines = 4;
        [self addSubview:_lblColorInfo];
    }
    return _lblColorInfo;
}
@end
