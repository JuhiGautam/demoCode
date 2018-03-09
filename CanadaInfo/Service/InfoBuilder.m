//
//  InfoBuilder.m
//  ItemInfo
//
//  Created by Juhi Gautam on 07/03/18.
//  Copyright © 2018 Juhi Gautam. All rights reserved.
//

#import "InfoBuilder.h"
#import "AppRecord.h"
@implementation InfoBuilder
+ (NSArray *)infoDataFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSString *iso = [[NSString alloc] initWithData:objectNotation encoding:NSISOLatin1StringEncoding];
    NSData *resData = [iso dataUsingEncoding:NSUTF8StringEncoding];
    id parsedObject = [NSJSONSerialization JSONObjectWithData:resData options:kNilOptions error:&localError] ;
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    NSArray *results = [parsedObject objectForKey:@"rows"];
    for (NSDictionary *tempDict in results)
    {
        AppRecord *record = [[AppRecord alloc] init];
        if ([parsedObject objectForKey:@"title"]!= nil && ![[parsedObject objectForKey:@"title"] isKindOfClass:[NSNull class]] && [parsedObject objectForKey:@"title"] != NULL)
        {
            record.AppTitleString = [parsedObject objectForKey:@"title"];
        }
        else{
            record.AppTitleString = @"";
        }
        if ([tempDict objectForKey:@"title"]!= nil && ![[tempDict objectForKey:@"title"] isKindOfClass:[NSNull class]] && [tempDict objectForKey:@"title"] != NULL)
        {
            record.titleString = [tempDict objectForKey:@"title"];
        }
        else{
            record.titleString = @"";
        }
        if ([tempDict objectForKey:@"imageHref"]!= nil && ![[tempDict objectForKey:@"imageHref"] isKindOfClass:[NSNull class]] && [tempDict objectForKey:@"imageHref"] != NULL)
        {
            record.imageURLString = [tempDict objectForKey:@"imageHref"];
        }
        else{
            record.imageURLString = @"";
        }
        if ([tempDict objectForKey:@"description"]!= nil && ![[tempDict objectForKey:@"description"] isKindOfClass:[NSNull class]] && [tempDict objectForKey:@"description"] != NULL)
        {
            record.descriptionString = [tempDict objectForKey:@"description"];
        }
        else{
            record.descriptionString = @"NA";
        }
        [groups addObject:record];
    }
    return groups;
}
@end
