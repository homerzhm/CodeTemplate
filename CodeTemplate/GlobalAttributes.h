//
//  GlobalAttributes.h
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-04-13.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//



#ifndef GlobalAttributes_h
#define GlobalAttributes_h

#define IS_IPAD() ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && \
[[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#import <Foundation/Foundation.h>

static NSString * TYPENAME = @"TYPENAME";
static NSString * TYPEVIEWCONTROLLERNAME = @"TYPEVIEWCONTROLLERNAME";

#endif /* GlobalAttributes_h */
