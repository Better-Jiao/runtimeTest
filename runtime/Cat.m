//
//  Cat.m
//  runtime
//
//  Created by stoneli on 2019/1/31.
//  Copyright © 2019年 stoneli. All rights reserved.
//

#import "Cat.h"

@interface Cat ()
{
    NSInteger _age;
    NSString * _name;
}
@end

@implementation Cat

- (instancetype)init{
    self = [super init];
    if ([super init]) {
        _age = 8;
        _name = @"小花";
    }
    return self;
}


@end
