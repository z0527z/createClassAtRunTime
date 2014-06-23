//
//  TestViewController.m
//  IOSTest
//
//  Created by dingql on 14-5-9.
//  Copyright (c) 2014年 dingql. All rights reserved.
//

#import "TestViewController.h"
#import "MessageDispatch.h"
#import "AddClassDynamic.h"
#import "KVOTheory.h"
#import "KVOImplementation.h"
#import "NSObject+MethodSwizzlingCategory.h"
#import <objc/runtime.h>


@interface TestViewController ()

@end

@implementation TestViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self testMessageDispatcher];
    //[self testDynamicAddClass];
    //[self testKVC];
    //[self testKVO];
    //[self testKVOImplementation];
    [self testMethodSwizzling];
    

    

}

#pragma - message dispatch
- (void)testMessageDispatcher
{
    Son * son = [[Son alloc]init];
    [(Father *)son play: 1];
}

#pragma - add class dynamic
- (void)testDynamicAddClass
{
    AddClassDynamic * cls = [[AddClassDynamic alloc]init];
    [cls addClassDynamic];
}

#pragma - KVC
- (void)testKVC
{
    Target * target = [[Target alloc]init];
    
    [target setValue:@"dql" forKey:@"_name"];
    NSLog(@"name:%@", [target valueForKey:@"name"]);
}

#pragma - KVO
- (void)testKVO
{

    KVOTheory * observer = [[KVOTheory alloc]init];
    
    Target * target = [[Target alloc]init];
    
    /*
     [target addObserver:observer forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:(__bridge void *)([Target class])];
     [target setAge:30];
     [target setValue:@40 forKey:@"age"];
     [target setValue:@50 forKeyPath:@"_age"];
     [target removeObserver:observer forKeyPath:@"age" context:(__bridge void *)([Target class])];
     */
    
    /*
     [target addObserver:observer forKeyPath:@"height" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:(__bridge void *)([Target class])];
     
     [target setValue:@170 forKey:@"height"];
     [target removeObserver:observer forKeyPath:@"height" context:(__bridge void *)([Target class])];
     */
    
    TargetWrapper * wrapper = [[TargetWrapper alloc]init:target];
    [wrapper addObserver:observer forKeyPath:@"information" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:(__bridge void *)([TargetWrapper class])];
    
    [target setAge:30];
    [target setHeight:170];
    [wrapper removeObserver:observer forKeyPath:@"information" context:(__bridge void *)([TargetWrapper class])];
}

#pragma disable warning
- (void)testKVOImplementation
{
    KVOImplementation * anything = [[KVOImplementation alloc]init];
    
    KVOImplementation * x = [[KVOImplementation alloc]init];
    KVOImplementation * y = [[KVOImplementation alloc]init];
    KVOImplementation * xy = [[KVOImplementation alloc]init];
    
    KVOImplementation * control = [[KVOImplementation alloc]init];
    
    [x addObserver:anything forKeyPath:@"x" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    [y addObserver:anything forKeyPath:@"y" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    [xy addObserver:anything forKeyPath:@"x" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    [xy addObserver:anything forKeyPath:@"y" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    PrintDescription(@"control", control);
    PrintDescription(@"x", x);
    PrintDescription(@"y", y);
    PrintDescription(@"xy", xy);
    
    NSLog(@"\n\tUsing NSObject methods, normal setX: is %p, overridden setX: is %p\n", [control methodForSelector:@selector(setX:)], [x methodForSelector:@selector(setX:)]);
    
    NSLog(@"\n\tUsing libobjc functions, normal setX: is %p, overridden setX: is %p\n",
          method_getImplementation(class_getInstanceMethod(objc_getClass((const char *)(__bridge_retained void *)control), @selector(setX:))),
          method_getImplementation(class_getInstanceMethod(objc_getClass((const char *)(__bridge_retained void *)x), @selector(setX:))));

    [x removeObserver:anything forKeyPath:@"x" context:NULL];
    [y removeObserver:anything forKeyPath:@"y" context:NULL];
    [xy removeObserver:anything forKeyPath:@"x" context:NULL];
    [xy removeObserver:anything forKeyPath:@"y" context:NULL];
}

#pragma - Method Swizzling
- (void)testMethodSwizzling
{
    NSObject * obj = [[NSObject alloc]init];
    
    //[obj testMethod];
    //[obj baseMethod];
    //[obj recursionMethod];
    
    [NSObject swizzleMethod:@selector(testMethod) withMethod:@selector(baseMethod)];
    [obj testMethod];
    
    NSLog(@"--------------- 分割线 --------------");
    [NSObject swizzleMethod:@selector(recursionMethod) withMethod:@selector(testMethod)];
    [obj recursionMethod];
}


#pragma - memory warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end

