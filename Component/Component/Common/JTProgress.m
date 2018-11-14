//
//  JTProgress.m
//  RaveApp
//
//  Created by Haley on 18/3/14.
//  Copyright (c) 2014 Tracy Xu. All rights reserved.
//

#import "JTProgress.h"

@implementation JTProgress

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:[self viewForBaselineLayout]];
    self.progress = (touchPoint.x - self.frame.origin.x) / self.frame.size.width ;
//    NSLog(@"Touch to rate move: %f", self.progress);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"Touch to rate began, progress height: %f", self.frame.size.height);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:[self viewForBaselineLayout]];
    self.progress = (touchPoint.x - self.frame.origin.x) / self.frame.size.width;
    [self.delegate slideProgress];
//    NSLog(@"Touch to rate end");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
