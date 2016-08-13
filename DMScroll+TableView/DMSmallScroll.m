//
//  DMSmallScroll.m
//  DMScroll+TableView
//
//  Created by demin on 16/8/12.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import "DMSmallScroll.h"

#define scrollWidth [UIScreen mainScreen].bounds.size.width
#define buttonWidth [UIScreen mainScreen].bounds.size.width / 4.5
@interface DMSmallScroll ()

@property (nonatomic,strong)NSMutableArray *buttonArrM;
@property (nonatomic, strong) UIView *slideView;//滑动的视图

@end


@implementation DMSmallScroll

- (instancetype)initWithSmallScroll:(NSArray *)array {
    if (self = [super init]) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.frame = CGRectMake(0, 0, scrollWidth, 30);
        self.contentSize = CGSizeMake(buttonWidth * array.count, 30);
        self.backgroundColor = [UIColor whiteColor];
        [self createSlideView];
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(buttonWidth * i, 0, buttonWidth, 30);
            [self addSubview:btn];
            [btn setTitle:array[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:50/255.0 green:51/255.0 blue:52/255.0 alpha:1] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i +100;
            [arr addObject:btn];
        }
        self.buttonArrM = arr;
        self.index = 0;
    }
    return self;
}

//创建滑动的视图
-(void)createSlideView{
    _slideView = [[UIView alloc]initWithFrame:CGRectMake(0, 28, buttonWidth, 2)];
    _slideView.backgroundColor = [UIColor colorWithRed:75/255.0 green:208/255.0 blue:150/255.0 alpha:1];
    [self addSubview:_slideView];
}

-(void)buttonClicked:(UIButton *)button{
    self.index = button.tag - 100;
    //    block的回调，当button的index发生变化时，将index的值传给视图控制器
    if (self.changeValueBlock) {
        _changeValueBlock(_index);
    }
}

-(void)setIndex:(NSInteger)index{
    //将上一个button设置成未选中状态
    UIButton *notSelectedButton = _buttonArrM[_index];
    notSelectedButton.selected = NO;
    UIButton *selectedButton = _buttonArrM[index];
    selectedButton.selected = YES;
    
    //设置选中的Button居中
    CGFloat offSetX = selectedButton.frame.origin.x - scrollWidth/2;
    //1、当offSetX的值小于0时（即点击的是中心点左边的button时），让offSetX为0；反之，让offSetX的值为selectedButton.frame.origin.x-kScreenWidth/2+kButtonWidth/2
    offSetX = offSetX > 0 ?(offSetX + buttonWidth/2):0;
    //2、在大于0的情况下，又大于self.contentSize.width - kScreenWidth时，offSetX 的值为self.contentSize.width - kScreenWidth，反之为：selectedButton.frame.origin.x-kScreenWidth/2+kButtonWidth/2
    offSetX = offSetX > self.contentSize.width - scrollWidth ? self.contentSize.width - scrollWidth :offSetX;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentOffset = CGPointMake(offSetX, 0);
    }];
    
    _index = index;
    CGRect frame = _slideView.frame;
    frame.origin.x = _index * buttonWidth;
    [UIView animateWithDuration:0.01 animations:^{
        _slideView.frame = frame;
    }];
}




@end
