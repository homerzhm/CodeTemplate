//
//  TemplateUtility.h
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-04-13.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TemplateUtility : NSObject

+(TemplateUtility *)shareInstance;

-(NSMutableArray *)returnRouteTable;

@end
