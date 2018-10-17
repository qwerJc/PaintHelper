//
//  ViewController.m
//  PaintHelper
//
//  Created by 贾辰 on 18/8/9.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "ViewController.h"
#import "EditViewController.h"
@interface ViewController ()
@property (strong, nonatomic)EditViewController *editVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(onBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)onBtnAction {
    [self.navigationController pushViewController:_editVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
