//
//  BDActivityCircleIndicatorView.m
//  budge
//
//  Created by yuqing huang on 21/09/2018.
//  Copyright © 2018 Justek. All rights reserved.
//

#import "BDActivityCircleIndicatorView.h"
#import "UIColor+JT.h"

static NSString* const kRotationAnimation = @"RotationAnimation";

@interface BDActivityCircleIndicatorView()<CAAnimationDelegate>
@property (nonatomic, strong) CALayer *standbyLayer;
@property (nonatomic, strong) CALayer *animationLayer;

@property (nonatomic, strong) NSMutableArray *standbyLayersArray;
@property (nonatomic, strong) NSMutableArray *animationLayerArray;

@property (nonatomic, assign) BOOL isRotating;
@end

@implementation BDActivityCircleIndicatorView

- (void)setup {
    self.standbyLayersArray = [[NSMutableArray alloc] init];
    self.animationLayerArray = [[NSMutableArray alloc] init];
    
    self.isRotating = NO;
    
    self.standbyLayer = [[CALayer alloc] init];
    self.standbyLayer.frame = CGRectMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5, 1, 3);
    self.standbyLayer.anchorPoint = CGPointMake(0, 0.0);
    [self.layer addSublayer:self.standbyLayer];
    
    self.animationLayer = [[CALayer alloc] init];
    self.animationLayer.frame = CGRectMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5, 1, 3);
    self.animationLayer.anchorPoint = CGPointMake(0, 0.0);
    [self.layer addSublayer:self.animationLayer];
    
    self.tintColor = [UIColor colorWithHex:@"666666"];
    
    [self createAnimationLayers];
    [self createStandbyLayers];
    
    self.animationLayer.hidden = YES;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    self.tintColor = nil;
    
    self.standbyLayer = nil;
    
    self.animationLayer = nil;
    
    self.standbyLayersArray = nil;
    
    self.animationLayerArray = nil;
}

#pragma mark - Public methods

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    
    for (CALayer *layer in self.standbyLayersArray) {
        layer.backgroundColor = tintColor.CGColor;
    }
    
    for (CALayer *layer in self.animationLayerArray) {
        layer.backgroundColor = tintColor.CGColor;
    }
}

- (void)setTimeOffset:(CGFloat)timeOffset {
    _timeOffset = timeOffset;
    
    if (self.isRotating) {
        return;
    }
    
    CGFloat showingOffset = timeOffset * 12.0 - 1;
    
    if (showingOffset < 0) {
        return;
    }
    
    for (int i = 0; i < 12; i ++) {
        CALayer *layer = self.standbyLayersArray[i];
        if (i <= showingOffset) {
            layer.hidden = NO;
        } else {
            layer.hidden = YES;
        }
    }
}

- (void)beginRefreshing {
    self.isRotating = YES;
    [self.standbyLayer addAnimation:[self createRotationAnimation] forKey:kRotationAnimation];
    [self addOpacityAnimationForAnimationLayers];
}

- (void)addOpacityAnimationForAnimationLayers {
    [self.animationLayerArray enumerateObjectsUsingBlock:^(CALayer *animationLayer, NSUInteger idx, BOOL *stop) {
        CAAnimation *animation = [self createOpacityAnimationWithIndex:idx];
        [animationLayer addAnimation:animation forKey:[NSString stringWithFormat:@"key %lu", (unsigned long)idx]];
    }];
}

- (void)removeOpacityAnimationForAnimationLayers {
    [self.animationLayerArray enumerateObjectsUsingBlock:^(CALayer *animationLayer, NSUInteger idx, BOOL *stop) {
        [animationLayer removeAnimationForKey:[NSString stringWithFormat:@"key %lu", (unsigned long)idx]];
    }];
}

- (void)endRefreshing {
    [self removeOpacityAnimationForAnimationLayers];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.animationLayer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
        self.animationLayer.opacity = 0.8f;
    } completion:^(BOOL finished) {
        self.animationLayer.transform = CATransform3DIdentity;
        self.animationLayer.opacity = 1.0f;
        self.animationLayer.hidden = YES;
        self.standbyLayer.hidden = NO;
        self.timeOffset = 0.0;
    }];
}

#pragma mark - Private methods

- (void)createStandbyLayers {
    for (int i = 0; i < 12; i ++) {
        CALayer *layer = [self createLayer];
        
        layer.transform = CATransform3DMakeRotation(M_PI / 6 * i, 0, 0, 1);
        
        layer.hidden = YES;
        
        [self.standbyLayer addSublayer:layer];
        [self.standbyLayersArray addObject:layer];
    }
}

- (void)createAnimationLayers {
    for (int i = 0; i < 12; i ++) {
        CALayer *layer = [self createLayer];
        
        layer.transform = CATransform3DMakeRotation(M_PI / 6 * i, 0, 0, 1);
        
        [self.animationLayer addSublayer:layer];
        
        [self.animationLayerArray addObject:layer];
    }
}

- (CALayer *)createLayer {
    CALayer *rectLayer = [[CALayer alloc] init];
    rectLayer.backgroundColor = self.tintColor.CGColor;
    rectLayer.frame = CGRectMake(- 1, - 3, 2, 7.3);
    rectLayer.anchorPoint = CGPointMake(0.5, 1.8);
    rectLayer.allowsEdgeAntialiasing = YES;
    rectLayer.cornerRadius = 1.0f;
    
    return rectLayer;
}

- (CAAnimation *)createOpacityAnimationWithIndex:(NSInteger)index {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0];
    opacityAnimation.duration = 1.0f;
    opacityAnimation.repeatCount = NSIntegerMax;
    opacityAnimation.speed = 1.0f;
    opacityAnimation.timeOffset = 1.0f - index/12.0f;
    
    return opacityAnimation;
}

- (CAAnimation *)createRotationAnimation {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI_2];
    rotationAnimation.duration = 0.5f;
    rotationAnimation.repeatCount = 1;
    rotationAnimation.speed = 1.0f;
    rotationAnimation.delegate = self;
    rotationAnimation.removedOnCompletion = YES;
    
    return rotationAnimation;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if(!self.isRotating)
        return;
    
    self.isRotating = NO;
    
    self.standbyLayer.hidden = YES;
    self.animationLayer.hidden = NO;
}

@end
