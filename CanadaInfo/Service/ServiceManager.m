//
//  ServiceManager.m
//  ItemInfo
//
//  Created by Juhi Gautam on 07/03/18.
//  Copyright © 2018 Juhi Gautam. All rights reserved.
//

#import "ServiceManager.h"
#import "InfoBuilder.h"
#import "ServiceRequest.h"
@implementation ServiceManager
- (void)fetchInfoForJson:(NSString*)jsonURL{
    [self.service fetchJsonDataForURL:jsonURL];
}
#pragma mark - ServiceRequestDelegate

- (void)receivedInfoDataJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *groups = [InfoBuilder infoDataFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingInfoDataFailedWithError:error];
        
    } else {
        [self.delegate didReceiveInfoData:groups];
    }
}

- (void)fetchingInfoDataFailedWithError:(NSError *)error
{
    [self.delegate fetchingInfoDataFailedWithError:error];
}

@end
