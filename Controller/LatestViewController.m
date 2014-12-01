//
//  LatestViewController.m
//  V2EX
//
//  Created by Chris Huang on 14-7-15.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "LatestViewController.h"
#import "AppData.h"
#import "LatestItemCell.h"
#import "UIView+Xib.h"
#import "NSDate+General.h"
#import "TopicViewController.h"
#import <UIImageView+AFNetworking.h>

#define LATEST_CELL_TAG 100

@interface LatestViewController ()

@property(nonatomic,strong) NSArray *latestTopics;

@end

@implementation LatestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNavigationBar];
    
    [[AppData shareInstance] latestTopicsSuccess:^(id result) {
        self.latestTopics = result;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"error = %@!",[error description]);
    }];
}

- (void) initNavigationBar{
    
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(menuActive:)];
    self.navigationItem.leftBarButtonItem = menuItem;
    
    self.navigationItem.title = @"Latest";
    
}


#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.latestTopics count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100.0f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    
    [self configCell:cell indexPath:indexPath];
    
    return cell;
}

- (void) configCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexPath{
    
    LatestItemCell *item = (LatestItemCell*)[cell viewWithTag:LATEST_CELL_TAG];
    if(!item){
        item = (LatestItemCell*)[LatestItemCell viewFromXib];
        item.tag = LATEST_CELL_TAG;
        [cell.contentView addSubview:item];
    }

    item.topic = self.latestTopics[indexPath.row];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TopicViewController *topic = [[TopicViewController alloc] initWithNibName:@"TopicViewController" bundle:nil];
    topic.topic = self.latestTopics[indexPath.row];
    topic.title = topic.topic[@"node"][@"title"];
    
    [self.navigationController pushViewController:topic animated:YES];
}


#pragma mark - Target Action
- (void) menuActive:(id)sender{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_ACTIVE_NOTIFICATION object:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
