//
//  BasicManagerdObject.h
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-06-11.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface BasicManagerdObject : NSManagedObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)context;


+(NSString *)entityName;

+(BasicManagerdObject *)entityFromContext:(NSManagedObjectContext *)context;

+ (NSMutableArray *)fetchResultsForPredicate:(NSPredicate *)aPredicate
                            withSortOrdering:(NSArray *)sortOrder
                       withPropertiesToFetch:(NSArray *)properties
                                   withLimit:(NSInteger)limit
                              withResultType:(NSFetchRequestResultType)resultType
                      inManagedObjectContext:(NSManagedObjectContext *)context;

@end
