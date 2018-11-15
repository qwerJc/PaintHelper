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
#import "MeasureAlbumListView.h"
#import "MeasureViewPhotoCollectionView.h"
#import "MeasurePhotoViewController.h"

// Model
#import "ModelLoactor.h"

@interface MeasureViewController ()<MeasureViewPhotoListDelegate, MeasureViewPhotoListDelegate>
@property (strong, nonatomic) UIButton *btnAlbum;
@property (strong, nonatomic) MeasureAlbumListView *albumListView;
@property (strong, nonatomic) MeasureViewPhotoCollectionView *list;

@end

@implementation MeasureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
    _btnAlbum = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 20, 200, 44)];
    _btnAlbum.backgroundColor = [UIColor redColor];
    [_btnAlbum setTitle:@"相机胶卷" forState:UIControlStateNormal];
    [_btnAlbum addTarget:self action:@selector(onShowAlbumAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnAlbum];
    
    _list = [[MeasureViewPhotoCollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - [self getTabBarHeight])];
    _list.delegate = self;
    [self.view addSubview:_list];
    
    _albumListView = [[MeasureAlbumListView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 80)];
    _albumListView.delegate = self;
    [self.view addSubview:_albumListView];
    
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    
    [_list setAlbumData:cameraRoll];
    
    // 输出所有相册
//    PHFetchResult *customUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
//    for (PHAssetCollection *collection in customUserCollections) {
//        NSLog(@"相册名 :%@",collection.localizedTitle);
//    }
}

- (CGFloat)getTabBarHeight {
    return self.tabBarController.tabBar.bounds.size.height;
}

- (void)viewWillAppear:(BOOL)animated {

}

#pragma mark - Btn Action
- (void)onShowAlbumAction {
    if (self.albumListView.isShow) {
        [self.albumListView hide];
    }else {
        [self.albumListView show];
    }
}

#pragma mark - MeasureAlbumListView Delegate
- (void)chooseAlbumType:(NSInteger)type {
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:type options:nil].lastObject;
    //    PHAssetCollectionSubtypeSmartAlbumUserLibrary PHAssetCollectionSubtypeSmartAlbumScreenshots
    [_btnAlbum setTitle:cameraRoll.localizedTitle forState:UIControlStateNormal];
    
    [_list setAlbumData:cameraRoll];
    
    [self.albumListView hide];
}

#pragma mark - MeasureViewPhotoListDelegate
- (void)showMeasureViewWithImage:(UIImage *)image {
    MeasurePhotoViewController *photoVC = [[MeasurePhotoViewController alloc] initWithImage:image];
    [self presentViewController:photoVC animated:YES completion:nil];
}

@end
