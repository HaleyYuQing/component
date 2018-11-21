//
//  UIImage+JT.m
//  ufo
//
//  Created by yuqing huang on 27/05/2017.
//  Copyright © 2017 uFO. All rights reserved.
//

#import "UIImage+JT.h"

@implementation UIImage(jt)

+ (UIImage *)buttonBackgroundImageWithColor:(UIColor*)color cornerRadio:(CGFloat)radio
{
    UIImage *img = nil;
    CGRect rect = radio>1?CGRectMake(0, 0, radio*2, radio*2):CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextSaveGState(ctx);
    if (radio>1)
        CGContextFillEllipseInRect(ctx, rect);
    else
        CGContextFillRect(ctx, rect);
    
    CGContextRestoreGState(ctx);
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return radio>1? [img resizableImageWithCapInsets:UIEdgeInsetsMake(radio, radio, radio, radio)]:img;
}

@end
