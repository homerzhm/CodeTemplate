//
//  KeyboardInputViewController.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-04-24.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "KeyboardInputViewController.h"

@interface KeyboardInputViewController ()
@property (nonatomic) HInputViewController * inputVC;
@end

@implementation KeyboardInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialInputVC];
    // Do any additional setup after loading the view from its nib.
}

-(UIViewController *)initForPresent{
    self = [super initWithNibName:@"KeyboardInputViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

-(void)initialInputVC{
    self.inputVC = [[HInputViewController alloc]initInVC:self];
    [self addChildViewController:self.inputVC];
    [self.view addSubview:self.inputVC.view];
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

#pragma mark HInputViewControllerDelegate

-(void)sendMessage:(NSString *)message{
    [self.messageLabel setText:message];
}

-(void)inputControllerChangeWithFrame:(CGRect) frame{
    
}

@end
