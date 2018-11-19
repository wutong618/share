//
//  ViewController.m
//  shareDemo
//
//  Created by 吴桐 on 2018/11/12.
//  Copyright © 2018年 cowlevel. All rights reserved.
//

#import "ViewController.h"
#import "ZPMShareManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *originBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    originBtn.frame = CGRectMake(32, 32, [UIScreen mainScreen].bounds.size.width - 64, [UIScreen mainScreen].bounds.size.height/2 - 64);
    [originBtn setTitle:@"ShareSDK默认弹出框" forState:UIControlStateNormal];
    [originBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    originBtn.layer.masksToBounds = YES;
    originBtn.layer.cornerRadius = 10;
    originBtn.backgroundColor = [UIColor blackColor];
    [originBtn addTarget:self action:@selector(showOriginAlert) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newBtn.frame = CGRectMake(32,  [UIScreen mainScreen].bounds.size.height/2 , [UIScreen mainScreen].bounds.size.width - 64, [UIScreen mainScreen].bounds.size.height/2 - 64);
    [newBtn setTitle:@"自定义分享弹出框" forState:UIControlStateNormal];
    newBtn.layer.masksToBounds = YES;
    newBtn.layer.cornerRadius = 10;
    newBtn.backgroundColor = [UIColor blackColor];
    [newBtn addTarget:self action:@selector(showNewAlert) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:originBtn];
    [self.view addSubview:newBtn];
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)showNewAlert{
    ZPMShareManager *share = [[ZPMShareManager alloc]init];
    [share showShareConfirm];
}

- (void)showOriginAlert{
    ZPMShareManager *share = [[ZPMShareManager alloc]init];
    [share showOriginSDKConfirm];
}
@end
