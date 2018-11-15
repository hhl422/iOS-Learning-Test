//
//  ViewController.m
//  TestDemo
//
//  Created by hl h on 2018/11/15.
//  Copyright © 2018年 hl h. All rights reserved.
//

#import "ViewController.h"
#import "SignUpView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"注册/登陆";//咋没显示?_?
    
    SignUpView *SPV = [SignUpView getSignUpView: CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height)];
//    [self.navigationController pushViewController:SPVC animated:YES];
    [self.view addSubview: SPV ];
}


@end
