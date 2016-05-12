//
//  KeyboardInputViewController.h
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-04-24.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HInputViewController.h"
#import "TemplateViewControllerProtocal.h"

@interface KeyboardInputViewController : UIViewController<HInputViewControllerDelegate,TemplateViewControllerProtocal>

@property (nonatomic) IBOutlet UILabel * messageLabel;

@end
