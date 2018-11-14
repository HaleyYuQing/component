//
//  BDRefreshFooter.m
//  budge
//
//  Created by yuqing huang on 21/09/2018.
//  Copyright © 2018 Justek. All rights reserved.
//

#import "BDRefreshFooter.h"
#import "BDActivityCircleIndicatorView.h"

@interface BDRefreshFooter()
@property(nonatomic, strong) BDActivityCircleIndicatorView *indicatorView;
@property(nonatomic, assign) CGSize currentContentSize;
@end

@implementation BDRefreshFooter
- (void)prepare
{
    [super prepare];
    
    self.mj_h = 50.0;
    
    self.indicatorView = [[BDActivityCircleIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.mj_h, self.mj_h)];
    [self addSubview:self.indicatorView];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    self.indicatorView.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.isRefreshing) {
        return;
    }
    
    NSValue *value = change[@"new"];
    CGPoint newPoint;
    [value getValue:&newPoint];
    
    CGFloat timeOffset = 0;
    if (fabs(newPoint.y) < (self.mj_h + self.currentContentSize.height - self.scrollView.frame.size.height)) {
        timeOffset = (fabs(newPoint.y) - (self.currentContentSize.height - self.scrollView.frame.size.height)) / self.mj_h;
    }
    else
        timeOffset = 1;
    [self.indicatorView setTimeOffset:timeOffset];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    NSValue *value = change[@"new"];
    CGSize newSize;
    [value getValue:&newSize];
    self.currentContentSize = newSize;
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.indicatorView endRefreshing];
            break;
        case MJRefreshStatePulling:
            [self.indicatorView endRefreshing];
            break;
        case MJRefreshStateRefreshing:
            [self.indicatorView beginRefreshing];
            break;
        default:
            break;
    }
}
@end
