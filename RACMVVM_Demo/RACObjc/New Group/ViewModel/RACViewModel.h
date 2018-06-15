//
//  RACViewModel.h
//  RACObjc
//
//  Created by 王文震 on 2018/2/27.
//  Copyright © 2018年 Zahi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "Book.h"
@interface RACViewModel : NSObject
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *password;

/** 界面数据 格式
 {
    "books": "",//Book模型数据
 }
 */
@property (nonatomic,strong)NSMutableDictionary *data;
/** 信号登录响应事件*/
@property (nonatomic,strong)RACSignal *loginEanbleSingle;
/** 请求命令*/
@property (nonatomic,strong)RACCommand *requestCommand;

/** 发送原始数据 【构建一些复杂的数据】
    返回构造数据
*/
- (void)sendJsonOriginalData:(id)originalData
                    createDatacompleteHandle:(void (^)(id viewData))createDatacompleteHandle;
@end
