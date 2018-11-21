//
//  UIAlertController+JT.m
//  budge
//
//  Created by yuqing huang on 13/09/2018.
//  Copyright © 2018 Justek. All rights reserved.
//

#import "UIAlertController+JT.h"

@implementation UIAlertController (JT)
+ (instancetype _Nonnull)jt_alertControllerWithTitle:(NSString * _Nullable)title
                                              message:(NSString * _Nullable)message
                                          actionTitle:(NSString * _Nullable)actionTitle
                                              handler:(void (^ _Nullable)(UIAlertAction * _Nullable action))handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:actionTitle
                                                       style:UIAlertActionStyleDefault
                                                     handler:handler];
    [alert addAction:okAction];
    
    return alert;
}

+ (instancetype _Nonnull )jt_alertControllerWithTitle:(NSString *_Nullable)title
                                               message:(NSString *_Nullable)message
                                       leftactionTitle:(NSString *_Nullable)leftactionTitle
                                           lefthandler:(void (^ _Nullable)(UIAlertAction * _Nullable action))lefthandler
                                      rightactionTitle:(NSString *_Nullable)rightactionTitle
                                          righthandler:(void (^ _Nullable)(UIAlertAction * _Nullable action))righthandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:leftactionTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:lefthandler];
    [alert addAction:leftAction];
    
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:rightactionTitle
                                                          style:UIAlertActionStyleDefault
                                                        handler:righthandler];
    [alert addAction:rightAction];
    
    return alert;
}

- (void)presentOnTop {
    UIViewController *controller = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    UIViewController *targetController = controller;
    while ((controller = controller.presentedViewController)) {
        targetController = controller;
    }
    [targetController presentViewController:self
                                   animated:YES
                                 completion:nil];
}

@end
