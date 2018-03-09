//
//  InfoBuilder.h
//  ItemInfo
//
//  Created by Juhi Gautam on 07/03/18.
//  Copyright © 2018 Juhi Gautam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoBuilder : NSObject
+ (NSArray *)infoDataFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
