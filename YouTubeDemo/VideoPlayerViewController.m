//
//  VideoPlayerViewController.m
//  YouTubeDemo
//
//  Created by maruiduan on 14-7-16.
//  Copyright (c) 2014年 Ben. All rights reserved.
//

#import "VideoPlayerViewController.h"


#if TWEAKS_SWITCH

#import <FBTweak/FBTweak.h>
#import <FBTweak/FBTweakShakeWindow.h>
#import <FBTweak/FBTweakInline.h>
#import <FBTweak/FBTweakViewController.h>

#endif

@interface VideoPlayerViewController ()

@property (nonatomic, retain) UIButton *button;

@property (nonatomic, retain) UITextView *label;

@property (nonatomic, retain) UITextView *label1;


@end

@implementation VideoPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:@"我就是传说中的播放器" forState:UIControlStateNormal];
    [self.button setBackgroundImage:[UIImage imageNamed:@"1_1440x900.jpg"] forState:UIControlStateNormal];
    [self.button setBackgroundImage:[UIImage imageNamed:@"1_1440x900.jpg"] forState:UIControlStateHighlighted];

    self.button.frame = CGRectMake(0, 0, 800 , 400);
    [self.button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    self.label = [[UITextView alloc] initWithFrame:CGRectMake(0, 400, 800, 368)];
    self.label.backgroundColor = [UIColor greenColor];
    self.label.text = @"sadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjlkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;lkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;lkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;lkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;lkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;lkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;flkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkfsadfasdfasdfjaoksdjflkasdjfl;ajksdfl;akjsdfl;kajsdfl;kajsdfl;kjads;lkf";
    [self.view addSubview:self.label];
    
    
    self.label1 = [[UITextView alloc] initWithFrame:CGRectMake(800, 0, 1024-800, 768)];
    self.label1.backgroundColor = [UIColor blueColor];
    self.label1.text = self.label.text;
    [self.view addSubview:self.label1];

    // Do any additional setup after loading the view.
}

- (void)back{
    NSLog(@"我被爆了！！！！！");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scaleViewController:(CGFloat)scale
{
    [super scaleViewController:scale];
    
    self.button.frame = CGRectMake(0, 0, YKPlayer_MIN_WIDTH+(800-YKPlayer_MIN_WIDTH)*scale ,YKPlayer_MIN_HEIGHT + (400-YKPlayer_MIN_HEIGHT)*scale);
    self.label.frame = CGRectMake(0, YKPlayer_MIN_HEIGHT + (400-YKPlayer_MIN_HEIGHT)*scale, 800, 368);
    self.label.alpha = scale;
    
    self.label1.frame = CGRectMake(YKPlayer_MIN_WIDTH+(800-YKPlayer_MIN_WIDTH)*scale, 0, 1024-800, 768);
    self.label1.alpha = scale;
    
//    NSLog(@"%f",scale);
}
- (UIView *)playerView{
    return self.button;
}

@end
