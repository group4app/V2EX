//
//  AllNodesViewController.m
//  V2EX
//
//  Created by Chris Huang on 14-8-14.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "AllNodesViewController.h"
#import "AppData.h"
#import "NodeItemCell.h"
#import "TopicListViewController.h"
#import "Node.h"
#import "Group.h"
#import "UIColor+GL.h"
#import "Constants.h"

@interface AllNodesViewController ()

@property(nonatomic,strong) NSMutableArray  *searchResults;
@property(nonatomic,strong) NSArray         *groups;

@property(nonatomic,strong) NodeItemCell    *prototypeCell;

@end

@implementation AllNodesViewController

static NSString *nodeCellIdentifier = @"NodeCell";
static NSString *normalCellIdentifier = @"NormalCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchResults = [[NSMutableArray alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NodeItemCell" bundle:nil] forCellReuseIdentifier:nodeCellIdentifier];

}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (NSArray*) groups{
    
    if(!_groups){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *path = [[NSBundle mainBundle] pathForResource:@"group_nodes" ofType:@"json"];
            NSData *data = [[NSData alloc] initWithContentsOfFile:path];
            NSError *error;
            _groups = [Group arrayOfModelsFromData:data error:&error];
            
            if(error){
                NSLog(@"error = %@",error);
            }
        
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
    }
    return _groups;
}

- (NSString*) documentPath{
    
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return array[0];
    
}

- (NodeItemCell*) prototypeCell{
    
    if(!_prototypeCell){
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:nodeCellIdentifier];
    }
    
    return _prototypeCell;
}


#pragma mark -
#pragma mark  === Table view data source and delegate ===
#pragma mark -
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    if(tableView==self.searchDisplayController.searchResultsTableView)
        return 1;
    else
        return [self.groups count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(tableView==self.searchDisplayController.searchResultsTableView)
        return 0.0f;
    else
        return 44.0f;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(tableView==self.searchDisplayController.searchResultsTableView)
        return nil;
    else{
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44.0)];
        headerView.backgroundColor = RGB_COLOR(240, 240, 240);
        
        Group *group = self.groups[section];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectInset(headerView.bounds, 20, 0)];
        nameLabel.text = group.name;
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont systemFontOfSize:15];
        [headerView addSubview:nameLabel];
        
        return headerView;
    }
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return [self.searchResults count];
    }
    else{
        Group *group = self.groups[section];
        return [group.nodes count];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return 60.0f;
    }
    else{
        [self configCell:self.prototypeCell forRowAtIndexPath:indexPath];
        CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height + 1;
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0f;
}


- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    if(tableView == self.searchDisplayController.searchResultsTableView){
        cell = [self.tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        }
    }
    else{
        cell = [self.tableView dequeueReusableCellWithIdentifier:nodeCellIdentifier forIndexPath:indexPath];
    }
    [self configCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void) configCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    
    if([cell isKindOfClass:[NodeItemCell class]]){
        NodeItemCell *nodeCell = (NodeItemCell*)cell;
        Group *group = self.groups[indexPath.section];
        nodeCell.node = group.nodes[indexPath.row];
    }
    else{
        Node *node = self.searchResults[indexPath.row];
        cell.textLabel.text = node.title;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Node *node;
    if(tableView == self.searchDisplayController.searchResultsTableView){
        node = self.searchResults[indexPath.row];
    }
    else{
        Group *group = self.groups[indexPath.section];
        node = group.nodes[indexPath.row];
    }
    TopicListViewController *topicList = [[TopicListViewController alloc] initWithNibName:@"TopicListViewController" bundle:nil];
    topicList.topicRefer = TopicReferAllNodes;
    topicList.nodeId = [NSString stringWithFormat:@"%ld",(long)node.identifier];
    topicList.title = node.title;
    
    [self.navigationController pushViewController:topicList animated:YES];
}



#pragma mark -
#pragma mark  === UISearchDisplayControllerDelegate ===
#pragma mark -
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
   
    [self updateFilteredContentForSearchString:searchString];
    
    return YES;
}


- (void) updateFilteredContentForSearchString:(NSString*)searchString{
    
    if(searchString==nil || searchString.length==0)
        return;
    
    [self.searchResults removeAllObjects];
    
    for(Group *group in self.groups){
        for(Node *node in group.nodes){
            NSString *title = [node.titleAlternative lowercaseString];
            if([title hasPrefix:[searchString lowercaseString]]){
                [self.searchResults addObject:node];
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
