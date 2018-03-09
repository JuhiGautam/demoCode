//
//  ServiceRequest.m
//  ItemInfo
//
//  Created by Juhi Gautam on 07/03/18.
//  Copyright © 2018 Juhi Gautam. All rights reserved.
//

#import "ServiceRequest.h"
#import "ServiceRequestDelegate.h"
#import <Foundation/Foundation.h>

@implementation ServiceRequest
-(void)fetchJsonDataForURL:(NSString*)jsonUrl{
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [jsonUrl stringByAddingPercentEncodingWithAllowedCharacters:set];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                if (!error) {
                    // Success
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                            [self.delegate receivedInfoDataJSON:data];
                        }  else {
                            //Web server is returning an error
                            [self.delegate fetchingInfoDataFailedWithError:error];
                        }
                    });
                } else {
                    // Fail
                    [self.delegate fetchingInfoDataFailedWithError:error];
                    NSLog(@"error : %@", error.description);
                }
            }] resume];
}

@end
