//
//  ServiceRequest.h
//  ItemInfo
//
//  Created by Juhi Gautam on 07/03/18.
//  Copyright © 2018 Juhi Gautam. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ServiceRequestDelegate;
@interface ServiceRequest : NSObject
@property (weak, nonatomic) id delegate;
-(void)fetchJsonDataForURL:(NSString*)jsonUrl;
@end
