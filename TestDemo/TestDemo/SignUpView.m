//
//  SignUpView.m
//  TestDemo
//
//  Created by hl h on 2018/11/15.
//  Copyright © 2018年 hl h. All rights reserved.
//

#import "SignUpView.h"

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

+(instancetype) getSignUpView:(CGRect)frame {
    return [[self alloc] initSPWithFrame:frame];
}

-(instancetype) initSPWithFrame:(CGRect)frame {
    self = [super init];
    if(self){
        
        self.frame = frame;
        self.userInteractionEnabled = YES;
        [self createUI];
        
        
    }
    
    return self;
}

/* UI组件 */
-(void) createUI{
    [self layoutIfNeeded];
    
    UILabel *aLabel = [[UILabel alloc]initWithFrame:
                       CGRectMake(80, 100, 280, 80)];
    aLabel.numberOfLines = 0;
    aLabel.textColor = [UIColor blueColor];
    aLabel.backgroundColor = [UIColor clearColor];
    aLabel.textAlignment = NSTextAlignmentCenter;
    aLabel.text = @"注册用户";
    [self addSubview:aLabel];
    
     _usernameField = [self getTextField:CGRectMake(80, 200, 280, 40) hint:@"请输入用户名" icon:@"login_user.png"];
     [_usernameField addTarget:self action:@selector(checkUsername:) forControlEvents:UIControlEventEditingChanged];
     [self addSubview: _usernameField];
    
    _passwordField = [self getTextField:CGRectMake(80, 300, 280, 40) hint:@"请输入密码" icon:@"password.png"];
     [_passwordField addTarget:self action:@selector(checkPassword:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview: _passwordField];
    
    _confirmpwField = [self getTextField:CGRectMake(80, 400, 280, 40) hint:@"请再次确认密码" icon:@"password.png"];
     [_confirmpwField addTarget:self action:@selector(confirmPassword:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview: _confirmpwField];
 
    _registerButton = [self getButton:CGRectMake(120, 500, 200, 40) hint:@"注册"];
     [_registerButton addTarget:self action:@selector(signup:) forControlEvents:UIControlEventTouchUpInside];
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
}
- (void)checkPassword:(UITextField *)textField {
    NSLog(@"checkPassword");
}
- (void)confirmPassword:(UITextField *)textField {
    NSLog(@"confirmPassword");
}
- (void)signup:(UIButton *)btn {
    NSLog(@"signup");
}

// This method is called once we click inside the textField
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"Text field did begin editing");
}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"Text field ended editing");
}
@end
