//
//  YKOverlayerController.m
//  YouTubeDemo
//
//  Created by maruiduan on 14-7-16.
//  Copyright (c) 2014年 Ben. All rights reserved.
//

#import "YKOverlayerController.h"


#if TWEAKS_SWITCH
    #import <FBTweak/FBTweak.h>
    #import <FBTweak/FBTweakShakeWindow.h>
    #import <FBTweak/FBTweakInline.h>
    #import <FBTweak/FBTweakViewController.h>

    #define SCALE_ANIMATION_DURATION FBTweakValue(@"播放器参数", @"动画", @"动画时间(单位是秒)", 0.5)

    #define PAN_BACK_THRESHOLD FBTweakValue(@"播放器参数", @"swipe", @"bound(拖动回弹阈值)(垂直方向y偏移比例，全屏为1，小屏为0，0~1)", 0.35)

    #define PAN_TO_FULL_OFFSET FBTweakValue(@"播放器参数", @"swipe", @"lock_to_full(小屏后左右滑动阈值 超过后不能上下滑动)(单位是像素)", 10)

    #define PAN_AS_SWIPE_SPEED FBTweakValue(@"播放器参数", @"swipe", @"speed(数值越大，滑动手势越难触发)", 1800)

    #define PLAYER_OPEN_ALPHA FBTweakValue(@"播放器参数", @"动画", @"alpha（弹出播放器默认透明度）(0~1)", 0.25)
#else
    #define SCALE_ANIMATION_DURATION 0.5    //播放器缩放动画时间

    #define PAN_BACK_THRESHOLD 0.35         //拖动回弹阈值

    #define PAN_TO_FULL_OFFSET 10           //小屏后左右滑动阈值 超过后不能上下滑动

    #define PAN_AS_SWIPE_SPEED 1800         //拖动转换swipe速度阈值

    #define PLAYER_OPEN_ALPHA 0.25          //弹出播放器默认透明度
#endif

@interface YKOverlayerController ()

@property (nonatomic, retain) UITapGestureRecognizer *tapGesture;

@end

@implementation YKOverlayerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _panState = YKPanStateNone;
        _overlayerState = YKOverlayerStateNone;
    }
    return self;
}

- (void)dealloc{
    [_tapGesture release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIPanGestureRecognizer *panrecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handlePanEvent:)];
    panrecognizer.delegate = self;
    [self.view addGestureRecognizer:panrecognizer];
    [panrecognizer release];
    
    self.tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapEvent:)] autorelease];
    self.tapGesture.delegate = self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // do something before rotation
    [self orientationLayout];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self orientationLayout];
}

#pragma mark - UIGestureRecognizerDelegate

