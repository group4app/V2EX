//
//  TopicListViewController.m
//  V2EX
//
//  Created by Chris Huang on 14-7-30.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "TopicListViewController.h"
#import "TopicItemCell.h"
#import "AppData.h"
#import "TopicViewController.h"
#import <SVPullToRefresh.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "CoreStore+V2EX.h"
#import <SVProgressHUD.h>
#import "Topic.h"
#import "Node.h"
#import "Member.h"
#import "MemberViewController.h"


@interface TopicListViewController ()

@property(nonatomic,retain) NSArray             *topics;
@property(nonatomic,retain) TopicItemCell       *prototypeCell;

@end

@implementation TopicListViewController

static NSString *newestCellIndentifier = @"TopicCell";


- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if(!_topics){
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicItemCell" bundle:nil] forCellReuseIdentifier:newestCellIndentifier];
    

    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshTriggered:) forControlEvents:UIControlEventValueChanged];
}

- (void) configNavigationBar{
    
    if(self.topicRefer!=TopicReferAllNodes){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(menuActive:)];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray*) topics{
    
    if(!_topics){
        if(self.topicRefer==TopicReferHot){
            [self hotTopics];
        }
        else if(self.topicRefer==TopicReferLatest){
            [self lastestTopics];
        }
        else{
            [self nodeTopics];
        }
    }
    
    return _topics;
}

- (void) getTopicsSuccess:(id)result{
    
    [SVProgressHUD dismiss];
    NSError *error;
    _topics = [Topic arrayOfModelsFromDictionaries:result error:&error];
    if(error){
        NSLog(@"error = %@",error);
    }
    else{
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }
}

- (void) lastestTopics{
    
    [[AppData shareInstance] latestTopicsSuccess:^(id result) {

        [self getTopicsSuccess:result];
    } failure:^(NSError *error) {
        NSAssert(NO, @"Get latest topics error!");
    }];
    
}

- (void) hotTopics{
    
    [[AppData shareInstance] hotTopicsSuccess:^(id result) {
        
        [self getTopicsSuccess:result];
    } failure:^(NSError *error) {
        NSAssert(NO, @"Get hot topics error!");
    }];
    
}

- (void) nodeTopics{
    
    [[AppData shareInstance] topicsWithNodeId:self.nodeId success:^(id result) {
        
        [self getTopicsSuccess:result];
    } failure:^(NSError *error) {
        NSAssert(NO, @"Get topic with node id %@ error!",self.nodeId);
    }];
}


- (TopicItemCell*) prototypeCell{
    
    if(!_prototypeCell){
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:newestCellIndentifier];
    }
    
    return _prototypeCell;
}

#pragma mark -
#pragma mark  === Refresh Control ===
#pragma mark -
- (void) refreshTriggered:(id)sender{
    
    UIRefreshControl *refreshControl = sender;
    [refreshControl beginRefreshing];
    self.topics = nil;
    NSInteger count = self.topics.count;
}

#pragma mark -
#pragma mark  === TopicItemCellDelegate ===
#pragma mark -
- (void) memberSelected:(Member*)member{
    
    MemberViewController *memberCtl = [[MemberViewController alloc] init];
    memberCtl.member = member;
    memberCtl.title = member.username;
    [self.navigationController pushViewController:memberCtl animated:YES];
    
}

#pragma mark -
#pragma mark  === Table view data source and delegate ===
#pragma mark -
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.topics count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self configCell:self.prototypeCell forRowAtIndexPath:indexPath];
    
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height + 1;
    
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:newestCellIndentifier forIndexPath:indexPath];
    cell.backgroundColor = RGB_COLOR(250, 250, 250);
    [self configCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void) configCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    
    if([cell isKindOfClass:[TopicItemCell class]]){
        TopicItemCell *topicCell = (TopicItemCell*)cell;
        topicCell.delegate = self;
        topicCell.topic = self.topics[indexPath.row];
        if(self.topicRefer==TopicReferAllNodes||
           self.topicRefer==TopicReferBookmark){
            topicCell.groupLabel.hidden = YES;
        }
    }
    
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TopicViewController *topicCtl = [[TopicViewController alloc] initWithNibName:@"TopicViewController" bundle:nil];
    Topic *topic = self.topics[indexPath.row];
    topicCtl.topic = topic;
    topicCtl.title = topic.member.username;
    [self.navigationController pushViewController:topicCtl animated:YES];
    
}



@end
