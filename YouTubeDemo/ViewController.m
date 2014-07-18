//
//  ViewController.m
//  YouTubeDemo
//
//  Created by maruiduan on 14-7-16.
//  Copyright (c) 2014年 Ben. All rights reserved.
//

#import "ViewController.h"
#import "VideoPlayerViewController.h"

#import <FBTweak/FBTweak.h>
#import <FBTweak/FBTweakShakeWindow.h>
#import <FBTweak/FBTweakInline.h>
#import <FBTweak/FBTweakViewController.h>

@interface ViewController ()<FBTweakViewControllerDelegate>

@property(nonatomic, strong) VideoPlayerViewController *overlayerVC;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"打开播放器" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 200 , 100);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
#if TWEAKS_SWITCH
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"参数设置" forState:UIControlStateNormal];
    button1.frame = CGRectMake(100, 300, 200 , 100);
    button1.backgroundColor = [UIColor redColor];
    [button1 addTarget:self action:@selector(buttonTapped1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
#endif
    
    
    self.overlayerVC = [[VideoPlayerViewController alloc] init];
    
    [self addChildViewController:self.overlayerVC];
    
    [self.view addSubview:self.overlayerVC.view];
    
    [self.overlayerVC didMoveToParentViewController:self];

    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)buttonTapped{
    if (self.overlayerVC.overlayerState == YKOverlayerStateNone) {
        [self.overlayerVC openPlayer];
    }else if(self.overlayerVC.overlayerState == YKOverlayerStateSmall){
        [self.overlayerVC scaleToFullScreen];
    }
}

- (void)buttonTapped1{
    FBTweakViewController *viewController = [[FBTweakViewController alloc] initWithStore:[FBTweakStore sharedInstance]];
    viewController.tweaksDelegate = self;
    [self presentViewController:viewController animated:YES completion:NULL];
}

- (void)tweakViewControllerPressedDone:(FBTweakViewController *)tweakViewController
{
    [tweakViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
