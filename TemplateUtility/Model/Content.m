//
//  Content.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-06-11.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "Content.h"

@implementation Content

// Insert code here to add functionality to your managed object subclass

+(NSString *)entityName{
    return @"Content";
}

+(id)insertInManagedObjectContext:(NSManagedObjectContext *)context{
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

+(NSMutableArray *)getAllContentWithContext:(NSManagedObjectContext *)context{
    NSPredicate *predicate;
    predicate =  [NSPredicate predicateWithFormat:@"SELF != NULL"];
    NSMutableArray * array = [Content fetchResultsForPredicate:predicate withSortOrdering:@[] withPropertiesToFetch:nil withLimit:0 withResultType:NSManagedObjectResultType inManagedObjectContext:context];
    return array;
}

+(Content *)getContentWithId:(NSManagedObjectID *)objectId withContext:(NSManagedObjectContext *)context{
    NSPredicate * predicate;
    predicate = [NSPredicate predicateWithFormat:@"self == %@",objectId];
    NSMutableArray * array =[Content fetchResultsForPredicate:predicate withSortOrdering:@[] withPropertiesToFetch:nil withLimit:0 withResultType:NSManagedObjectResultType inManagedObjectContext:context];
    if (array.count > 0) {
        return [array firstObject];
    }
    return nil;
}

@end
