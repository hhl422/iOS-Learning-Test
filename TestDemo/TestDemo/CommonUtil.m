//
//  CommonUtil.m
//  TestDemo
//
//  Created by hl h on 2018/11/16.
//  Copyright © 2018年 hl h. All rights reserved.
//

#import "CommonUtil.h"
#import "MBProgressHUD.h"

@implementation CommonUtil

+(void)showTip:(NSString* )tip atView: (nonnull UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = tip;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:view animated:YES];
    });
}

@end
