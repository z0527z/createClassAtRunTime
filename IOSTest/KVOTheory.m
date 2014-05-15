//
//  KVOTheory.m
//  IOSTest
//
//  Created by dingql on 14-5-13.
//  Copyright (c) 2014年 dingql. All rights reserved.
//

#import "KVOTheory.h"
#import <objc/runtime.h>

@implementation KVOTheory

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"age"]) {
        Class classInfo = (__bridge Class)context;
        NSString * className = [NSString stringWithCString:object_getClassName(classInfo) encoding:NSUTF8StringEncoding];
        NSLog(@"class:%@, age changed", className);
        
        NSLog(@"old:%@, new:%@", [change objectForKey:@"old"], [change objectForKey:@"new"]);
    }
    else if ([keyPath isEqualToString:@"height"]){
        NSLog(@"old:%@, new:%@", [change objectForKey:@"old"], [change objectForKey:@"new"]);
    }
    else if ([keyPath isEqualToString:@"information"]){
        Class classInfo = (__bridge Class)context;
        NSString * className = [NSString stringWithCString:object_getClassName(classInfo) encoding:NSUTF8StringEncoding];
        NSLog(@"class:%@, Information changed", className);
        
        NSLog(@"old:%@, new:%@", [change objectForKey:@"old"], [change objectForKey:@"new"]);
    }
    else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
    
}

@end

#pragma - Target
@implementation Target


- (int)age{
    return _age;
}

- (void)setAge:(int)age{
    [self willChangeValueForKey:@"age"];
    _age = age;
    [self didChangeValueForKey:@"age"];
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    if ([key isEqualToString:@"age"]) {
        return NO;
    }
    
    return [super automaticallyNotifiesObserversForKey:key];
}

@end

#pragma - TargetWrapper
@implementation TargetWrapper

- (id)init:(Target *)target{
    if (self = [super init]) {
        _target = target;
    }
    
    return self;
}

- (NSString *)information{
    return [[NSString alloc]initWithFormat:@"%d,%d", [_target age], [_target height]];
}

- (void)setInformation:(NSString *)information{
    NSArray * array = [information componentsSeparatedByString:@","];
    [_target setAge:[[array objectAtIndex:0] intValue]];
    [_target setHeight:[[array objectAtIndex:1] intValue]];
}

// 以下两个方法效果一样
+ (NSSet *)keyPathsForValuesAffectingInformation{
    NSSet * keyPaths = [NSSet setWithObjects:@"target.age", @"target.height", nil];
    return keyPaths;
}

/* metho 2 along with [setInformation:]
+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key{
    NSSet * keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    NSArray * moreKeyPaths = nil;
    
    if ([key isEqualToString:@"information"]) {
        moreKeyPaths = [NSArray arrayWithObjects:@"target.age", @"target.height", nil];
    }
    
    if (moreKeyPaths) {
        keyPaths = [keyPaths setByAddingObjectsFromArray:moreKeyPaths];
    }
    
    return keyPaths;
}
*/

- (void)dealloc{
    _target = nil;
}

@end
