//
//  SignInview.m
//  TestDemo
//
//  Created by hl h on 2018/11/16.
//  Copyright © 2018年 hl h. All rights reserved.
//

#import "SignInview.h"
#import "CommonUtil.h"

@interface SignInview()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField     *usernameField;
@property (nonatomic, strong) UITextField     *passwordField;
@property (nonatomic, strong) UIButton     *loginButton;
@end


@implementation SignInview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype) getSignInview:(CGRect)frame addBlock: (void(^)(UIButton *button))block {
    return [[self alloc] initSIWithFrame:frame addBlock: block];
}

-(instancetype) initSIWithFrame:(CGRect)frame addBlock: (void(^)(UIButton *button))block {
    self = [super init];
    if(self){
        self.frame = frame;
        self.userInteractionEnabled = YES;
        self.block = block;
        [self createUI];
        
        [_usernameField addTarget:self action:@selector(checkUsername:) forControlEvents:UIControlEventEditingChanged];
        [_passwordField addTarget:self action:@selector(checkPassword:) forControlEvents:UIControlEventEditingChanged];
        [_loginButton addTarget:self action:@selector(signIn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

/* UI组件 */
-(void) createUI{
    [self layoutIfNeeded];
    
//    UILabel *aLabel = [[UILabel alloc]initWithFrame:
//                       CGRectMake(80, 100, 280, 80)];
//    aLabel.numberOfLines = 0;
//    aLabel.textColor = [UIColor blueColor];
//    aLabel.backgroundColor = [UIColor clearColor];
//    aLabel.textAlignment = NSTextAlignmentCenter;
//    aLabel.text = @"登陆";
//    [self addSubview:aLabel];
    
    _usernameField = [self getTextField:CGRectMake(80, 200, 280, 40) hint:@"请输入用户名" icon:@"login_user.png"];
    [self addSubview: _usernameField];
    
    _passwordField = [self getTextField:CGRectMake(80, 300, 280, 40) hint:@"请输入密码" icon:@"password.png"];
    [self addSubview: _passwordField];
    
    _loginButton = [self getButton:CGRectMake(120, 500, 200, 40) hint:@"登陆"];
    [self addSubview: _loginButton];
}

-(UITextField*) getTextField:(CGRect)position hint:(NSString* )placeholder icon:(NSString* )iconPath{
    UIImageView *imgview = [[UIImageView alloc]
                            initWithFrame:CGRectMake(position.origin.x, position.origin.y, 24, 24)];
    [imgview setImage:[UIImage imageNamed:iconPath]];
    [imgview setContentMode:UIViewContentModeScaleAspectFit];
    
    UITextField *textField = [[UITextField  alloc] initWithFrame:position];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [textField setFont:[UIFont boldSystemFontOfSize:16]];
    textField.placeholder = placeholder;
    textField.leftView = imgview;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    // sets the delegate to the current class
    textField.delegate = self;
    
    return textField;
}

-(UIButton* )getButton:(CGRect)position hint:(NSString* )name {
    UIButton *roundRectButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [roundRectButton setFrame: position];
    [roundRectButton setBackgroundColor: [UIColor colorWithRed: 18.0f green: 150.0f blue: 219.0f alpha: 1.0f]];
    [roundRectButton setTitle: name forState: UIControlStateNormal];
    return roundRectButton;
}

- (void)checkUsername:(UITextField *)textField {
    NSLog(@"checkUsername");
}
- (void)checkPassword:(UITextField *)textField {
    NSLog(@"checkPassword");
}
- (void)signIn:(UIButton *)btn {
    NSLog(@"signIn");
    if(_usernameField.text.length != 0 && _passwordField.text.length != 0){
//        _loginButton.userInteractionEnabled = YES;
        if (self.block) {
            self.block(btn);
        }
    }else{
//        _loginButton.userInteractionEnabled = NO;
        [CommonUtil showTip: @"用户名/密码不可为空" atView: self];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"Text field did begin editing");
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"Text field ended editing");
}

@end
