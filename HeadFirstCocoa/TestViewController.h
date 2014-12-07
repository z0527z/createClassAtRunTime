//
//  TestViewController.h
//  IOSTest
//
//  Created by dingql on 14-5-9.
//  Copyright (c) 2014年 dingql. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController
{
    int _age;
}

- (void)testMessageDispatcher;
- (void)testDynamicAddClass;
- (void)testKVO;
- (void)testKVC;
- (void)testKVOImplementation;
- (void)testMethodSwizzling;
- (void)testMultiThread;

@end