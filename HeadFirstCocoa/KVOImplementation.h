//
//  KVOImplementation.h
//  IOSTest
//
//  Created by dingql on 14-5-23.
//  Copyright (c) 2014年 dingql. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVOImplementation : NSObject

@property(nonatomic, assign)int x;
@property(nonatomic, assign)int y;
@property(nonatomic, assign)int z;

void PrintDescription(NSString * name, id obj);

@end
