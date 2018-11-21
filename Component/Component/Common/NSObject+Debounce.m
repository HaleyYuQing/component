//
//  NSObject+Debounce.m
//  budge
//
//  Created by yuqing huang on 21/09/2018.
//  Copyright © 2018 Justek. All rights reserved.
//

#import "NSObject+Debounce.h"

@implementation NSObject (Debounce)

- (void)debounce:(SEL)action delay:(NSTimeInterval)delay
{
    __weak typeof(self) weakSelf = self;
    [NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:action object:nil];
    [weakSelf performSelector:action withObject:nil afterDelay:delay];
}

@end
