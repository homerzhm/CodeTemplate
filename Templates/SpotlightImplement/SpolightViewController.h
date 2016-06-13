//
//  SpolightViewController.h
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-06-11.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpotlightTableViewCell.h"
#import "TemplateViewControllerProtocal.h"
#import "TemplateUtility.h"

@interface SpolightViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,TemplateViewControllerProtocal>

@property(nonatomic) IBOutlet UITableView * spolightItems;
@property(nonatomic) IBOutlet UIView * headerView;

-(IBAction)addToSpotLight:(id)sender;
-(IBAction)deleteFromSpotLight:(id)sender;

@end
