//
//  MeasureViewController.m
//  PaintHelper
//
//  Created by 贾辰 on 2018/10/22.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "MeasureViewController.h"
#import <Photos/Photos.h>
// View
#import "MeasureViewPhotoCollectionView.h"
#import "MeasurePhotoViewController.h"
// Model
#import "ModelLoactor.h"

@interface MeasureViewController ()<MeasureViewPhotoListDelegate>
@property (strong, nonatomic) MeasureViewPhotoCollectionView *list;
@end

@implementation MeasureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    _list = [[MeasureViewPhotoCollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - [self getTabBarHeight])];
    _list.delegate = self;
    [self.view addSubview:_list];
}

- (CGFloat)getTabBarHeight {
    return self.tabBarController.tabBar.bounds.size.height;
}

- (void)viewWillAppear:(BOOL)animated {
    // 获得相机胶卷
//    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumScreenshots options:nil].lastObject;
//    PHAssetCollectionSubtypeSmartAlbumUserLibrary PHAssetCollectionSubtypeSmartAlbumScreenshots
    NSLog(@"相簿名:%@", cameraRoll.localizedTitle);
    
    [_list setAlbumData:cameraRoll];
    
    PHFetchResult *customUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    for (PHAssetCollection *collection in customUserCollections) {
        NSLog(@"相册名 :%@",collection.localizedTitle);
    }
}

#pragma mark - MeasureViewPhotoListDelegate
- (void)showMeasureViewWithImage:(UIImage *)image {
    MeasurePhotoViewController *photoVC = [[MeasurePhotoViewController alloc] initWithImage:image];
    [self presentViewController:photoVC animated:YES completion:nil];
}

@end
