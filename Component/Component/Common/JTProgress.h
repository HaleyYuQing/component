//
//  JTProgress.h
//  RaveApp
//
//  Created by Haley on 18/3/14.
//  Copyright (c) 2014 Tracy Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JTProgressChanagedDelegate

- (void)slideProgress;

@end

//slide progress
@interface JTProgress : UIProgressView
@property (nonatomic) NSObject <JTProgressChanagedDelegate> *delegate;

@end
