//
//  ChangeValueViewController.m
//  runtime
//
//  Created by stoneli on 2019/1/31.
//  Copyright © 2019年 stoneli. All rights reserved.
//

#import "ChangeValueViewController.h"
#import <objc/runtime.h>
#import "Cat.h"

@interface ChangeValueViewController ()
@property (strong, nonatomic) IBOutlet UILabel *descriptLabel;
@end

@implementation ChangeValueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Cat *cat = [[Cat alloc] init];
    self.descriptLabel.text = [NSString stringWithFormat:@"这只猫叫%@,有%@岁了",[cat valueForKey:@"name"],[cat valueForKey:@"age"]];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)changeValue:(id)sender {
    
}

@end
