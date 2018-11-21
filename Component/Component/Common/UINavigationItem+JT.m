//
//  UINavigationItem+JT.m
//  budge
//
//  Created by yuqing huang on 13/09/2018.
//  Copyright © 2018 Justek. All rights reserved.
//

#import "UINavigationItem+JT.h"

@implementation UINavigationItem (JT)
- (void)jt_setTitle:(NSString *)title {
    [self jt_setTitleWithFontAttribute:title fontSize:@16 kerning:@3.0];
}

- (void)jt_setTitleWithFontAttribute:(NSString *)title fontSize:(NSNumber *)fontSize kerning:(NSNumber *)kerning {
    NSDictionary *attributes = @{
                                 NSKernAttributeName: kerning,
                                 NSFontAttributeName: [UIFont systemFontOfSize:[fontSize floatValue]],
                                 NSForegroundColorAttributeName: [UIColor whiteColor],
                                 };
    NSAttributedString *s = [[NSAttributedString alloc] initWithString:[title uppercaseString]
                                                            attributes:attributes];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setAttributedText:s];
    [titleLabel sizeToFit];
    
    [self setTitleView:titleLabel];
}
@end
