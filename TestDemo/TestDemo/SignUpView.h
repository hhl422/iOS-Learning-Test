//
//  SignUpView.h
//  TestDemo
//
//  Created by hl h on 2018/11/15.
//  Copyright © 2018年 hl h. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignUpView : UIView

@property (nonatomic, copy) void (^block)(UIButton *);
+(instancetype) getSignUpView:(CGRect)frame addBlock: (void(^)(UIButton *button))block ;
@end

NS_ASSUME_NONNULL_END
