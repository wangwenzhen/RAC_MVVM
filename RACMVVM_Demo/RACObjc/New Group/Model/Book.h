//
//  Book.h
//  RACObjc
//
//  Created by Zahi on 2017/8/18.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *title;
/** 扩展对象*/
@property (nonatomic,assign)NSNumber *number;

+ (instancetype)bookWithDict:(NSDictionary *)dict;

@end
