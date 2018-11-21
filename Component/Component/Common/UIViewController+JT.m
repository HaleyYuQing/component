//
//  UIViewController+JT.m
//  budge
//
//  Created by yuqing huang on 20/09/2018.
//  Copyright © 2018 Justek. All rights reserved.
//

#import "UIViewController+JT.h"
#import <objc/runtime.h>

@interface JTDimmingPresentationController : UIPresentationController
@property (nonatomic, strong) UIView *dimmingView;
@end

@implementation JTDimmingPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController {
    self = [super initWithPresentedViewController:presentedViewController
                         presentingViewController:presentingViewController];
    if (self) {
        _dimmingView = [[UIView alloc] init];
        _dimmingView.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)presentationTransitionWillBegin {
    _dimmingView.frame = self.containerView.frame;
    [self.containerView addSubview:_dimmingView];
    
    id <UIViewControllerTransitionCoordinator> transitionCoordinator = [[self presentingViewController] transitionCoordinator];
    
    _dimmingView.alpha = 0;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        _dimmingView.alpha = 0.5;
    } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [_dimmingView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    id <UIViewControllerTransitionCoordinator> transitionCoordinator = [[self presentedViewController] transitionCoordinator];
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        _dimmingView.alpha = 0;
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [_dimmingView removeFromSuperview];
    }
}

@end

@interface BDPopupTransitionDelegate ()  <UIViewControllerAnimatedTransitioning>

// used to implement UIViewControllerAnimatedTransitioning
@property (nonatomic, assign) BOOL isPresenting;

@end

@implementation BDPopupTransitionDelegate

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    self.isPresenting = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresenting = NO;
    return self;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[JTDimmingPresentationController alloc] initWithPresentedViewController:presented
                                                            presentingViewController:presenting];
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    if (self.isPresenting) {
        CGRect frame = toView.frame;
        frame.origin = CGPointMake(0, frame.size.height);
        toView.frame = frame;
        
        CGRect endFrame = frame;
        endFrame.origin = CGPointZero;
        
        [container addSubview:toView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0
             usingSpringWithDamping:0.7
              initialSpringVelocity:0
                            options:0
                         animations:^{
                             toView.frame = endFrame;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    } else {
        CGRect endFrame = fromView.frame;
        endFrame.origin = CGPointMake(0, endFrame.size.height);
        
        [container insertSubview:toView atIndex:0];
        
        [UIView animateWithDuration:0.4
                         animations:^{
                             fromView.frame = endFrame;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8;
}

@end

static void *BDPopupTransitionDelegateKey;

@implementation UIViewController(JT)

- (void)jt_setPresentAsPopup:(BOOL)presentAsPopup {
    if (presentAsPopup) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        
        BDPopupTransitionDelegate *delegate = [[BDPopupTransitionDelegate alloc] init];
        self.transitioningDelegate = delegate;
        
        objc_setAssociatedObject(self, BDPopupTransitionDelegateKey, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } else {
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        objc_setAssociatedObject(self, BDPopupTransitionDelegateKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)setTabbarTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                             image:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                                                     selectedImage:[[UIImage imageNamed:selectedImageName]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate ]];
    [tabBarItem setImageInsets:UIEdgeInsetsMake(3, 0, -3, 0)];
    [tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    [self setTabBarItem:tabBarItem];
}
@end
