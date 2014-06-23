//
//  KVOTheory.h
//  IOSTest
//
//  Created by dingql on 14-5-13.
//  Copyright (c) 2014年 dingql. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVOTheory : NSObject

@end

#pragma - Target
@interface Target : NSObject <NSCopying>
{
    
@private
    int _age;
    NSString * _name;
}

// for manual KVO - age
- (int)age;

- (void)setAge:(int)age;

@property(nonatomic, assign) int height; // for auto KVO

@end // Target

#pragma - TargetWrapper
@interface TargetWrapper : NSObject
{
@private
    Target * _target;
}

- (id)init:(Target *)target;

@property(nonatomic, copy)NSString * information;

@end // TargetWrapper
