//
//  LWBaseViewController.m
//  RACObjc
//
//  Created by 王文震 on 2018/2/27.
//  Copyright © 2018年 Zahi. All rights reserved.
//

#import "LWBaseViewController.h"
#import <ReactiveObjC.h>
@interface LWBaseViewController ()

@end

@implementation LWBaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    LWBaseViewController *viewController = [super allocWithZone:zone];

    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)]
     subscribeNext:^(id x) {
         @strongify(viewController);
         [viewController initSubViews];
         [viewController bindSingle];
     }];

    return viewController;
}

- (void)initSubViews{

}

- (void)bindSingle{

}
@end
