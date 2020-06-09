//
//  LYHUD.h
//  LYHUD
//
//  Created by 似水灵修 on 2020/6/5.
//  Toast弹框

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

/// 弹框样式
typedef NS_ENUM(NSUInteger, LYHUDStyle) {
    /// 纯文字
    LYHUDStyleNone,
    /// 成功
    LYHUDStyleSuccess,
    /// 失败
    LYHUDStyleFailure,
};

@interface LYHUD : NSObject

/// 展示HUD，手动关闭
/// @param msg msg
+ (void)showHUD:(NSString *)msg;

/// 关闭HUD
+ (void)hideHUD;

/// 弹框，自动消失
/// @param msg msg
/// @param style 样式
/// @param completion callback
+ (void)showMessage:(NSString *)msg
              style:(LYHUDStyle)style
         completion:(nullable void(^)(void))completion;

/// 弹框，自动消失
/// @param msg msg
/// @param style 样式
+ (void)showMessage:(NSString *)msg
              style:(LYHUDStyle)style;

/// 弹框，自动消失，默认：LYHUDStyleNone
/// @param msg msg
+ (void)showMessage:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
