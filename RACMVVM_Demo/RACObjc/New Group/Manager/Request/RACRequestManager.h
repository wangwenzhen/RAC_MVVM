//
//  RACRequestManager.h
//  RACObjc
//
//  Created by 王文震 on 2018/2/27.
//  Copyright © 2018年 Zahi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <ReactiveObjC.h>
@interface RACRequestManager : NSObject
+ (AFHTTPRequestOperation *_Nullable)requestBooksWithParam:(NSDictionary *_Nonnull)requestDic
                                 andRACSubscriber:(id<RACSubscriber>  _Nonnull)subscriber;
@end
