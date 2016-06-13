//
//  SpotlightTableViewCell.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-06-11.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "SpotlightTableViewCell.h"

@implementation SpotlightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.theImage.layer setCornerRadius:5.0];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
