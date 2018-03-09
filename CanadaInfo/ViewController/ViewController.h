//
//  ViewController.h
//  ItemInfo
//
//  Created by Juhi Gautam on 07/03/18.
//  Copyright © 2018 Juhi Gautam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppRecord.h"
#import "ServiceManager.h"
#import "ServiceRequest.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    ServiceManager *_manager;
}
@property(strong, nonatomic) UITableView *dataTable;
@property(strong, nonatomic) NSArray *_groups;

-(void)configureServiceManager;
@end

