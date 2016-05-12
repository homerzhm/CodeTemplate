//
//  ActivityItem.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-04-13.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "ActivityItem.h"

@implementation ActivityItem

-(id)initWithMessage:(NSString *)message{
    self = [super init];
    if (self) {
        self.message = message;
    }
    return self;
}

// called to determine data type. only the class of the return type is consulted. it should match what -itemForActivityType: returns later
- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController{
    return self.message;
}

// called to fetch data after an activity is selected. you can return nil.
- (nullable id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType{
    NSString * result = [NSString stringWithString:self.message];
    
    return result;
}

- (NSString *)activityViewController:(UIActivityViewController *)activityViewController subjectForActivityType:(NSString *)activityType{
    NSString * result = @"Shared via Hongming Zuo";
    
    return result;
}

@end
