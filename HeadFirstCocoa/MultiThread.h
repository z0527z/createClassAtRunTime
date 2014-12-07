//
//  MultiThread.h
//  HeadFirstCocoa
//
//  Created by dingql on 14-6-23.
//  Copyright (c) 2014年 dingql. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MultiThread : NSObject

- (void)createNSThread;
- (void)createNSThreadLazy;
- (void)createNSThreadUsingNSObjectMethod;
- (void)communicationBetweenThreads;
@end
