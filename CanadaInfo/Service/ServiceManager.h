//
//  ServiceManager.h
//  ItemInfo
//
//  Created by Juhi Gautam on 07/03/18.
//  Copyright © 2018 Juhi Gautam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceManagerDelegate.h"
#import "ServiceRequestDelegate.h"

@class ServiceRequest;
@interface ServiceManager : NSObject
@property (strong, nonatomic) ServiceRequest *service;
@property (weak, nonatomic) id delegate;

- (void)fetchInfoForJson:(NSString*)jsonURL;

@end
