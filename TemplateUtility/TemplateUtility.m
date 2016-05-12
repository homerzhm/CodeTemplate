//
//  TemplateUtility.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-04-13.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "TemplateUtility.h"

@implementation TemplateUtility

static TemplateUtility *instances = nil;

+(TemplateUtility *)shareInstance{
    @synchronized(self){
        if (instances == nil) {
            instances = [[self alloc]init];
        }
    }
    return instances;
}

-(NSMutableArray *)returnRouteTable{
    NSMutableArray * result = [[NSMutableArray alloc]init];
    
    
    [result addObject:[self returnRouteTableDicWithName:@"Activity Share" withControllerName:@"ActivityTemplateController"]];
    [result addObject:[self returnRouteTableDicWithName:@"UI Components" withControllerName:@"ComponentsTemplateController"]];
    [result addObject:[self returnRouteTableDicWithName:@"Key board Input" withControllerName:@"KeyboardInputViewController"]];

    return result;
}

-(NSDictionary *)returnRouteTableDicWithName:(NSString *)name withControllerName:(NSString *)cName{
    NSDictionary * dic = @{TYPENAME:name,TYPEVIEWCONTROLLERNAME:cName};
    return dic;
}

@end
