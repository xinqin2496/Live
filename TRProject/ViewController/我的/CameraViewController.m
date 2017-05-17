//
//  CameraViewController.m
//  高仿映客
//
//  Created by JIAAIR on 16/7/3.
//  Copyright © 2016年 JIAAIR. All rights reserved.
//

#import "CameraViewController.h"
#import "StartLiveView.h"
#import "GPUImageGaussianBlurFilter.h"

@interface CameraViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;


@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景图片高斯模糊
//    [self gaussianImage];
    
    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];

    StartLiveView *view = [[StartLiveView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
}


#pragma mark ---- <设置背景图片高斯模糊>
- (void)gaussianImage {
    
    GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    blurFilter.blurRadiusInPixels = 2.0;
    UIImage * image = [UIImage imageNamed:@"bg_zbfx"];
    UIImage *blurredImage = [blurFilter imageByFilteringImage:image];
    
    self.backgroundView.image = blurredImage;
}



@end
