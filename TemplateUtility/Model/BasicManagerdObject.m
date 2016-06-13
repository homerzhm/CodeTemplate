//
//  BasicManagerdObject.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-06-11.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "BasicManagerdObject.h"

@implementation BasicManagerdObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)context{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return nil;
}

+(NSString *)entityName{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return nil;
}

+(BasicManagerdObject *)entityFromContext:(NSManagedObjectContext *)context{
    if (!context) {
        [NSException raise:NSInternalInconsistencyException format:@"You must have context assign - %@", NSStringFromSelector(_cmd)];
        return nil;
    }
    return [self insertInManagedObjectContext:context];
}

+ (NSMutableArray *)fetchResultsForPredicate:(NSPredicate *)aPredicate
                            withSortOrdering:(NSArray *)sortOrder
                       withPropertiesToFetch:(NSArray *)properties
                                   withLimit:(NSInteger)limit
                              withResultType:(NSFetchRequestResultType)resultType
                      inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request;
    NSEntityDescription *entity;
    NSError *error;
    NSMutableArray *array;
    
    request = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
    
    [request setEntity:entity];
    [request setPredicate:aPredicate];
    [request setSortDescriptors:sortOrder];
    [request setPropertiesToFetch:properties];
    if (resultType)
        [request setResultType:resultType];
    
    if (limit > 0)
        [request setFetchLimit:limit];
    
    error = nil;
    [request setReturnsObjectsAsFaults:NO]; // to Avoid the fauld data
    array = [NSMutableArray arrayWithArray:[context executeFetchRequest:request error:&error]]; // sometimes crashes here
    
    if (error) {
        NSLog(@"problem fetching [%@] [%@]", [error userInfo], [error debugDescription]);
    }
    
    return array;
}


@end
