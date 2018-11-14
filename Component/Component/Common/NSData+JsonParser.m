//
//  NSString+JSONParser.m
//  RaveApp
//
//  Created by rocky on 8/6/15.
//  Copyright (c) 2015 Tracy Xu. All rights reserved.
//

#import "NSData+JsonParser.h"
#import "Constants.h"


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
        DebugLogDebug(@"error = %@", *error);
        return nil;
    }
    
    return parsedJSON;
    
}

@end
