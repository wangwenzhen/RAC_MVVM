//
//  RACRequestManager.m
//  RACObjc
//
//  Created by 王文震 on 2018/2/27.
//  Copyright © 2018年 Zahi. All rights reserved.
//

#import "RACRequestManager.h"
#import "Book.h"
static NSString * const TEST_PATH = @"https://api.douban.com/v2/book/search";
@implementation RACRequestManager
+ (AFHTTPRequestOperation *_Nullable)requestBooksWithParam:(NSDictionary *_Nonnull)requestDic
                                          andRACSubscriber:(id<RACSubscriber>  _Nonnull)subscriber;{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    return [mgr GET:TEST_PATH parameters:requestDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

        NSLog(@"请求成功");

        NSArray *dictArray = responseObject[@"books"];
        NSArray <Book *>*modelArray = [[dictArray.rac_sequence map:^id _Nullable(id  _Nullable value) {
            Book *book = [Book bookWithDict:value];
            return book;
        }] array];

        //发送 json 原始数据
        [subscriber sendNext:modelArray];
        [subscriber sendCompleted];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"请求失败");
        [subscriber sendError:error];
    }];
}
@end
