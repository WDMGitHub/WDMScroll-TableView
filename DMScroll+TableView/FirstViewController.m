//
//  FirstViewController.m
//  DMScroll+TableView
//
//  Created by demin on 16/8/12.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import "FirstViewController.h"
#import "DMSmallScroll.h"
#import "DMBaseCell.h"

#define ScrollTableWidth [UIScreen mainScreen].bounds.size.width
#define ScrollTableHeight [UIScreen mainScreen].bounds.size.height
@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *leftArr;
@property (nonatomic, strong) NSArray *midArr;
@property (nonatomic, strong) NSArray *rigthArr;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *tabArr;
@property (nonatomic, strong) DMSmallScroll *scroll;
//数据源存放model
@property (nonatomic, strong) NSArray *statuss;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *leftTable;
@property (nonatomic, strong) UITableView *midTable;
@property (nonatomic, strong) UITableView *rightTable;
@property (nonatomic) BOOL isView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.titles = @[@"我创建的",@"分配给我",@"我关注的",@"我负责的",@"已完成的"];
    _tabArr=@[@[@"1",@"1",@"1"],@[@"2",@"2",@"2"],@[@"3",@"3",@"3"],@[@"4",@"4",@"4"],@[@"5",@"5",@"5"]];
    
    [self addSmllScroll];
    [self creatScrollTableView];
    [self changeTableViewAndLoadData];

}

static NSString *identifier = @"BaseCell";

-(void)addSmllScroll{
    _scroll = [[DMSmallScroll alloc]initWithSmallScroll:_titles];
    _scroll.bounces = YES;
    __weak typeof(self) weakSelf = self;
    _scroll.changeValueBlock = ^(NSInteger indexs){
        weakSelf.currentIndex=indexs;
        [weakSelf changeTableViewAndLoadData];
    };
    [self.view addSubview:_scroll];
}
-(void)creatScrollTableView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, ScrollTableWidth, ScrollTableHeight)];
    self.scrollView.contentSize = CGSizeMake(ScrollTableWidth*3, ScrollTableHeight);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces=NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate=self;
    _scrollView.contentOffset = CGPointMake(0, 0);
    
    self.leftTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScrollTableWidth, ScrollTableHeight-30-49-15)];
    self.leftTable.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    self.leftTable.rowHeight = 133;
    
    self.midTable = [[UITableView alloc]initWithFrame:CGRectMake(ScrollTableWidth, 0, ScrollTableWidth, ScrollTableHeight-30-49-15)];
    self.midTable.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    self.midTable.rowHeight = 133;
    
    self.rightTable = [[UITableView alloc]initWithFrame:CGRectMake(ScrollTableWidth*2, 0, ScrollTableWidth, ScrollTableHeight-30-49-15)];
    self.rightTable.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    self.rightTable.rowHeight = 133;
    
    _leftTable.delegate=self;
    _leftTable.dataSource=self;
    _midTable.delegate=self;
    _midTable.dataSource=self;
    _rightTable.delegate=self;
    _rightTable.dataSource=self;
    
    //注册单元格
    [_leftTable registerNib:[UINib nibWithNibName:@"DMBaseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
    [_midTable registerNib:[UINib nibWithNibName:@"DMBaseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
    [_rightTable registerNib:[UINib nibWithNibName:@"DMBaseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
    
    [self.scrollView addSubview:self.leftTable];
    [self.scrollView addSubview:self.midTable];
    [self.scrollView addSubview:self.rightTable];
    [self.view addSubview:self.scrollView];
    
}
//确保索引可用
-(NSInteger)indexForEnable:(NSInteger)index{
  
    if (index < 0 || index == 0) {
        return _currentIndex=0;
    }else if (index > self.tabArr.count - 1 || index == self.tabArr.count - 1){
        return _currentIndex = self.tabArr.count-1;
    }else{
        return _currentIndex==index;
    }
}
#pragma mark -UIScrollViewDelegate
//滚动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView != self.scrollView) {
        return;
    }
    //tableView继承scrollView，如果没有上面的判断下拉tableView的时候默认scrollView.contentOffset.x == 0也就是认为向右滑动
    if (scrollView.contentOffset.x == 0) {//右滑（看上一张）
        _currentIndex--;
    }
    if (scrollView.contentOffset.x == ScrollTableWidth * 2){//左滑（看下一张）
        _currentIndex++;
    }
    //在最左边往左滑看下一张
    if (_currentIndex == 0 && scrollView.contentOffset.x == ScrollTableWidth){
        _currentIndex++;
    }
    //在最右边往右滑看上一张
    if(_currentIndex == self.tabArr.count-1 && scrollView.contentOffset.x == ScrollTableWidth){
        _currentIndex--;
    }
    if ([scrollView isEqual:self.scrollView]) {
        if (_currentIndex<0) {
            _currentIndex=0;
        }
        if (_currentIndex>self.tabArr.count-1) {
            _currentIndex=self.tabArr.count-1;
        }
        _scroll.index = _currentIndex;
    }
    [self indexForEnable:_currentIndex];
    [self changeTableViewAndLoadData];
}
- (void)changeTableViewAndLoadData{
    //index = 0 情况，只需要刷新左边tableView和中间tableView
    if (_currentIndex == 0) {
        _leftArr = self.tabArr[_currentIndex];
        _midArr = self.tabArr[_currentIndex +1];
        
        [_leftTable reloadData];
        [_midTable reloadData];
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
        //index 是为最后的下标时，刷新右边tableView 和 中间 tableView
    }else if(_currentIndex == _tabArr.count - 1){
        _rigthArr = self.tabArr[_currentIndex];
        _midArr = self.tabArr[_currentIndex - 1];
        [_rightTable reloadData];
        [_midTable reloadData];
        
        self.scrollView.contentOffset = CGPointMake(ScrollTableWidth*2, 0);
        //除了上边两种情况，三个tableView 都要刷新，为了左右移动时都能够显示数据
    }else{
        _rigthArr = self.tabArr[_currentIndex+1];
        _midArr = self.tabArr[_currentIndex];
        _leftArr = self.tabArr[_currentIndex - 1];
        
        [_rightTable reloadData];
        [_midTable reloadData];
        [_leftTable reloadData];
        
        self.scrollView.contentOffset = CGPointMake(ScrollTableWidth, 0);
    }
}

#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DMBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    if (tableView==_leftTable) {
//        cell.textLabel.text=self.leftArr[indexPath.row];
    }
    if (tableView==_midTable) {
//        cell.textLabel.text=self.midArr[indexPath.row];
    }
    if (tableView==_rightTable) {
//        cell.textLabel.text=self.rigthArr[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
