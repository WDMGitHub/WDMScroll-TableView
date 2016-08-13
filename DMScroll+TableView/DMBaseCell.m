//
//  DMBaseCell.m
//  DMScroll+TableView
//
//  Created by demin on 16/8/12.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import "DMBaseCell.h"

@implementation DMBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.lineView.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    self.iconImage.layer.cornerRadius = self.iconImage.frame.size.width/2;
    [self.iconImage.layer setMasksToBounds:YES];
    self.bigView.layer.cornerRadius = 20;
    self.bigView.layer.borderWidth = 1;
    self.bigView.layer.borderColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1].CGColor;
    [self.bigView.layer setMasksToBounds:YES];
      
}

@end
