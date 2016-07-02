//
//  MainRouteViewController.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-04-13.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "MainRouteViewController.h"
#import "TemplateUtility.h"
#import "TemplateViewControllerProtocal.h"
@interface MainRouteViewController ()
@property (nonatomic) NSArray * mainArray;
@end

@implementation MainRouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"CodeTemplate"];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mainArray = [[TemplateUtility shareInstance]returnRouteTable];
    [self.mainTable reloadData];
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

#pragma mark - UITableView Delegate Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mainArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * theCell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    if (!theCell) {
        theCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MainCell"];
    }
    NSDictionary * dic = [self.mainArray objectAtIndex:indexPath.row];
    [theCell.textLabel setText:[dic objectForKey:TYPENAME]];
    [theCell.detailTextLabel setText:[dic objectForKey:TYPEVIEWCONTROLLERNAME]];
    
    return theCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * dic = [self.mainArray objectAtIndex:indexPath.row];
    Class theC = NSClassFromString([dic objectForKey:TYPEVIEWCONTROLLERNAME]);
    if (![theC conformsToProtocol:@protocol(TemplateViewControllerProtocal)]) {
        return;
    }
    UIViewController * vc = [[theC alloc]initForPresent];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
