//
//  BDMBProgressHUDManager.h
//  budge
//
//  Created by yuqing huang on 25/09/2018.
//  Copyright © 2018 Justek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDMBProgressHUDManager : NSObject

+ (BDMBProgressHUDManager *)sharedInstance;

-(void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message;

@end
