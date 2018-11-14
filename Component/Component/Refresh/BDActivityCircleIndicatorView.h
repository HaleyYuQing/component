//
//  BDActivityCircleIndicatorView.h
//  budge
//
//  Created by yuqing huang on 21/09/2018.
//  Copyright © 2018 Justek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDActivityCircleIndicatorView : UIView
/**
 *  circle color
 */
@property (nonatomic, copy) UIColor *tintColor;

/**
 *  circle offset
 */
@property (nonatomic, assign) CGFloat timeOffset;  // 0.0 ~ 1.0

- (void)beginRefreshing;
- (void)endRefreshing;
@end
