//
//  NSObject+MethodSwizzlingCategory.m
//  IOSTest
//
//  Created by dingql on 14-5-26.
//  Copyright (c) 2014年 dingql. All rights reserved.
//

#import "NSObject+MethodSwizzlingCategory.h"


@implementation NSObject (MethodSwizzlingCategory)

+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)altSel
{
    Method origMethod = class_getInstanceMethod(self, origSel);
    if (!origSel) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(origSel), [self class]);
        return NO;
    }
    
    Method altMethod = class_getInstanceMethod(self, altSel);
    if (!altMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(altSel), [self class]);
        return NO;
    }
    
    //class_addMethod(self, origSel, class_getMethodImplementation(self, origSel), method_getTypeEncoding(origMethod));
    //class_addMethod(self, altSel, class_getMethodImplementation(self, altSel), method_getTypeEncoding(altMethod));
    method_exchangeImplementations(origMethod, altMethod);
    
    return YES;
    
}

+ (BOOL)swizzleClassMethod:(SEL)origSel withClassMethod:(SEL)altSel
{
    Class c = objc_getClass((__bridge void *)self);
    return [c swizzleClassMethod:origSel withClassMethod:altSel];
}


- (void)testMethod
{
    NSLog(@"testMethod ------->");
}

- (void)baseMethod
{
    NSLog(@"baseMethod -------->");
}

- (void)recursionMethod
{
    NSLog(@"recursionMethod --------->");
    [self recursionMethod];
}


@end
