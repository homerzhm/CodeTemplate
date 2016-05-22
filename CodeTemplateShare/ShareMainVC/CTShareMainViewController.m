//
//  CTShareMainViewController.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-05-16.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "CTShareMainViewController.h"
#import "TemplateUtility.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface CTShareMainViewController ()
@property (nonatomic) NSMutableDictionary * contentDic;
@end

@implementation CTShareMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.imageView.layer setCornerRadius:5.0];
    self.contentDic = [[NSMutableDictionary alloc]init];
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self processInputContent];
}

-(void)processInputContent{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray * array = self.extensionContext.inputItems;
        NSExtensionItem *inputItem = [array firstObject];
        NSItemProvider *itemProvider = inputItem.attachments.firstObject;
        if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]) {
            [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(UIImage *image, NSError *error) {
                if (!error) {
                    NSDate * date = [NSDate date];
                    NSString * fileName = [NSString stringWithFormat:@"%f.png",[date timeIntervalSince1970]];
                    [self.contentDic setObject:image forKey:@"Image"];
                    [self.contentDic setObject:fileName forKey:@"FileName"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self refreshContentUI];
                    });
                }
            }];
        }
    });
}

-(void)refreshContentUI{
    if ([self.contentDic allKeys].count > 0) {
        [self.imageView setImage:[self.contentDic objectForKey:@"Image"]];
        [self.fileName setText:[self.contentDic objectForKey:@"FileName"]];
    }
}

-(void)closeShare:(id)sender{
    [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
}

-(void)save:(id)sender{
    if ([self.contentDic allKeys].count == 0) {
        return;
    }
    NSData * data = UIImagePNGRepresentation([self.contentDic objectForKey:@"Image"]);
    NSString * actualThumbnail = [NSString stringWithFormat:@"%@/%@",[[self getSharePathURL] path],[self.contentDic objectForKey:@"FileName"]];
    NSDictionary * dic = @{
                           ShareItemName:[self.contentDic objectForKey:@"FileName"],
                           ShareItemUrl:actualThumbnail
                           };
    [data writeToFile:actualThumbnail atomically:YES];
    NSMutableArray * array = [[NSMutableArray alloc]initWithArray:[[self getShareUserDefault]objectForKey:ShareItems]];
    [array addObject:dic];
    [[self getShareUserDefault]setObject:array forKey:ShareItems];
    [[self getShareUserDefault]synchronize];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"Save Success" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self closeShare:nil];
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

-(NSUserDefaults *)getShareUserDefault{
    return [[NSUserDefaults alloc] initWithSuiteName:shareGroupIdentity];
}

-(NSURL *)getSharePathURL{
    return [[NSFileManager defaultManager]containerURLForSecurityApplicationGroupIdentifier:shareGroupIdentity];
}

@end
