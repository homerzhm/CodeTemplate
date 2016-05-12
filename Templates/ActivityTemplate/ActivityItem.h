//
//  ActivityItem.h
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-04-13.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ActivityItem : NSObject <UIActivityItemSource>

@property (nonatomic) NSString * message;

-(id)initWithMessage:(NSString *)message;

@end
