//
//  NSString+JSONParser.h
//  RaveApp
//
//  Created by rocky on 8/6/15.
//  Copyright (c) 2015 Tracy Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (JsonParser)

- (NSDictionary *)parsedJSON;

- (NSDictionary *)parsedJSONError:(NSError **)error;

@end
