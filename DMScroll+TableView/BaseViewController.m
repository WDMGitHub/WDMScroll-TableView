//
//  BaseViewController.m
//  DMScroll+TableView
//
//  Created by demin on 16/8/12.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import "BaseViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface BaseViewController ()
{
    FirstViewController *_firstVC;
    SecondViewController *_secondVC;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //原点
     self.navigationController.navigationBar.translucent = NO;
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:nil];
    segmentedControl.frame = CGRectMake(0, 0, 150, 30);
    
    segmentedControl.tintColor = [UIColor whiteColor]; //渲染色彩
    
    [segmentedControl insertSegmentWithTitle:@"项目"atIndex:0 animated:NO];
    
    [segmentedControl insertSegmentWithTitle:@"任务"atIndex:1 animated:NO];
    
    segmentedControl.selectedSegmentIndex = 0; //初始指定第0个选中
    
    [segmentedControl addTarget:self action:@selector(controlPressed:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationItem setTitleView:segmentedControl];
    
    //创建控制器的对象
    _firstVC = [[FirstViewController alloc] init];
    _firstVC.view.backgroundColor = [UIColor whiteColor];
    _secondVC = [[SecondViewController alloc] init];
    _secondVC.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_firstVC.view];

}

- (void)controlPressed:(UISegmentedControl *)seg {
    NSInteger Index = seg.selectedSegmentIndex;
      switch (Index) {
        case 0:
            //第一个界面
            [self.view addSubview:_firstVC.view];
            [_secondVC.view removeFromSuperview];
            break;
            
        case 1:
            [self.view addSubview:_secondVC.view];
            [_firstVC.view removeFromSuperview];
            break;
    }
}


    
@end
