//
//  LoadNotificationViewController.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-06-22.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "LoadNotificationViewController.h"
#import "TemplateUtility.h"
#import "Content.h"
@interface LoadNotificationViewController ()
@end

@implementation LoadNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentImage.layer setCornerRadius:5.0];
    [self initialNavItem];
    // Do any additional setup after loading the view from its nib.
}

-(void)initialNavItem{
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:left];
    
    self.navigationItem.title = @"Content";
    
    [self.navigationController.navigationBar setTranslucent:NO];
}

-(void)back{
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshUIWithContent];
}

-(void)refreshUIWithContent{
    if (self.currentContent) {
        [self.contentImage setImage:[UIImage imageNamed:self.currentContent.imagePath]];
        [self.contentTitle setText:self.currentContent.name];
        [self.contentDescrition setText:self.currentContent.contentDescription];
    }
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

+(void)showWithUserActivity:(NSUserActivity *)userActivity{
    NSLog(@"%@",userActivity);
    
    NSManagedObjectContext * context = [[TemplateUtility shareInstance] coredataManagerContext];
    
    NSString * objectIdString = [userActivity.userInfo objectForKey:CSSearchableItemActivityIdentifier];
    NSURL * theURL = [NSURL URLWithString:objectIdString];
    NSManagedObjectID * objectID = [context.persistentStoreCoordinator managedObjectIDForURIRepresentation:theURL];
    Content * c = [Content getContentWithId:objectID withContext:context];
    if (c) {
        
        UINavigationController * nav;
        UIViewController * main = [[[[UIApplication sharedApplication]delegate]window]rootViewController];
        UIViewController * temp = main;
        UIViewController * theTop = temp;
        
        while (temp) {
            theTop = temp;
            temp = temp.presentedViewController;
        }
        
        if (theTop.view.tag == TagForNotificationNav) {
            nav = (UINavigationController *)theTop;
            LoadNotificationViewController* lv = (LoadNotificationViewController *)[[nav viewControllers]firstObject];
            lv.currentContent = c;
            [lv refreshUIWithContent];
        }else{
            LoadNotificationViewController * lv = [[LoadNotificationViewController alloc]initWithNibName:@"LoadNotificationViewController" bundle:nil];
            lv.currentContent = c;
            nav = [[UINavigationController alloc]initWithRootViewController:lv];
            nav.view.tag = TagForNotificationNav;
            [main presentViewController:nav animated:YES completion:^{
                
            }];
        }
    }
}

@end
