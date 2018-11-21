//
//  UIViewController+JT.h
//  budge
//
//  Created by yuqing huang on 20/09/2018.
//  Copyright © 2018 Justek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDPopupTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>

@end

@interface UIViewController(JT)
- (void)jt_setPresentAsPopup:(BOOL)presentAsPopup;
@end
