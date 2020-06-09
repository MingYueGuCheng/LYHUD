//
//  LYHUD.m
//  LYHUD
//
//  Created by 似水灵修 on 2020/6/5.
//

#import "LYHUD.h"
@import MBProgressHUD;

@implementation LYHUD

static MBProgressHUD *hud_t = nil;
+ (void)showHUD:(NSString *)msg {
    [self hideHUD];
    UIView *view = [self frontWindow];
    if (!view) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.contentColor = UIColor.whiteColor;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [self colorWithHex:0x4C4C4c alpha:1.0];
    hud.square = msg.length <= 4;
    hud.label.text = msg;
    hud.label.numberOfLines = 0;
    hud_t = hud;
}

+ (void)hideHUD {
    [hud_t hideAnimated:YES];
    hud_t = nil;
}

+ (void)showMessage:(NSString *)msg style:(LYHUDStyle)style completion:(nullable void(^)(void))completion {
    UIView *view = [self frontWindow];
    if (!view) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (style == LYHUDStyleNone) {
        hud.mode = MBProgressHUDModeText;
        hud.contentColor = UIColor.whiteColor;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [self colorWithHex:0x4C4C4c alpha:1.0];
        hud.label.text = msg;
        hud.label.numberOfLines = 0;
//        hud.offset = CGPointMake(0, MBProgressMaxOffset);
    } else {
        hud.mode = MBProgressHUDModeCustomView;
        hud.contentColor = UIColor.whiteColor;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [self colorWithHex:0x4C4C4c alpha:1.0];
        NSString *imageNamed = nil;
        if (style == LYHUDStyleSuccess) {
            imageNamed = @"hud_success";
        } else {
            imageNamed = @"hud_failure";
        }
        UIImage *image = [[UIImage imageNamed:imageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        hud.customView = [[UIImageView alloc] initWithImage:image];
        hud.square = msg.length <= 4;
        hud.label.text = msg;
        hud.label.numberOfLines = 0;
    }
    hud.completionBlock = ^{
        if (completion) {
            completion();
        }
    };
    [hud hideAnimated:YES afterDelay:[self displayDurationForString:msg]];
}

+ (void)showMessage:(NSString *)msg style:(LYHUDStyle)style {
    [self showMessage:msg style:style completion:nil];
}

+ (void)showMessage:(NSString *)msg {
    [self showMessage:msg style:LYHUDStyleNone completion:nil];
}

+ (NSTimeInterval)displayDurationForString:(NSString *)string {
    return MIN(MAX((CGFloat)string.length * 0.06 + 0.5, 2.0), CGFLOAT_MAX);
}
                        
+ (nullable UIWindow *)frontWindow {
    __block UIWindow *window = nil;
    [UIApplication.sharedApplication.windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL onMainScreen = obj.screen == UIScreen.mainScreen;
        BOOL isVisible = !obj.hidden && obj.alpha > 0;
        BOOL isLevelSupported = obj.windowLevel == UIWindowLevelNormal;
        BOOL isKeyWindow = obj.isKeyWindow;
        
        if (onMainScreen && isVisible && isLevelSupported && isKeyWindow) {
            window = obj;
            *stop = YES;
        }
    }];
    return window;
}
 
+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha {
    CGFloat red = (CGFloat)(hex & 0xFF0000 >> 16) / 255.0;
    CGFloat green = (CGFloat)(hex & 0xFF00 >> 8) / 255.0;
    CGFloat blue = (CGFloat)(hex & 0xFF) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


@end
