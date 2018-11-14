//
//  Money.m
//  ufo
//
//  Created by Kenji Pa on 29/3/2016.
//  Copyright © 2016 oursky. All rights reserved.
//

#import "Money.h"

@interface Money ()

- (instancetype)initWithAmount:(long long)amount
                  currencyCode:(NSString *)currencyCode NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)decoder NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly) NSUInteger minorUnit;

@end

@implementation Money

- (instancetype)initWithAmount:(long long)amount
                  currencyCode:(NSString *)currencyCode {
    self = [super init];
    if (self) {
        _amount = amount;
        _currencyCode = [currencyCode copy];
    }
    return self;
}

+ (instancetype)moneyWithAmount:(long long)amount
                   currencyCode:(NSString *)currencyCode {
    return [[self alloc] initWithAmount:amount currencyCode:currencyCode];
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }

    if (![object isKindOfClass:[Money class]]) {
        return NO;
    }

    return [self isEqualToMoney:(Money *)object];
}

- (NSUInteger)hash {
    return ((NSUInteger)self.amount/100)^self.currencyCode.hash;
}

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        _amount = [decoder decodeInt64ForKey:@"amount"];
        _currencyCode = [decoder decodeObjectOfClass:[NSString class] forKey:@"currencyCode"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt64:_amount forKey:@"amount"];
    [encoder encodeObject:_currencyCode forKey:@"currencyCode"];
}

#pragma mark -

- (BOOL)isEqualToMoney:(Money *)that {
    if (!that) {
        return NO;
    }

    return _amount == that->_amount && [_currencyCode isEqualToString:that->_currencyCode];
}

- (BOOL)isZero {
    return self.amount == 0;
}

- (instancetype)moneyWithAmount:(long long)amount {
    return [self.class moneyWithAmount:amount currencyCode:self.currencyCode];
}

- (instancetype)moneyByAddingMoney:(Money *)money {
    return [self.class moneyWithAmount:self.amount+money.amount currencyCode:self.currencyCode];
}

- (instancetype)moneyByMinusMoney:(Money *)money {
    return [self.class moneyWithAmount:self.amount-money.amount currencyCode:self.currencyCode];
}

- (instancetype)moneyMultipliedByCount:(NSUInteger)count {
    return [self.class moneyWithAmount:self.amount*count currencyCode:self.currencyCode];
}

- (instancetype)moneyWithMultiplier:(long)multiplier {
    long long amount = self.amount;
    amount = amount*multiplier;
    return [Money moneyWithAmount:amount currencyCode:self.currencyCode];
}

- (NSDecimalNumber *)decimalAmount {
    NSString *currencyCode = self.currencyCode;
    NSUInteger minorUnit = self.minorUnit;

    NSNumberFormatter * currencyFormatter = [[NSNumberFormatter alloc] init];
    currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    currencyFormatter.currencyCode = currencyCode;
    currencyFormatter.roundingMode = NSNumberFormatterRoundCeiling;
    currencyFormatter.maximumFractionDigits = minorUnit;
    currencyFormatter.currencySymbol = @"";
    currencyFormatter.internationalCurrencySymbol = @"";

    double amount = self.amount / pow(10, minorUnit);
    return [NSDecimalNumber decimalNumberWithString:[currencyFormatter stringFromNumber:@(amount)]];
}

- (NSString *)string {
    return [self stringSimplified:YES];
}

- (NSString *)formalString {
    return [self stringSimplified:NO];
}

- (NSString *)stringSimplified:(BOOL)shouldSimplify {
    NSString *currencyCode = self.currencyCode;
    NSUInteger minorUnit = self.minorUnit;

    NSNumberFormatter * currencyFormatter = [[NSNumberFormatter alloc] init];
    currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    currencyFormatter.currencyCode = currencyCode;
    currencyFormatter.roundingMode = NSNumberFormatterRoundCeiling;
    currencyFormatter.maximumFractionDigits = minorUnit;

    NSString *currencySymbol = self.currencySymbol;
    if (shouldSimplify && currencySymbol) {
        currencyFormatter.currencySymbol = currencySymbol;
        currencyFormatter.internationalCurrencySymbol = currencySymbol;
    }

    double amount = self.amount / pow(10, minorUnit);
    return [currencyFormatter stringFromNumber:@(amount)];
}

- (NSUInteger)minorUnit {
    // list of non-2-minor-unit currency codes
    // retrieved from http://www.iso.org/iso/home/standards/currency_codes.htm
    static NSDictionary<NSString *, NSNumber *> *minorUnitByCurrencyCode;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        minorUnitByCurrencyCode = @{
                                    @"bif": @0,
                                    @"byr": @0,
                                    @"clp": @0,
                                    @"djf": @0,
                                    @"gnf": @0,
                                    @"isk": @0,
                                    @"jpy": @0,
                                    @"kmf": @0,
                                    @"krw": @0,
                                    @"pyg": @0,
                                    @"rwf": @0,
                                    @"ugx": @0,
                                    @"uyi": @0,
                                    @"vnd": @0,
                                    @"vuv": @0,
                                    @"xaf": @0,
                                    @"xof": @0,
                                    @"xpf": @0,
                                    @"bhd": @3,
                                    @"iqd": @3,
                                    @"jod": @3,
                                    @"kwd": @3,
                                    @"lyd": @3,
                                    @"omr": @3,
                                    @"tnd": @3,
                                    @"clf": @4,
                                    };
    });

    NSNumber *unitNumber = minorUnitByCurrencyCode[self.currencyCode];

    if (unitNumber) {
        return unitNumber.unsignedIntegerValue;
    }

    return 2;
}

- (NSString *)currencySymbol {
    // list of currency symbol by currency code
    // this list is generated by formatting a price with list of currency code in
    // http://www.iso.org/iso/home/standards/currency_codes.htm
    // and removing results that has the same prefix as their currency code
    static NSDictionary<NSString *, NSString *> *currencySymbolByCode;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currencySymbolByCode = @{
                                 @"aud": @"$",
                                 @"brl": @"$",
                                 @"cad": @"$",
                                 @"cny": @"¥",
                                 @"eur": @"€",
                                 @"gbp": @"£",
                                 @"hkd": @"$",
                                 @"ils": @"₪",
                                 @"inr": @"₹",
                                 @"jpy": @"¥",
                                 @"krw": @"₩",
                                 @"mxn": @"$",
                                 @"nzd": @"$",
                                 @"twd": @"$",
                                 @"usd": @"$",
                                 @"vnd": @"₫",
                                 @"xcd": @"$",
                                 };
    });

    return currencySymbolByCode[self.currencyCode];
}

@end
