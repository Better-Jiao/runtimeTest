//
//  ViewController+addProperty.m
//  runtime
//
//  Created by stoneli on 2019/1/31.
//  Copyright © 2019年 stoneli. All rights reserved.
//

#import "UIViewController+addProperty.h"
#import <objc/runtime.h>

@implementation UIViewController (addProperty)

- (void)setClickCount:(NSInteger)clickCount{
    objc_setAssociatedObject(self, @"clickCount", @(clickCount), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)clickCount{
    return  [objc_getAssociatedObject(self, @"clickCount") integerValue];
}

@end
