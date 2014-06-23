//
//  AddClassDynamic.m
//  IOSTest
//
//  Created by dingql on 14-5-13.
//  Copyright (c) 2014年 dingql. All rights reserved.
//

#import "AddClassDynamic.h"
#import <objc/objc.h>
#import <objc/runtime.h>

@implementation AddClassDynamic

void ReportFunction(id self, SEL _cmd)
{
    NSLog(@"Class:<%@, %p> super:<%@>", [self class], self, [self superclass]);
    
    Class prevClass = NULL;
    int count = 1;
    for (Class currentClass = [self class]; currentClass; ++count)
    {
        prevClass = currentClass;
        
        currentClass = object_getClass(currentClass);
        NSLog(@" >> Following the isa pointer %d times gives %@, prevClass:%@", count, [currentClass class], [prevClass class]);
        if (prevClass == currentClass)
            break;
    }
    
    NSLog(@" >> NSObject's class is %p", [NSObject class]);
    NSLog(@" >> NSObject's meta class is %p", object_getClass([NSObject class]));
}

#pragma - method 1
NSString *nameGetter(id self, SEL _cmd) {
    Ivar ivar = class_getInstanceVariable([self class], "_privateName");
    return object_getIvar(self, ivar);
}

void nameSetter(id self, SEL _cmd, NSString *newName) {
    Class cls = [self class];
    Ivar ivar = class_getInstanceVariable(cls, "_privateName");
    id oldName = object_getIvar(self, ivar);
    if (oldName != newName) object_setIvar(self, ivar, [newName copy]);
}

#pragma - method 3 关联--> 不用修改类的定义而为其对象增加存储空间, 不适用于运行时创建的类
static const char * const genderKey;
@dynamic gender;
- (id)gender{
    
    return objc_getAssociatedObject(self, genderKey);
}

- (void)setGender:(NSString *)gender{
    objc_setAssociatedObject(self, genderKey, gender, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma - method 2
- (id)valueForUndefinedKey:(NSString *)key{
    
    return @"undefined";
}

- (void)addClassDynamic{
    // 运行时创建类，添加变量，方法
    objc_property_attribute_t type = { "T", "@\"NSString\"" };
    objc_property_attribute_t ownership = { "C", "copy" }; // C = copy
    objc_property_attribute_t backingivar  = { "V", "_privateName" };
    objc_property_attribute_t attrs[] = { type, ownership, backingivar};
    Class newClass = objc_allocateClassPair([NSString class], "NSStringSubclass", 0);
    class_addIvar(newClass, "_privateName", sizeof(id), log2(sizeof(id)), "---");
    class_addIvar(newClass, "_gender", sizeof(id), log2(sizeof(id)), "--->");
    class_addProperty(newClass, "name", attrs, 3);
    class_addMethod(newClass, @selector(report), (IMP)ReportFunction, "v@:");
    class_addMethod(newClass, @selector(GetMyName), (IMP)nameGetter, "nameGetter");
    class_addMethod(newClass, @selector(setMyName:), (IMP)nameSetter, "nameSetter");
    
    objc_registerClassPair(newClass);
    
    id inst = [[newClass alloc] init];
    [inst performSelector:@selector(report)];
    [inst performSelector:@selector(setMyName:) withObject:@"dql"];
	NSString * name = [inst performSelector:@selector(GetMyName)];
    NSLog(@"name:%@", name);
    
//    NSString * str = [inst valueForKey:@"gender"];
//    NSLog(@"str:%@", str);
//
//    [inst setGender:@"F"];
//    NSLog(@"gender:%@", (NSString *)[inst gender]);
}

@end
