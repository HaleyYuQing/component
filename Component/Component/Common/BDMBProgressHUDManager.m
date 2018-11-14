//
//  BDMBProgressHUDManager.m
//  budge
//
//  Created by yuqing huang on 25/09/2018.
//  Copyright © 2018 Justek. All rights reserved.
//

#import "BDMBProgressHUDManager.h"
#import "MBProgressHUD.h"

const NSTimeInterval kHideHUDInteval = 3.0;

@interface BDMBProgressHUDManager ()<MBProgressHUDDelegate>

@end

@implementation BDMBProgressHUDManager

+ (BDMBProgressHUDManager *)sharedInstance
{
    static BDMBProgressHUDManager *_instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[BDMBProgressHUDManager alloc] init];
    });
    
    return _instance;
}

-(void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message
{
    MBProgressHUD *HUD = nil;
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (window)
    {
        HUD = [[MBProgressHUD alloc] initWithWindow:window];
        [window addSubview:HUD];
    }
    HUD.mode = MBProgressHUDModeText;
    HUD.delegate = self;
    if (title)
    {
        HUD.labelText = title;
    }
    HUD.detailsLabelText = message;
    
    [HUD show:YES];

    [HUD hide:YES afterDelay:kHideHUDInteval];
}

@end
