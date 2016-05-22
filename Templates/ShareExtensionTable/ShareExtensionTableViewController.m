//
//  ShareExtensionTableViewController.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-05-21.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "ShareExtensionTableViewController.h"
#import "TemplateUtility.h"
#import "ShareExtensionItemTableViewCell.h"

static NSString * shareExtensionTablCellIdentity = @"shareExtensionTablCellIdentity";

@interface ShareExtensionTableViewController ()
@property (nonatomic) NSMutableArray * shareItems;
@property (nonatomic) NSCache * imageCache;
@end

@implementation ShareExtensionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.sharedItemList registerNib:[UINib nibWithNibName:@"ShareExtensionItemTableViewCell" bundle:nil] forCellReuseIdentifier:shareExtensionTablCellIdentity];
    [self getShareData];
    self.imageCache = [[NSCache alloc]init];
    // Do any additional setup after loading the view from its nib.
}

-(UIViewController *)initForPresent{
    self = [super initWithNibName:@"ShareExtensionTableViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getShareData{
    self.shareItems = [[NSMutableArray alloc]init];
    [self.shareItems addObjectsFromArray:[[[TemplateUtility shareInstance]getShareUserDefault]objectForKey:ShareItems]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shareItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShareExtensionItemTableViewCell * theCell = (ShareExtensionItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:shareExtensionTablCellIdentity];
    NSDictionary * theDic = [self.shareItems objectAtIndex:indexPath.row];
    [theCell.name setText:[theDic objectForKey:ShareItemName]];
    UIImage * theImage =[self.imageCache objectForKey:[theDic objectForKey:ShareItemName]];
    if (!theImage) {
        NSString * theURL = [theDic objectForKey:ShareItemUrl];
        theImage = [UIImage imageWithContentsOfFile:theURL];
        [self.imageCache setObject:theImage forKey:[theDic objectForKey:ShareItemName]];
    }
    
    [theCell.image setImage:theImage];
    
    return theCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150.0;
}

@end
