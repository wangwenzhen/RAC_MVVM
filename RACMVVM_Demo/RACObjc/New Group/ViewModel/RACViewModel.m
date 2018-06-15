//
//  RACViewModel.m
//  RACObjc
//
//  Created by 王文震 on 2018/2/27.
//  Copyright © 2018年 Zahi. All rights reserved.
//

#import "RACViewModel.h"
#import "RACRequestManager.h"
#import <RACReturnSignal.h>
@interface  RACViewModel()
/** 用来发送原始数据*/
@property (nonatomic,strong)RACSubject *subjectOriginalJsonData;
/** 构建好的界面数据*/
@property (nonatomic,strong)RACSignal *signalViewData;
@end
@implementation RACViewModel
- (instancetype)init{
    if (self = [super init]) {
        [self initSingle];
        [self setupCommand];
    }
    return self;
}

- (void)initSingle{
    _loginEanbleSingle = [RACSignal combineLatest:@[RACObserve(self, name),RACObserve(self, password)] reduce:^id (NSString *name,NSString *password){
        return @([name length] > 0 && [password length] > 0);
    }];
}

/**
 命令设置
 */
- (void)setupCommand{

    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSMutableDictionary *input) {
        //构造请求的参数
        [input setValue:@"美女" forKey:@"q"];

        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSLog(@"信号被订阅");
            //请求接口 动画打开
            [RACRequestManager requestBooksWithParam:input andRACSubscriber:subscriber];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"清理 缓存的垃圾数据");
            }];
        }];
    }];

    
    [[[_requestCommand executing] skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if (x.boolValue) {
            NSLog(@"。。。。请求中");
        } else {
            NSLog(@"。。。。请求结束");
        }
    }];

    [_requestCommand.errors subscribeNext:^(NSError * _Nullable x) {
        NSLog(@"请求异常");
        //开启异常界面
    }];

}

- (void)sendJsonOriginalData:(id)originalData
    createDatacompleteHandle:(void (^)(id viewData))createDatacompleteHandle{
    //创建信号
    //绑定信号
    _signalViewData = [self.subjectOriginalJsonData flattenMap:^__kindof RACSignal * _Nullable(NSArray <Book *>* books) {
        /** 构建界面 展示 需要的数据*/
        __block int index = 0;
        NSArray <Book *>*viewData = [[books.rac_sequence map:^id _Nullable(Book * _Nullable value) {
            index ++;
            value.number = @(index);
            return value;
        }] array];

        //返回信号用来包装修改过的内容
        return [RACReturnSignal return:viewData];
    }];

    //订阅绑定信号
    [_signalViewData subscribeNext:^(id  _Nullable viewData) {
        NSLog(@"构件好的ViewData\n\n\t\t %@",viewData);
        if (createDatacompleteHandle) {
            createDatacompleteHandle(viewData);
        }
    }];

    //发送数据
    [self.subjectOriginalJsonData sendNext:originalData];

}

- (RACSubject *)subjectOriginalJsonData{
    if (!_subjectOriginalJsonData) {
        _subjectOriginalJsonData =[RACSubject subject];
    }
    return _subjectOriginalJsonData;
}


- (NSMutableDictionary *)data{
    if (!_data) {
        _data = [NSMutableDictionary new];
    }
    return _data;
}
@end
