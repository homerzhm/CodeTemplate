//
//  MainRouteViewController.h
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-04-13.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainRouteViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) IBOutlet UITableView * mainTable;

@end
