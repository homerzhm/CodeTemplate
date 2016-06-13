//
//  TemplateUtility.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-04-13.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "TemplateUtility.h"
#import "AppDelegate.h"

@implementation TemplateUtility

static TemplateUtility *instances = nil;

+(TemplateUtility *)shareInstance{
    @synchronized(self){
        if (instances == nil) {
            instances = [[self alloc]init];
            [instances initialContetData];
        }
    }
    return instances;
}

-(NSMutableArray *)returnRouteTable{
    NSMutableArray * result = [[NSMutableArray alloc]init];
    
    
    [result addObject:[self returnRouteTableDicWithName:@"Activity Share" withControllerName:@"ActivityTemplateController"]];
    [result addObject:[self returnRouteTableDicWithName:@"UI Components" withControllerName:@"ComponentsTemplateController"]];
    [result addObject:[self returnRouteTableDicWithName:@"Key board Input" withControllerName:@"KeyboardInputViewController"]];
    [result addObject:[self returnRouteTableDicWithName:@"Item from Shared Extension" withControllerName:@"ShareExtensionTableViewController"]];
    [result addObject:[self returnRouteTableDicWithName:@"Spotlight items" withControllerName:@"SpolightViewController"]];
    return result;
}

-(void)initialContetData{
    NSManagedObjectContext * context = [[TemplateUtility shareInstance] coredataManagerContext];
    NSMutableArray * contents = [Content getAllContentWithContext:context];
    if (contents.count == 0) {
        NSArray * images = @[
                             @{
                                 @"Name":@"Niagara falls",
                                 @"Description":@"Great falls......."
                                 },
                             @{
                                 @"Name":@"Ontario Lake",
                                 @"Description":@"Great lake......."
                                 },
                             @{
                                 @"Name":@"Skating",
                                 @"Description":@"ice...... great ice"
                                 },
                             @{
                                 @"Name":@"Subway",
                                 @"Description":@"Kobe... retired"
                                 },
                             @{
                                 @"Name":@"Toronto",
                                 @"Description":@"Beatufy place...."
                                 }];
        for (NSDictionary * dic in images) {
            Content * newC = (Content *)[Content entityFromContext:context];
            newC.name = [dic objectForKey:@"Name"];
            newC.createDate = [NSDate date];
            newC.contentDescription = [dic objectForKey:@"Description"];
            newC.imagePath = [dic objectForKey:@"Name"];
        }
        [[TemplateUtility shareInstance] saveContext];
    }
}

-(NSDictionary *)returnRouteTableDicWithName:(NSString *)name withControllerName:(NSString *)cName{
    NSDictionary * dic = @{TYPENAME:name,TYPEVIEWCONTROLLERNAME:cName};
    return dic;
}

-(NSUserDefaults *)getShareUserDefault{
    return [[NSUserDefaults alloc] initWithSuiteName:shareGroupIdentity];
}

-(NSURL *)getSharePathURL{
    return [[NSFileManager defaultManager]containerURLForSecurityApplicationGroupIdentifier:shareGroupIdentity];
}

-(NSMutableArray *)getContentArray{
    NSMutableArray * result = [[NSMutableArray alloc]init];
    
    return result;
}

-(NSManagedObjectContext *)coredataManagerContext{
    return [((AppDelegate *)[[UIApplication sharedApplication]delegate]) managedObjectContext];
}

-(void)saveContext{
    [((AppDelegate *)[[UIApplication sharedApplication]delegate]) saveContext];
}

@end
