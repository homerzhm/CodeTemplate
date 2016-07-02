//
//  SpotlightTableViewCell.h
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-06-11.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpotlightTableViewCell : UITableViewCell

@property (nonatomic) IBOutlet UILabel * name;
@property (nonatomic) IBOutlet UILabel * contentDesription;
@property (nonatomic) IBOutlet UILabel * createDateTime;
@property (nonatomic) IBOutlet UIImageView * theImage;

@end
