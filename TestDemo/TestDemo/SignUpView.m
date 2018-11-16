//
//  SignUpView.m
//  TestDemo
//
//  Created by hl h on 2018/11/15.
//  Copyright © 2018年 hl h. All rights reserved.
//

#import "SignUpView.h"
#import "CommonUtil.h"

@interface SignUpView()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField     *usernameField;
@property (nonatomic, strong) UITextField     *passwordField;
@property (nonatomic, strong) UITextField     *confirmpwField;
@property (nonatomic, strong) UIButton     *registerButton;
@end

@implementation SignUpView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype) getSignUpView:(CGRect)frame addBlock: (void(^)(UIButton *button))block {
    return [[self alloc] initSPWithFrame:frame addBlock: block];
}

-(instancetype) initSPWithFrame:(CGRect)frame addBlock: (void(^)(UIButton *button))block {
    self = [super init];
    if(self){
        self.frame = frame;
        self.userInteractionEnabled = YES;
        self.block = block;
        [self createUI];
        
         [_usernameField addTarget:self action:@selector(checkUsername:)forControlEvents:UIControlEventEditingChanged];
         [_passwordField addTarget:self action:@selector(checkPassword:) forControlEvents:UIControlEventEditingChanged];
         [_confirmpwField addTarget:self action:@selector(confirmPassword:) forControlEvents:UIControlEventEditingChanged];
        [_registerButton addTarget:self action:@selector(signup:) forControlEvents:UIControlEventTouchUpInside];
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
//    aLabel.text = @"注册用户";
//    [self addSubview:aLabel];
    
     _usernameField = [self getTextField:CGRectMake(80, 200, 280, 40) hint:@"请输入用户名" icon:@"login_user.png"];
     [self addSubview: _usernameField];
    
    _passwordField = [self getTextField:CGRectMake(80, 300, 280, 40) hint:@"请输入密码" icon:@"password.png"];
    [self addSubview: _passwordField];
    _confirmpwField = [self getTextField:CGRectMake(80, 400, 280, 40) hint:@"请再次确认密码" icon:@"password.png"];
    [self addSubview: _confirmpwField];
 
    _registerButton = [self getButton:CGRectMake(120, 500, 200, 40) hint:@"注册"];
    [self addSubview: _registerButton];
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
//    _passwordField.userInteractionEnabled = YES;
//    _confirmpwField.userInteractionEnabled = YES;
}
- (void)checkPassword:(UITextField *)textField {
    NSLog(@"checkPassword");
}
- (void)confirmPassword:(UITextField *)textField {
    NSLog(@"confirmPassword");
//    _registerButton.userInteractionEnabled = YES;
    
}

//-(void)showTip:(NSString* )tip{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
//    hud.mode = MBProgressHUDModeText;
//    hud.label.text = tip;
//    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8/*延迟执行时间*/ * NSEC_PER_SEC));
//    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//        [MBProgressHUD hideHUDForView:self animated:YES];
//    });
//}

- (void)signup:(UIButton *)btn {
    NSLog(@"signup");
    if(_usernameField.text.length != 0
       && _passwordField.text.length != 0
       && [_passwordField.text isEqualToString: _confirmpwField.text]){
//        _registerButton.userInteractionEnabled = YES;
        if (self.block) {
            // 调用block传入参数
            self.block(btn);
        }
    }else if(_usernameField.text.length == 0){
         [CommonUtil showTip: @"用户名不可为空" atView: self];
    }else{
//        _registerButton.userInteractionEnabled = NO;
        [CommonUtil showTip: @"两次输入的密码不一致" atView: self];
    }
    
}

// This method is called once we click inside the textField
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"Text field did begin editing");
    if([textField.placeholder containsString: @"密码"] && _usernameField.text.length == 0){
        [CommonUtil showTip: @"用户名不可为空" atView: self];
//        textField.userInteractionEnabled = NO;
    }
}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"Text field ended editing");
    
}
@end

