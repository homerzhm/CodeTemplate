//
//  Content.h
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-06-11.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BasicManagerdObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface Content : BasicManagerdObject

// Insert code here to declare functionality of your managed object subclass

+(NSMutableArray *)getAllContentWithContext:(NSManagedObjectContext *)context;
+(Content *)getContentWithId:(NSManagedObjectID *)objectId withContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "Content+CoreDataProperties.h"
