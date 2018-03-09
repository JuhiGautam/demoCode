//
//  ServiceManagerDelegate.h
//  ItemInfo
//
//  Created by Juhi Gautam on 07/03/18.
//  Copyright © 2018 Juhi Gautam. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServiceManagerDelegate <NSObject>
- (void)didReceiveInfoData:(NSArray *)groups;
- (void)fetchingInfoDataFailedWithError:(NSError *)error;
@end
