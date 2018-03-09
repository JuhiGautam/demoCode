//
//  ViewController.m
//  ItemInfo
//
//  Created by Juhi Gautam on 07/03/18.
//  Copyright © 2018 Juhi Gautam. All rights reserved.
//

#import "ViewController.h"
#import "InfoDataCustomTableViewCell.h"

#define FONT_SIZE 12.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@interface ViewController (){
    UIRefreshControl *refreshController;
}
@end

@implementation ViewController
@synthesize dataTable;
@synthesize _groups;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureTableView];
    [self configureServiceManager];
}

#pragma mark - JSON Fetch And Saving Data
-(void)configureServiceManager{
    _manager = [[ServiceManager alloc] init];
    _manager.service = [[ServiceRequest alloc] init];
    _manager.service.delegate = _manager;
    _manager.delegate = self;
    [self startFetchingInfo];
}
- (void)startFetchingInfo
{
    [_manager fetchInfoForJson:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"];
}
- (void)didReceiveInfoData:(NSArray *)groups
{
    _groups = groups;
    AppRecord *data = [_groups objectAtIndex:0];
    NSString *titleStr = data.AppTitleString;
    self.navigationController.topViewController.title = titleStr;
    [self.dataTable reloadData];
}

- (void)fetchingInfoDataFailedWithError:(NSError *)error
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - TableView
-(void)configureTableView{
    self.dataTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.dataTable.rowHeight = UITableViewAutomaticDimension;
    self.dataTable.estimatedRowHeight = 600;
    self.dataTable.delegate = self;
    self.dataTable.dataSource = self;
    self.dataTable.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.dataTable];
    
    refreshController = [[UIRefreshControl alloc] init];
    [refreshController addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.dataTable addSubview:refreshController ];
    [self configureConstraintsLayout];
}
-(void)configureConstraintsLayout{
    //Trailing
    NSLayoutConstraint *trailing =[NSLayoutConstraint
                                   constraintWithItem:self.dataTable
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.view
                                   attribute:NSLayoutAttributeTrailing
                                   multiplier:1.0f
                                   constant:0.f];
    
    //Leading
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:self.dataTable
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.view
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0.f];
    
    //Top
    NSLayoutConstraint *top =[NSLayoutConstraint
                                 constraintWithItem:self.dataTable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:self.view
                                 attribute:NSLayoutAttributeTop
                                 multiplier:1.0f
                                 constant:15.f];
    //Bottom
    NSLayoutConstraint *bottom =[NSLayoutConstraint
                                 constraintWithItem:self.dataTable
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:self.view
                                 attribute:NSLayoutAttributeBottom
                                 multiplier:1.0f
                                 constant:0.f];
    
    //Height to be fixed for SubView same as AdHeight
    NSLayoutConstraint *height = [NSLayoutConstraint
                                  constraintWithItem:self.dataTable
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:0
                                  constant:self.view.frame.size.height];
    
    //Add constraints to the Parent
    [self.view addConstraint:trailing];
    [self.view addConstraint:top];
    [self.view addConstraint:bottom];
    [self.view addConstraint:leading];
    
    //Add height constraint to the subview, as subview owns it.
    [self.dataTable addConstraint:height];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _groups.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppRecord *data = [_groups objectAtIndex:indexPath.row];
    NSString *descriptionStr = data.descriptionString;
    CGSize constraint = CGSizeMake(310, 20000.0f);
    CGRect descriptionSize = [descriptionStr
                              boundingRectWithSize:constraint
                              options:NSStringDrawingUsesLineFragmentOrigin
                              attributes:@{
                                           NSFontAttributeName : [UIFont systemFontOfSize:14]
                                           }
                              context:nil];
    // constratins the size of the table row according to the text
    
    CGFloat height = descriptionSize.size.height;
    
    return height + (45);
    //return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppRecord *data = [_groups objectAtIndex:indexPath.row];
    NSString *titleStr = data.titleString;
    NSString *imgUrl = data.imageURLString;
    NSString *descriptionStr = data.descriptionString;
    
    static NSString *cellIdentifier = @"InfoCell";
    
    InfoDataCustomTableViewCell *cell = (InfoDataCustomTableViewCell *)[dataTable dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[InfoDataCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell.titleLabel setText:titleStr];
    
    CGSize constraint = CGSizeMake(cell.descriptionLabel.frame.size.width, 20000.0f);
   // let size = CGSize(width: 300.0, height: 1000)
    CGRect descriptionSize = [descriptionStr
                              boundingRectWithSize:constraint
                              options:NSStringDrawingUsesLineFragmentOrigin
                              attributes:@{
                                           NSFontAttributeName : [UIFont systemFontOfSize:12]
                                           }
                              context:nil];
    
    [cell.descriptionLabel setText:descriptionStr];
    CGRect descriptionFrame = cell.descriptionLabel.frame;
    descriptionFrame.size.width = cell.frame.size.width-25;
    descriptionFrame.size.height = descriptionSize.size.height;
    cell.descriptionLabel.frame = descriptionFrame;
    cell.iconImage.image = [UIImage imageNamed:@"Placeholder.png"];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // retrive image on global queue
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:     [NSURL URLWithString:imgUrl]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            InfoDataCustomTableViewCell * cell = (InfoDataCustomTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            // assign cell image on main thread
            if (img) {
                cell.iconImage.image = img;
            }
            else
                cell.iconImage.image = [UIImage imageNamed:@"Placeholder.png"];
        });
    });
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    
    return cell;
}
#pragma mark - Handle Refresh Method

-(void)handleRefresh : (id)sender
{
    NSLog (@"Pull To Refresh Method Called");
    [self startFetchingInfo];
    [refreshController endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
