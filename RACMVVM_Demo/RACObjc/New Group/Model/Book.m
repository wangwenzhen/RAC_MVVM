//
//  Book.m
//  RACObjc
//
//  Created by Zahi on 2017/8/18.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "Book.h"

@implementation Book


+ (instancetype)bookWithDict:(NSDictionary *)dict
{
    Book *book = [Book new];
    
    [book setValuesForKeysWithDictionary:dict];
    
    return book;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
