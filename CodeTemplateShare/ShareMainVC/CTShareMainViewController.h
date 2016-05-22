//
//  CTShareMainViewController.h
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-05-16.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTShareMainViewController : UIViewController

@property (nonatomic) IBOutlet UILabel * fileName;
@property (nonatomic) IBOutlet UIImageView * imageView;

-(IBAction)save:(id)sender;

-(IBAction)closeShare:(id)sender;

@end
