//
//  ViewController.m
//  runtime
//
//  Created by stoneli on 2019/1/30.
//  Copyright © 2019年 stoneli. All rights reserved.
//

#import <objc/runtime.h>
#import "ViewController.h"
#import "CategoryViewController.h"
#import "ForwardViewController.h"
#import "CodeViewController.h"
#import "ChangeValueViewController.h"


#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

static NSString *identifier = @"cell";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , copy) NSMutableArray * dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    self.title = @"runtime的使用";
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name = self.dataSource[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.textLabel.text = name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = self.dataSource[indexPath.row];
    if (indexPath.row == 0) {
       CategoryViewController *codeVc = [[CategoryViewController alloc] init];
        codeVc.title = title;
       [self.navigationController pushViewController:codeVc animated:YES];
    }else if(indexPath.row == 4){
        ForwardViewController *forwardVc = [[ForwardViewController alloc] init];
        forwardVc.title = title;
        [self.navigationController pushViewController:forwardVc animated:YES];
    }else if(indexPath.row == 5){
        ChangeValueViewController *change = [[ChangeValueViewController alloc] init];
        change.title = title;
        [self.navigationController pushViewController:change animated:YES];
    }
}



- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
        [_dataSource addObject:@"给分类添加属性"];
        [_dataSource addObject:@"动态添加方法"];
        [_dataSource addObject:@"字典转模型"];
        [_dataSource addObject:@"方法交换"];
        [_dataSource addObject:@"消息转发"];
        [_dataSource addObject:@"动态修改变量"];
        [_dataSource addObject:@"动态拦截或替换方法"];
    }
    return _dataSource;
}

@end
