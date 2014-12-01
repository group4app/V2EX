//
//  BookmarkViewController.m
//  V2EX
//
//  Created by Chris Huang on 14-8-17.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "BookmarkViewController.h"
#import "BookmarkItemCell.h"
#import "CoreStore+V2EX.h"
#import "TopicListViewController.h"
#import "Node.h"

@interface BookmarkViewController ()

@property(nonatomic,strong) NSArray             *nodes;


@end

@implementation BookmarkViewController

static NSString *bookmarkCellIdentifier = @"BookmarkCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"BookmarkItemCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:bookmarkCellIdentifier];
    
}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (NSArray*) nodes{
    
    NSArray *array = [[CoreStore sharedStore] allBookmarks];
    _nodes = [Node arrayOfModelsFromDictionaries:array];
    
    return _nodes;
}




#pragma mark -
#pragma mark === UITableViewDatasource & UITableViewDelegate ===
#pragma mark -
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.nodes count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70.0f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:bookmarkCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
    
}


- (void) configCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    
    if([cell isKindOfClass:[BookmarkItemCell class]]){
        BookmarkItemCell *bookmarkCell = (BookmarkItemCell*)cell;
        bookmarkCell.node = self.nodes[indexPath.row];
        bookmarkCell.indexPath = indexPath;
        bookmarkCell.delegate = self;
    }
    
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
	
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		NSNumber *nodeId = self.nodes[indexPath.row][@"id"];
        [[CoreStore sharedStore] removeBookmarkWithNodeId:nodeId];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
	}
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Node *node = self.nodes[indexPath.row];
    
    TopicListViewController *topicList = [[TopicListViewController alloc] initWithNibName:@"TopicListViewController" bundle:nil];
    topicList.topicRefer = TopicReferBookmark;
    topicList.nodeId = [NSString stringWithFormat:@"%d",node.identifier];
    topicList.title = node.title;
    
    [self.navigationController pushViewController:topicList animated:YES];
}

#pragma mark -
#pragma mark === BookmarkItemCellDelegate ===
#pragma mark -
- (void) deleteCell:(BookmarkItemCell *)cell{
    
    NSNumber *nodeId = self.nodes[cell.indexPath.row][@"id"];
    [[CoreStore sharedStore] removeBookmarkWithNodeId:nodeId];
    
    NSArray *deleteIndexPaths = @[cell.indexPath];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView endUpdates];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
