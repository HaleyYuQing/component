//
//  UINavigationItem+JT.h
//  budge
//
//  Created by yuqing huang on 13/09/2018.
//  Copyright © 2018 Justek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (JT)
- (void)jt_setTitle:(NSString *)title;
- (void)jt_setTitleWithFontAttribute:(NSString *)title fontSize:(NSNumber *)fontSize kerning:(NSNumber *)kerning;
@end
