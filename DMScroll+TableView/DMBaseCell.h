//
//  DMBaseCell.h
//  DMScroll+TableView
//
//  Created by demin on 16/8/12.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMBaseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stateImage;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UIView *bigView;

@end
