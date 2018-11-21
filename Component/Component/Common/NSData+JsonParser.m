//
//  NSString+JSONParser.m
//  RaveApp
//
//  Created by rocky on 8/6/15.
//  Copyright (c) 2015 Tracy Xu. All rights reserved.
//

#import "NSData+JsonParser.h"

@implementation NSData (JsonParser)

- (NSDictionary *)parsedJSON
{
    NSError *error;
    return [self parsedJSONError:&error];
}

- (NSDictionary *)parsedJSONError:(NSError **)error
{
    NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:self
                                                               options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves
                                                                 error:error];
    if (*error) {
        NSLog(@"error = %@", *error);
        return nil;
    }
    
    return parsedJSON;
    
}

@end
