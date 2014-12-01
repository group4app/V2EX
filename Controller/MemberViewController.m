//
//  MemberViewController.m
//  V2EX
//
//  Created by Chris Huang on 14-10-24.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "MemberViewController.h"
#import "Member.h"
#import "Topic.h"
#import "Reply.h"
#import "MemberParser.h"
#import "TopicParser.h"
#import "ReplyParser.h"
#import "MemberProfileView2.h"
#import "MemberTopicCell.h"
#import "MemberReplyCell.h"
#import "UIView+Xib.h"
#import "AppClient.h"
#import <objc/runtime.h>

typedef enum{
    MemberCellTopic,
    MemberCellReply
}MemberCellType;

@interface SectionInfo : NSObject

@property(nonatomic,strong) NSString                *name;
@property(nonatomic,weak) MemberSectionHeader     *headerView;

@end

@implementation SectionInfo

+ (SectionInfo*) sectionInfoWithName:(NSString*)name{
    SectionInfo *section = [[SectionInfo alloc] init];
    section.name = name;
    return section;
}

@end

@interface MemberViewController ()

@property(nonatomic,strong) NSArray         *groups;
@property(nonatomic,strong) NSArray         *headers;
@property(nonatomic,assign) NSInteger       openSection;

@property(nonatomic,strong) MemberProfileView2  *profileView;
@property(nonatomic,strong) MemberTopicCell     *prototypeTopic;
@property(nonatomic,strong) MemberReplyCell     *prototypeReply;

@end

@implementation MemberViewController

static NSString *memberUrl = @"http://www.v2ex.com/member/%@";

static NSString *topicIdentifier = @"topicIdentifier";
static NSString *replyIdentifier = @"replyIdentifier";

static NSString *kSectionHeader = @"SectionHeader";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.member.rank = [NSString stringWithFormat:@"v2ex第 %ld 号会员",(long)self.member.identifier];
    self.openSection = NSNotFound;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MemberTopicCell" bundle:nil] forCellReuseIdentifier:topicIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"MemberReplyCell" bundle:nil] forCellReuseIdentifier:replyIdentifier];
    
    self.tableView.tableHeaderView = self.profileView;

}

- (NSArray*) groups{
    
    if(!_groups){
        NSString *url = [NSString stringWithFormat:memberUrl,self.member.username];
        NSString *accept = @"text/html";
        [[AppClient shareInstance] requestWithUrl:url accept:accept success:^(id result) {
            NSString *html = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        
            NSArray *topics = [[TopicParser parserWithType:TopicSourceMember] topicsFromHtml:html];
            NSArray *replies = [[ReplyParser new] repliesFromHtml:html];
            _groups = @[topics,replies];
            
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            NSLog(@"error = %@",error);
        }];
    }
    
    return _groups;
}

- (NSArray*) headers{
    
    if(!_headers){
        _headers = @[[SectionInfo sectionInfoWithName:@"主题"],
                   [SectionInfo sectionInfoWithName:@"回复"]];
    }
    
    return _headers;
}

- (MemberProfileView2*) profileView{
    
    if(!_profileView){
        _profileView = (MemberProfileView2*)[MemberProfileView2 viewFromXib];
        _profileView.member = self.member;
        CGSize size = [_profileView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        _profileView.frame = CGRectMake(0, 0, size.width, size.height);
    }
    return _profileView;
}

- (MemberTopicCell*) prototypeTopic{
    if(!_prototypeTopic){
        _prototypeTopic = [self.tableView dequeueReusableCellWithIdentifier:topicIdentifier];
    }
    return _prototypeTopic;
    
}

- (MemberReplyCell*) prototypeReply{
    if(!_prototypeReply){
        _prototypeReply = [self.tableView dequeueReusableCellWithIdentifier:replyIdentifier];
    }
    
    return _prototypeReply;
}

#pragma mark -
#pragma mark === UITableViewDatasource & UITableViewDelegate ===
#pragma mark -
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.groups.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(self.openSection==section)
        return [self.groups[section] count];
    else
        return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50.0f;
}


- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    SectionInfo *sectionInfo = (SectionInfo*)self.headers[section];
    MemberSectionHeader *headerView = (MemberSectionHeader*)[MemberSectionHeader viewFromXib];
    headerView.titleLabel.text = sectionInfo.name;
    headerView.tag = section;
    headerView.delegate = self;
    
    sectionInfo.headerView = headerView;
    
    return headerView;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if(indexPath.section!=specialOpenSection&&indexPath.section!=self.openSection)
//        return 0.0f;
    if(self.openSection==indexPath.section)
    {
        CGSize size;
        UITableViewCell *cell;
        
        if(indexPath.section==MemberCellTopic){
            cell = self.prototypeTopic;
        }
        else{
            cell = self.prototypeReply;
        }
        
        [self configCell:cell forRowAtIndexPath:indexPath];
        size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];

        return size.height + 1;
    }
    else{
        return 0.0f;
    }
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    if(indexPath.section==MemberCellTopic){
        cell = [tableView dequeueReusableCellWithIdentifier:topicIdentifier forIndexPath:indexPath];
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:replyIdentifier forIndexPath:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self configCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void) configCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    
    if([cell isKindOfClass:[MemberTopicCell class]]){
        ((MemberTopicCell*)cell).topic = (Topic*)self.groups[indexPath.section][indexPath.row];
    }
    else{
        ((MemberReplyCell*)cell).reply = (Reply*)self.groups[indexPath.section][indexPath.row];
    }
    
}

#pragma mark -
#pragma mark === MemberSectionHeaderDelegate ===
#pragma mark -
- (void) sectionHeader:(MemberSectionHeader *)header moreAtSection:(NSInteger)section{
    
}

- (void) sectionHeader:(MemberSectionHeader *)header openAtSection:(NSInteger)section{
    
    NSInteger countOfRowsToInsert = [self.groups[section] count];
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for(int i=0;i<countOfRowsToInsert;i++){
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    NSInteger prevOpenSection = self.openSection;
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    
    if(prevOpenSection!=NSNotFound){
        MemberSectionHeader *prevHeader = ((SectionInfo*)self.headers[prevOpenSection]).headerView;
        [prevHeader navStatusChangedWithUserAction:NO];
        NSInteger countOfRowsToDelete = [self.groups[prevOpenSection] count];
        for(int i=0;i<countOfRowsToDelete;i++){
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:prevOpenSection]];
        }
    }
    
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (prevOpenSection == NSNotFound || section < prevOpenSection) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    
    self.openSection = section;
    
    // apply the updates
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.tableView endUpdates];
    
    
    
}

- (void) sectionHeader:(MemberSectionHeader *)header closedAtSection:(NSInteger)section{
    
    self.openSection = NSNotFound;
    
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    NSInteger countOfRowsToDelete = [self.groups[section] count];
    for(int i=0;i<countOfRowsToDelete;i++){
        [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
