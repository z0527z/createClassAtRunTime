//
//  NSObject+MethodSwizzlingCategory.h
//  IOSTest
//
//  Created by dingql on 14-5-26.
//  Copyright (c) 2014年 dingql. All rights reserved.
//

#if TARGET_OS_IPHONE
#import <objc/runtime.h>
#import <objc/message.h>
#else
#import <objc/objc-class.h>
#endif

@interface NSObject (MethodSwizzlingCategory)

+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)altSel;

+ (BOOL)swizzleClassMethod:(SEL)origSel withClassMethod:(SEL)altSel;

// method swizzling
- (void)testMethod;
- (void)baseMethod;
- (void)recursionMethod;

@end
