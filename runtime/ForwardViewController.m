//
//  ForwardViewController.m
//  runtime
//
//  Created by stoneli on 2019/1/31.
//  Copyright © 2019年 stoneli. All rights reserved.
//

#import "ForwardViewController.h"
#import <objc/runtime.h>
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
static ForwardViewController *selfClass =nil;
static BOOL canGoStepOne = false;
static BOOL canGoStepTwo = false;
static BOOL canGoStepThree = false;

@interface Person : NSObject

@end

@implementation Person

- (void)msg{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"人发送的msg" message:@"这是转发机制的第二步或者第三步" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:action];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

@end


@interface ForwardViewController ()
@property (nonatomic , strong)  UITextView * descriptionView;
@property (nonatomic , strong)  UILabel * unhandlerLabel;
@property (nonatomic , strong) UIButton * unhandlerBtn;
@property (nonatomic , strong)  UILabel * firstStepLabel;
@property (nonatomic , strong) UIButton * firstStepBtn;
@property (nonatomic , strong)  UILabel * secondStepLabel;
@property (nonatomic , strong) UIButton * secondStepBtn;
@property (nonatomic , strong)  UILabel * thirdStepLabel;
@property (nonatomic , strong) UIButton * thirdStepBtn;
@end

@implementation ForwardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    selfClass = self;
}

- (void)doesNotRecognizeSelector:(SEL)aSelector{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"不识别的方法" message:@"请检查代码" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:sure];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)forword{
    [self performSelector:@selector(msg)];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if ([NSStringFromSelector(sel) isEqualToString:@"msg"] && canGoStepOne) {
        class_addMethod([self class], sel, (IMP)msgForward, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}


- (id)forwardingTargetForSelector:(SEL)aSelector{
    if (canGoStepTwo && [NSStringFromSelector(aSelector) isEqualToString:@"msg"]) {
        return [Person new];
    }
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"msg"] && canGoStepThree) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    Person *p = [Person new];
    if ([p respondsToSelector:anInvocation.selector] ) {
        [anInvocation invokeWithTarget:p];
    }else{
        [self doesNotRecognizeSelector:anInvocation.selector];
    }
}


void msgForward(id obj,SEL _cmd){
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"消息转发" message:@"动态方法解析" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action];
    [selfClass presentViewController:alert animated:YES completion:nil];
}

- (IBAction)unhandle:(id)sender {
    NSLog(@"不做处理");
    [self forword];
}

- (IBAction)stepOneOpen:(UIButton *)sender {
    canGoStepOne = !canGoStepOne;
    if (canGoStepOne) {
        [sender setTitle:@"关闭" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"开启" forState:UIControlStateNormal];
    }
}

- (IBAction)doStepOne:(UIButton *)sender {
    [self forword];
}
- (IBAction)stepTwoOpen:(UIButton *)sender {
    canGoStepTwo = !canGoStepTwo;
    if (canGoStepTwo) {
        [sender setTitle:@"关闭" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"开启" forState:UIControlStateNormal];
    }
}
- (IBAction)doStepTwo:(UIButton *)sender {
    [self forword];
}
- (IBAction)stepThreeOpen:(UIButton *)sender {
    canGoStepThree = !canGoStepThree;
    if (canGoStepThree) {
        [sender setTitle:@"关闭" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"开启" forState:UIControlStateNormal];
    }
}
- (IBAction)doStepThree:(UIButton *)sender {
    [self forword];
}

@end