- (void)handlePanEvent:(UIPanGestureRecognizer *)recognizer{
    [self.view removeGestureRecognizer:self.tapGesture];
    
    CGPoint translation = [recognizer translationInView:self.view.superview];
    //    NSLog(@"+++++++%@",NSStringFromCGPoint(translation));
    
    CGSize screen = [UIScreen mainScreen].bounds.size;
    
    BOOL isPortrait = UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation);
    
    CGFloat height = isPortrait ? screen.height : screen.width;
    CGFloat width =  isPortrait ? screen.width : screen.height;
    
    CGRect oldFrame = recognizer.view.frame;
    
    if (self.view.frame.origin.y >= (height - YKPlayer_MIN_HEIGHT)) {//滑动到小屏
        oldFrame.origin.x = oldFrame.origin.x + translation.x;
        
        CGFloat offsetX = oldFrame.origin.x - (width - YKPlayer_MIN_WIDTH);
        
        if(translation.y<0 && fabsf(offsetX)<PAN_TO_FULL_OFFSET){
            oldFrame.origin.y = oldFrame.origin.y + translation.y;
        }
        
        if (offsetX > 0) {//小屏右滑
            self.view.alpha = 1.0f-fabsf(offsetX/YKPlayer_MIN_WIDTH);
            _panState = YKPanStateBackSmall;
        }else{
            CGFloat offset_per = fabsf(offsetX/width);
            self.view.alpha = 1-offset_per;
            if (offset_per < PAN_BACK_THRESHOLD) {
                _panState = YKPanStateBackSmall;
            }else{
                _panState = YKPanStateLeftDelete;
            }
        }
    }else{
        CGFloat new_tran_x = translation.y * (width - YKPlayer_MIN_WIDTH)/(height - YKPlayer_MIN_HEIGHT);
        CGFloat new_tran_y = translation.y;
        
        CGFloat new_x = oldFrame.origin.x + new_tran_x;
        CGFloat new_y = oldFrame.origin.y + new_tran_y;
        
        //如果超出屏幕 设置到全屏。
        if (new_x < 0) {
            new_x = 0;
        }
        if (new_y < 0) {
            new_y = 0;
        }
        
        oldFrame.origin.x = new_x;
        oldFrame.origin.y = new_y;
        
        _scalce = (height - YKPlayer_MIN_HEIGHT - oldFrame.origin.y)/(height - YKPlayer_MIN_HEIGHT);
        
        _scalce = _scalce<0 ? 0 : _scalce;
        
        NSAssert(_scalce<=1 && _scalce>=0, @"scale值异常！！！！！！");
        
        [self scaleViewController:_scalce];
        
        if (_scalce <= PAN_BACK_THRESHOLD) {
            _panState = YKPanStateBackSmall;
        }else{
            _panState = YKPanStateBackFull;
        }
        
        self.view.alpha = 1;
    }
    
    recognizer.view.frame = oldFrame;
    
    [recognizer setTranslation:CGPointZero inView:self.view.superview];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view.superview];
        BOOL isSmall = self.view.frame.origin.y >= (height - YKPlayer_MIN_HEIGHT);
        
        //根据滑动速度转换成扫动手势
        if (fabsf(velocity.x)>PAN_AS_SWIPE_SPEED && isSmall) {
            if(velocity.x>0){//左滑
                [self translateToRight];
                
            }else{
                [self translateToLeft];
            }
        }else if(fabsf(velocity.y)>PAN_AS_SWIPE_SPEED && !isSmall){
            if(velocity.y>0){//下滑
                [self translateToSmall];
            }else{
                [self translateToFull];
            }
        }else{
            //松手后动画
            if(isSmall){//左右滑动
                if (_panState == YKPanStateLeftDelete) {
                    [self translateToLeft];
                }else{
                    [self translateToSmall];
                }
            }else{
                if (_panState == YKPanStateBackSmall) {
                    [self translateToSmall];
                }else{
                    [self translateToFull];
                }
            }
        }
    }
}

- (void)handleTapEvent:(UITapGestureRecognizer *)recognizer{
    [self translateToFull];
    [self.view removeGestureRecognizer:recognizer];
}

#pragma mark - UIGestureRecognizerDelegate
//同时共存两个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:
(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ((touch.view == [self playerView]) || (self.view == touch.view) || [[self playerView].subviews containsObject:touch.view]) {
        return YES;
    }
    return NO;
}

#pragma mark - Scale && animation
- (void)fullLayout{
    CGSize screen = [UIScreen mainScreen].bounds.size;
    BOOL isPortrait = UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation);
    CGFloat height = isPortrait ? screen.height : screen.width;
    CGFloat width =  isPortrait ? screen.width : screen.height;
    self.view.frame = CGRectMake(0, 0, width, height);
    self.view.alpha = 1;
    [self scaleViewController:1.0f];
}

- (void)smallLayout{
    CGSize screen = [UIScreen mainScreen].bounds.size;
    BOOL isPortrait = UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation);
    CGFloat height = isPortrait ? screen.height : screen.width;
    CGFloat width =  isPortrait ? screen.width : screen.height;
    
    CGRect oldFrame = self.view.frame;
    oldFrame.origin.x = width - YKPlayer_MIN_WIDTH;
    oldFrame.origin.y = height - YKPlayer_MIN_HEIGHT;
    oldFrame.size.width = width;
    oldFrame.size.height = height;
    self.view.frame = oldFrame;
    self.view.alpha = 1;
    [self scaleViewController:0];
}

- (void)translateToFull{
    __block typeof(self) weakSelf = self;
    [UIView animateWithDuration:SCALE_ANIMATION_DURATION animations:^{
        [weakSelf fullLayout];
    } completion:^(BOOL finished) {
        weakSelf->_panState = YKPanStateNone;
        weakSelf->_overlayerState = YKOverlayerStateFull;
        if ([weakSelf playerView]) {
            [weakSelf playerView].userInteractionEnabled = YES;
        }
    }];
}

