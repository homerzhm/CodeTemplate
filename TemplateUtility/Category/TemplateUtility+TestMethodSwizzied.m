//
//  TemplateUtility+TestMethodSwizzied.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-06-17.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "TemplateUtility+TestMethodSwizzied.h"
#import <objc/runtime.h>

@implementation TemplateUtility (TestMethodSwizzied)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(returnRouteTable);
        SEL swizzledSelector = @selector(returnRouteTableTest);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        // ...
        // Method originalMethod = class_getClassMethod(class, originalSelector);
        // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

-(NSMutableArray *)returnRouteTableTest{
    NSLog(@"Hzzzz... Get the swizzied method");
    return [self returnRouteTableTest];
}

@end
