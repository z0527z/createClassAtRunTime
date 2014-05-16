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


@interface TestViewController ()

@end

@implementation TestViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
#pragma - message dispatch
//    Son * son = [[Son alloc]init];
//    [(Father *)son play: 1];
    
#pragma - add class dynamic
//    AddClassDynamic * cls = [[AddClassDynamic alloc]init];
//    [cls addClassDynamic];
    
#pragma - KVO
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
    
#pragma - KVC
//    [target setValue:@"dql" forKey:@"_name"];
//    NSLog(@"name:%@", [target valueForKey:@"name"]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end

