//
//  ShareExtensionTableViewController.h
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-05-21.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TemplateViewControllerProtocal.h"

@interface ShareExtensionTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,TemplateViewControllerProtocal>

@property (nonatomic) IBOutlet UITableView * sharedItemList;



@end
