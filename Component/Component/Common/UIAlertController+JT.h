//
//  UIAlertController+JT.h
//  budge
//
//  Created by yuqing huang on 13/09/2018.
//  Copyright © 2018 Justek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (JT)
+ (instancetype _Nonnull )jt_alertControllerWithTitle:(NSString *_Nullable)title
                                               message:(NSString *_Nullable)message
                                           actionTitle:(NSString *_Nullable)actionTitle
                                               handler:(void (^ _Nullable)(UIAlertAction * _Nullable action))handler;
+ (instancetype _Nonnull )jt_alertControllerWithTitle:(NSString *_Nullable)title
                                               message:(NSString *_Nullable)message
                                       leftactionTitle:(NSString *_Nullable)leftactionTitle
                                           lefthandler:(void (^ _Nullable)(UIAlertAction * _Nullable action))lefthandler
                                      rightactionTitle:(NSString *_Nullable)rightactionTitle
                                          righthandler:(void (^ _Nullable)(UIAlertAction * _Nullable action))righthandler;

- (void)presentOnTop;
@end
