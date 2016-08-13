//
//  DMSmallScroll.h
//  DMScroll+TableView
//
//  Created by demin on 16/8/12.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^changeIndexValueBlock)(NSInteger index);
@interface DMSmallScroll : UIScrollView

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) changeIndexValueBlock changeValueBlock;
- (instancetype)initWithSmallScroll:(NSArray *)array;

@end
