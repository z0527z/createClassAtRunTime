//
//  MessageDispatch.m
//  IOSTest
//
//  Created by dingql on 14-5-9.
//  Copyright (c) 2014年 dingql. All rights reserved.
//

#import "MessageDispatch.h"
#import <objc/runtime.h>

@implementation MessageDispatch

@end

// Father
@implementation Father

- (void)play:(int)age {
    NSLog(@"%@ is playing age:%d", [super class], age);
}

@end

// Son
@implementation Son
// 动态决议
void dynamicIMP(id self, SEL _cmd, int age){
    NSLog(@"dynamicIMP playing age:%d", age);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    
    NSLog(@"%@ resolve", NSStringFromSelector(sel));
    
    if (sel == @selector(play:)) {
        //class_addMethod(self, sel, (IMP)dynamicIMP, "age");
    }
    
    return  NO;
}
// 快速转发
- (id)forwardingTargetForSelector:(SEL)aSelector{
    
    NSLog(@"forwardingTargetForSelector");
    
    //Father * father = [[Father alloc]init];
    //return father;
    return nil;
}

// 标准转发
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL name = [anInvocation selector];
    NSLog(@"forwardInvocation--> [%@]", NSStringFromSelector(name));
    
    Father * father = [[Father alloc]init];
    if ([father respondsToSelector:name]) {
        [anInvocation invokeWithTarget:father];
    }
    else {
        [super forwardInvocation:anInvocation];
    }
    
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSLog(@"methodSignatureForSelector");
    return [Father instanceMethodSignatureForSelector:aSelector];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector{
    NSLog(@"doesNotRecognizeSelector--> [%@]", NSStringFromSelector(aSelector));
}

@end
