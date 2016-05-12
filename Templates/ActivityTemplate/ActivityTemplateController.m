//
//  ActivityTemplateController.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-04-13.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "ActivityTemplateController.h"
#import "ActivityItem.h"
@interface ActivityTemplateController ()

@end

@implementation ActivityTemplateController

-(UIViewController *)initForPresent{
    self = [super initWithNibName:@"ActivityTemplateController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)launch:(id)sender{
    NSArray *activityItems = @[[[ActivityItem alloc]initWithMessage:@"For Testing"]];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    if (IS_IPAD()) {
        activityVC.popoverPresentationController.sourceView = sender;
        activityVC.popoverPresentationController.sourceRect = ((UIView *)sender).bounds;
    }
    activityVC.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError){
        NSLog(@"Activity = %@",activityType);
        NSLog(@"Completed Status = %d",completed);
        if (completed) {
            
        }
    };
    [self presentViewController:activityVC animated:YES completion:^{
        
    }];

}

@end
