//
//  NSObject+Debounce.h
//  budge
//
//  Created by yuqing huang on 21/09/2018.
//  Copyright © 2018 Justek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Debounce)
- (void)debounce:(SEL)action delay:(NSTimeInterval)delay;

@end
