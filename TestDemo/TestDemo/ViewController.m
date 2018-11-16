//
//  ViewController.m
//  TestDemo
//
//  Created by hl h on 2018/11/15.
//  Copyright © 2018年 hl h. All rights reserved.
//

#import "ViewController.h"
#import "SignUpView.h"
#import "SignInview.h"

@interface ViewController ()
@property UIView *signup;
@property UIView *signin;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"注册/登陆";//咋没显示?_?
    
    //实例化登陆页面，添加登陆按钮回调
    _signin = [SignInview getSignInview: CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height)
                                       addBlock: ^(UIButton *button) {
                                           NSLog(@"匹配用户信息，登陆");
                                       }];
    //实例化注册页面，添加注册按钮回调
    _signup = [SignUpView getSignUpView: CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height)
                                       addBlock: ^(UIButton *button) {
                                           NSLog(@"注册，纪录用户信息");
                                           NSLog(@"跳转登录页面");
                                          [self.signup removeFromSuperview];
                                           [self.view addSubview: self.signin];
                                       }];
    [self.view addSubview: _signup];
    
}


@end
