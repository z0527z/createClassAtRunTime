//
//  MultiThread.m
//  HeadFirstCocoa
//
//  Created by dingql on 14-6-23.
//  Copyright (c) 2014年 dingql. All rights reserved.
//

#import "MultiThread.h"

@implementation MultiThread

/*-----------------------------------------------------------------------------------*
 * Thread: 需要自己管理thread的生命周期，线程之间的同步。线程共享同一应用程序的部分内存空间,
 *          它们拥有对数据相同的访问权限，需要自己协调对同一数据的访问。cocoa threads:使用
 *          NSThread或直接从NSObject的类方法 performSelectorInBackground:withObject:
 *          来创建一个线程。
 *
 * POSIX threads: 基于C语言的一个多线程库
 *
 * cocoa operations: 基于objective-c实现，类NSOperation以面向对象的方式封装了用户需要执行
 *                      的操作, NSOperation是一个抽象基类，必须使用它的子类。IOS提供了两种
 *                      默认的实现:NSInvocationOperation 和 NSBlockOperation
 *
 * Grand Central Dispatch:它的关注点:如何在多个CPU上提升效率
 *
 * IOS的原子操作:OSAtomicAdd32, OSAtomicOr32等等
 *
 * IOS中的mutex对应的是:NSLock, 它遵循NSLocking协议, 可以使用lock, tryLock, lockBeforeData
 *                      来加锁, 用unlock解锁, @synchronized简化 NSLock使用
 *
 * NSCodition:一种特殊类型的锁, 可以用它来同步操作执行的顺序
 *-------------------------------------------------------------------------------------*/

- (void)myThreadMainMethod:(NSString *)methodName
{
    NSLog(@"methodName:%@", methodName);
    
}

- (void)createNSThread
{
    [NSThread detachNewThreadSelector:@selector(myThreadMainMethod:) toTarget:self withObject:@"createNSThread"];
}

- (void)createNSThreadLazy
{
    NSThread * myThread = [[NSThread alloc]initWithTarget:self selector:@selector(myThreadMainMethod:) object:@"createNSThreadLazy"];
    myThread.stackSize = 1024;
    sleep(1.0f);
    [myThread start];
}

- (void)createNSThreadUsingNSObjectMethod
{
    // 效果与第一种方法类似
    [self performSelectorInBackground:@selector(myThreadMainMethod:) withObject:NSStringFromSelector(_cmd)];
}

- (void)communicationBetweenThreads
{
    [self performSelectorOnMainThread:@selector(myThreadMainMethod:) withObject:NSStringFromSelector(_cmd) waitUntilDone:NO];
    NSLog(@"------>");
    
}

@end
