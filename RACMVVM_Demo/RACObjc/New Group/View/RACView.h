//
//  RACView.h
//  RACObjc
//
//  Created by 王文震 on 2018/2/27.
//  Copyright © 2018年 Zahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>
#import "Book.h"
@interface RACView : UIView
@property (nonatomic,strong)UITextField *nameField;
@property (nonatomic,strong)UITextField *passwordField;
@property (nonatomic,strong)UIButton *lognInBtn;

@property (nonatomic,strong)Book *book;

@end
