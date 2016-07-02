//
//  LoadNotificationViewController.h
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-06-22.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreSpotlight/CoreSpotlight.h>
#define TagForNotificationNav 666
@interface LoadNotificationViewController : UIViewController

@property (nonatomic) IBOutlet UILabel * contentTitle;
@property (nonatomic) IBOutlet UILabel * contentDescrition;
@property (nonatomic) IBOutlet UIImageView * contentImage;

@property (nonatomic) Content * currentContent;


+(void)showWithUserActivity:(NSUserActivity *)userActivity;

@end
