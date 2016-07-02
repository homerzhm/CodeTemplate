//
//  TemplateUtility.h
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-04-13.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Content.h"

static NSString * shareGroupIdentity = @"group.Homerzuo.CodeTemplate.shareExtension";

static NSString * ShareItems = @"ShareItems";
static NSString * ShareItemName = @"ShareItemName";
static NSString * ShareItemUrl = @"ShareItemUrl";

static NSString * SpotlightDomain = @"com.CodeTemplate";

@interface TemplateUtility : NSObject

+(TemplateUtility *)shareInstance;

-(NSMutableArray *)returnRouteTable;

-(NSUserDefaults *)getShareUserDefault;
-(NSURL *)getSharePathURL;

-(NSMutableArray *)getContentArray;

-(NSManagedObjectContext *)coredataManagerContext;
-(void)saveContext;



@end
