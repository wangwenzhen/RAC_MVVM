//
//  RACViewController.m
//  RACObjc
//
//  Created by 王文震 on 2018/2/27.
//  Copyright © 2018年 Zahi. All rights reserved.
//

#import "RACViewController.h"
#import <ReactiveObjC.h>
#import "RACReturnSignal.h"
#import "RACView.h"
#import "RACViewModel.h"
@interface RACViewController ()
@property (nonatomic,strong)RACView *racView;
@property (nonatomic,strong)RACViewModel *rac_viewModel;
@property (nonatomic,strong)RACSignal *bookSingle;
@property (nonatomic,strong)RACDisposable *disposable;
@end

@implementation RACViewController
- (void)dealloc{
    NSLog(@"。。。。 销毁 %@ class: %@",self, NSStringFromClass(self.class));
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initSubViews{
    [self.view addSubview:self.racView];
}

- (void)bindSingle{
    @weakify(self);
    RAC(self.rac_viewModel,name) = [self.racView.nameField.rac_textSignal doNext:^(NSString * _Nullable x) {
        @strongify(self);

        self.racView.lognInBtn.backgroundColor = x.length > 2 ? [UIColor blueColor] : [UIColor redColor];
    }];

    RAC(self.rac_viewModel,password) = self.racView.passwordField.rac_textSignal;
    RAC(self.racView.lognInBtn,enabled) = self.rac_viewModel.loginEanbleSingle;

    [[self.racView.lognInBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self request];
    }];
}

- (void)request{
    /** 请求原始JSON数据*/
    _bookSingle = [self.rac_viewModel.requestCommand execute:@{@"q":@"美"}.mutableCopy];

    [self setupViewModelData];
}

- (void)setupViewModelData{
    @weakify(self);
    _disposable = [self.bookSingle subscribeNext:^(NSArray <Book *>*books) {
        @strongify(self);
        
        [self.rac_viewModel sendJsonOriginalData:books createDatacompleteHandle:^(id viewData) {
            /** 构建好的数据存入 该vm的数据源中*/
            @strongify(self);
            [self.rac_viewModel.data setValue:viewData forKey:@"books"];
            [self setupUI];
            //请求动画 关闭
        }];
    }];

    /** 切断信号传输*/
//    [_disposable dispose];
}

- (void)setupUI{
    NSArray <Book *>*books = self.rac_viewModel.data[@"books"];

    self.racView.book = books.firstObject;
}

#pragma mark - Getter&Setter
- (RACView *)racView{
    if (!_racView) {
        _racView = [[RACView alloc] initWithFrame:self.view.bounds];
    }
    return _racView;
}
- (RACViewModel *)rac_viewModel{
    if (!_rac_viewModel) {
        _rac_viewModel = [RACViewModel new];
    }
    return _rac_viewModel;
}
@end