- (void)translateToSmall{
    __block typeof(self) weakSelf = self;
    [UIView animateWithDuration:SCALE_ANIMATION_DURATION animations:^{
        [weakSelf smallLayout];
    } completion:^(BOOL finished) {
        weakSelf->_panState = YKPanStateNone;
        weakSelf->_overlayerState = YKOverlayerStateSmall;
        [weakSelf.view addGestureRecognizer:weakSelf.tapGesture];
        if ([weakSelf playerView]) {
            [weakSelf playerView].userInteractionEnabled = NO;
        }
    }];
}

- (void)translateToRight{
    __block typeof(self) weakSelf = self;
    [UIView animateWithDuration:SCALE_ANIMATION_DURATION animations:^{
        CGSize screen = [UIScreen mainScreen].bounds.size;
        BOOL isPortrait = UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation);
        CGFloat height = isPortrait ? screen.height : screen.width;
        CGFloat width =  isPortrait ? screen.width : screen.height;
        
        weakSelf.view.frame = CGRectMake(width + YKPlayer_MIN_WIDTH,
                                         height - YKPlayer_MIN_HEIGHT,
                                         YKPlayer_MIN_WIDTH,
                                         YKPlayer_MIN_HEIGHT);
        weakSelf.view.alpha = 0;
    } completion:^(BOOL finished) {
        weakSelf->_panState = YKPanStateNone;
        weakSelf->_overlayerState = YKOverlayerStateNone;
        [weakSelf callClosePlayer];
    }];
}

- (void)translateToLeft{
    __block typeof(self) weakSelf = self;
    [UIView animateWithDuration:SCALE_ANIMATION_DURATION animations:^{
        CGSize screen = [UIScreen mainScreen].bounds.size;
        BOOL isPortrait = UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation);
        CGFloat height = isPortrait ? screen.height : screen.width;
        
        weakSelf.view.frame = CGRectMake(-YKPlayer_MIN_WIDTH,
                                         height - YKPlayer_MIN_HEIGHT,
                                         YKPlayer_MIN_WIDTH,
                                         YKPlayer_MIN_HEIGHT);
        weakSelf.view.alpha = 0;
    } completion:^(BOOL finished) {
        weakSelf->_panState = YKPanStateNone;
        weakSelf->_overlayerState = YKOverlayerStateNone;
        [weakSelf callClosePlayer];
    }];
}

#pragma mark - overrided methond
- (void)scaleViewController:(CGFloat)scale{
    
}

- (UIView *)playerView{
    return nil;
}


#pragma mark - public method
- (void)scaleToCorner{
    [self translateToSmall];
}

- (void)scaleToFullScreen{
    [self translateToFull];
}

- (void)openPlayer{
    [self callOpenPlayer];
    
    __block typeof(self) weakSelf = self;
    CGSize screen = [UIScreen mainScreen].bounds.size;
    BOOL isPortrait = UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation);
    CGFloat height = isPortrait ? screen.height : screen.width;
    CGFloat width =  isPortrait ? screen.width : screen.height;
    self.view.frame = CGRectMake(width-YKPlayer_MIN_WIDTH, height-YKPlayer_MIN_HEIGHT, width, height);
    self.view.alpha = PLAYER_OPEN_ALPHA;
    [self scaleViewController:1.0f];
    
    [UIView animateWithDuration:SCALE_ANIMATION_DURATION animations:^{
        [weakSelf fullLayout];
    } completion:^(BOOL finished) {
        weakSelf->_panState = YKPanStateNone;
        weakSelf->_overlayerState = YKOverlayerStateFull;
        if ([weakSelf playerView]) {
            [weakSelf playerView].userInteractionEnabled = YES;
        }
    }];
}

#pragma mark - private method
- (void)callOpenPlayer{
    if ([self conformsToProtocol:@protocol(YKOvelayerPlayerDelegate)]) {
        [self performSelector:@selector(overlayerDidOpenPlayer)];
    }
}

- (void)callClosePlayer{
    if ([self conformsToProtocol:@protocol(YKOvelayerPlayerDelegate)]) {
        [self performSelector:@selector(overlayerDidClosePlayer)];
    }
}

/**
 * @brief 转屏重新布局
 */
- (void)orientationLayout{
    if (_overlayerState == YKOverlayerStateFull) {
        [self fullLayout];
    }else if(self.overlayerState == YKOverlayerStateSmall){
        [self smallLayout];
    }
}

@end
