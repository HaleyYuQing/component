//
//  Money.h
//  ufo
//
//  Created by Kenji Pa on 29/3/2016.
//  Copyright © 2016 oursky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Money : NSObject <NSSecureCoding>

@property (nonatomic, readonly) long long amount;
@property (nonatomic, strong, readonly) NSString *currencyCode;

@property (atomic, readonly) NSDecimalNumber *decimalAmount;
@property (atomic, readonly) NSString *string;
@property (atomic, readonly) NSString *formalString;


- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)moneyWithAmount:(long long)amount
                   currencyCode:(NSString *)currencyCode;

- (instancetype)moneyWithAmount:(long long)amount;
- (instancetype)moneyByAddingMoney:(Money *)money;
- (instancetype)moneyByMinusMoney:(Money *)money;
- (instancetype)moneyMultipliedByCount:(NSUInteger)count;
- (instancetype)moneyWithMultiplier:(long)multiplier;

- (BOOL)isEqualToMoney:(Money *)money;
- (BOOL)isZero;

@end
