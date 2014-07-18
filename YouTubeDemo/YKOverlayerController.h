//
//  YKOverlayerController.h
//  YouTubeDemo
//
//  Created by maruiduan on 14-7-16.
//  Copyright (c) 2014年 Ben. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    YKPanStateNone,
    YKPanStateBackFull,       //松开手指返回全屏
    YKPanStateBackSmall,     //松开手指返回小屏
    YKPanStateLeftDelete,     //松开手指左滑删除
    YKPanStateRightDelete     //松开手指右滑删除 暂时右滑不能删除，需要快速扫才能右滑删除
}YKPanState;

typedef enum {
    YKOverlayerStateNone, 
    YKOverlayerStateFull,
    YKOverlayerStateSmall
}YKOverlayerState;

#define TWEAKS_SWITCH 0                 //参数调试开关

#if TWEAKS_SWITCH
    #define YKPlayer_MIN_WIDTH FBTweakValue(@"播放器参数", @"尺寸", @"小屏宽", 300.f)
    #define YKPlayer_MIN_HEIGHT FBTweakValue(@"播放器参数", @"尺寸", @"小屏高", 180.f)
#else
    #define YKPlayer_MIN_WIDTH 300.f        //播放器缩小状态宽
    #define YKPlayer_MIN_HEIGHT 180.f        //播放器缩小状态高
#endif

@protocol YKOvelayerPlayerDelegate <NSObject>

- (void)overlayerDidOpenPlayer;

- (void)overlayerDidClosePlayer;

@end


@interface YKOverlayerController : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic, assign, readonly) CGFloat scalce;

@property (nonatomic, assign, readonly) YKPanState panState;

@property (nonatomic, assign, readonly) YKOverlayerState overlayerState;


/**
 * @brief 子类重载此方法接受scacle改变回调
 * @param scale 缩放程度 1代表全屏，0代表小屏。
*/
- (void)scaleViewController:(CGFloat)scale;

/**
 * @brief 子类重载此方法 传入播放器view
 */

- (UIView *)playerView;



//============================

/**
 @brief 播放器不在页面上，打开一个新的页面，有渐隐动画
 */
- (void)openPlayer;

/**
 @brief 放大到全屏，播放器已经存在
 */
- (void)scaleToFullScreen;

/**
 @brief 缩小到右下角
 */
- (void)scaleToCorner;

@end

