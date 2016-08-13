//
//  ViewController.m
//  DMScroll+TableView
//
//  Created by demin on 16/8/12.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;

    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor colorWithRed:75/255.0 green:208/255.0 blue:150/255.0 alpha:1];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self;
}

- (void)clickBtn {
    BaseViewController *BaseVC = [[BaseViewController alloc] init];
    [self.navigationController pushViewController:BaseVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
