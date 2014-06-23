//
//  KVOImplementation.m
//  IOSTest
//
//  Created by dingql on 14-5-23.
//  Copyright (c) 2014年 dingql. All rights reserved.
//

#import "KVOImplementation.h"
#import <objc/runtime.h>

@implementation KVOImplementation

static NSArray * ClassMethodNames(Class c)
{
    NSMutableArray * array = [NSMutableArray array];
    unsigned int methodCount = 0;
    Method * methodList = class_copyMethodList(c, &methodCount);
    unsigned int i;
    for (i = 0; i < methodCount; i ++) {
        [array addObject:NSStringFromSelector(method_getName(methodList[i]))];
    }
    
    free(methodList);
    
    return array;
}

void PrintDescription(NSString * name, id obj)
{
    NSString * str = [NSString stringWithFormat:@"\n\t%@: %@\n\tNSObject class %s\n\tlibobjc class %s\n\timplements methods <%@>",
                      name, obj, class_getName([obj class]), class_getName(object_getClass(obj)), [ClassMethodNames(object_getClass(obj)) componentsJoinedByString:@","]];
    
    NSLog(@"%@", str);
}


@end
