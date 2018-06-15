//
//  RACView.m
//  RACObjc
//
//  Created by 王文震 on 2018/2/27.
//  Copyright © 2018年 Zahi. All rights reserved.
//

#import "RACView.h"

@implementation RACView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews{
    _nameField = [UITextField new];
    _nameField.placeholder = @"name";
    _passwordField = [UITextField new];
    _passwordField.placeholder = @"password";
    _nameField.frame = CGRectMake(0, 0, 100, 50);
    _passwordField.frame = CGRectMake(0, 200, 100, 50);
    [self addSubview:_nameField];
    [self addSubview:_passwordField];
    _lognInBtn = [UIButton new];
    _lognInBtn.backgroundColor = [UIColor redColor];
    [_lognInBtn setTitle:@"login" forState:UIControlStateNormal];
    _lognInBtn.frame =CGRectMake(0, self.frame.size.height - 70, 80, 50);
    [self addSubview:_lognInBtn];
}

- (void)setBook:(Book *)book{
    _book = book;
    [self setupSubviews];
}

- (void)setupSubviews{
    NSLog(@"渲染 界面数据");
}
@end
