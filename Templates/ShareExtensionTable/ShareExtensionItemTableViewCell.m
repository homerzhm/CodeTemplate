//
//  ShareExtensionItemTableViewCell.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-05-21.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "ShareExtensionItemTableViewCell.h"

@implementation ShareExtensionItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.image.layer setCornerRadius:5.0];
    [self.image.layer setBorderWidth:0.5];
    [self.image.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
