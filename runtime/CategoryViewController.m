//
//  CategoryViewController.m
//  runtime
//
//  Created by stoneli on 2019/1/31.
//  Copyright © 2019年 stoneli. All rights reserved.
//

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#import "CategoryViewController.h"
#import "UIViewController+addProperty.h"

@interface CategoryViewController ()
@property (nonatomic , strong) UILabel * countLabel;
@property (nonatomic , strong) UITextView * textView;
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.countLabel];
    [self.view addSubview:self.textView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.clickCount++;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)self.clickCount];
}


- (UITextView *)textView{
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 100)];
        _textView.text = @"给UIViewController添加了一个分类，分类里添加了一个属性clickCount，该控制器继承于UIViewController，每次点击该控制器都会使clickCount加1";
    }
    return _textView;
}

- (UILabel *)countLabel{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _countLabel.center = CGPointMake(SCREENWIDTH* 0.5, SCREENHEIGHT *0.5);
        _countLabel.bounds = CGRectMake(0, 0, SCREENWIDTH, 100);
        _countLabel.backgroundColor = [UIColor redColor];
        _countLabel.font = [UIFont systemFontOfSize:20];
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

@end
