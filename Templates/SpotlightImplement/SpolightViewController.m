//
//  SpolightViewController.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-06-11.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "SpolightViewController.h"
#import "TemplateUtility.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import <MobileCoreServices/MobileCoreServices.h>

static NSString * spotlightCellIden = @"spotlightCellIden";

@interface SpolightViewController ()
@property(nonatomic) NSMutableArray * items;
@end

@implementation SpolightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.spolightItems registerNib:[UINib nibWithNibName:@"SpotlightTableViewCell" bundle:nil] forCellReuseIdentifier:spotlightCellIden];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadData];
}

-(void)reloadData{
    self.items = [Content getAllContentWithContext:[[TemplateUtility shareInstance] coredataManagerContext]];
    [self.spolightItems reloadData];
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

#pragma mark table view delegate datasource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 182.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SpotlightTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:spotlightCellIden];
    Content * content = [self.items objectAtIndex:indexPath.row];
    [cell.name setText: content.name];
    [cell.contentDesription setText:content.contentDescription];
    [cell.theImage setImage:[UIImage imageNamed:content.name]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [cell.createDateTime setText:[formatter stringFromDate:content.createDate]];
    
    
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.headerView.frame.size.height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

#pragma mark - TemplateViewControllerProtocal
-(UIViewController *)initForPresent{
    self = [super initWithNibName:@"SpolightViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

-(void)addToSpotLight:(id)sender{
    NSMutableArray * sps = [[NSMutableArray alloc]init];
    for (Content * cot in self.items) {
        CSSearchableItem * si = [self generateContentToSpotlightSearchAbleItem:cot];
        [sps addObject:si];
    }
    [[CSSearchableIndex defaultSearchableIndex]indexSearchableItems:sps completionHandler:^(NSError * _Nullable error) {
        
        NSString * message=@"Success Add";
        if (error) {
            NSLog(@"add search able item error: %@",error);
            message = @"Fail Add";
        }
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        });
    }];
}

-(void)deleteFromSpotLight:(id)sender{
    [[CSSearchableIndex defaultSearchableIndex]deleteSearchableItemsWithDomainIdentifiers:@[SpotlightDomain] completionHandler:^(NSError * _Nullable error) {
        NSString * message=@"Success Deleted";
        if (error) {
            NSLog(@"delete items error :%@",error);
            message = @"Fail Deleted";
        }
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        });
    }];
}

#pragma mark - Spotlight framework

-(CSSearchableItem *)generateContentToSpotlightSearchAbleItem:(Content *)content{
    CSSearchableItem * result = nil;
    CSSearchableItemAttributeSet * ats = [[CSSearchableItemAttributeSet alloc]initWithItemContentType:(NSString*)kUTTypeImage];
    ats.title = content.name;
    ats.contentDescription = content.contentDescription;
    ats.keywords = @[@"CodeTemplate",@"Homer",content.name];
    ats.thumbnailData = UIImagePNGRepresentation([UIImage imageNamed:content.name]);
    result = [[CSSearchableItem alloc]initWithUniqueIdentifier:[[content.objectID URIRepresentation] absoluteString] domainIdentifier:SpotlightDomain attributeSet:ats];
    return result;
}
@end
