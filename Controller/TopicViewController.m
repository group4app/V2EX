//
//  TopicViewController.m
//  V2EX
//
//  Created by Chris Huang on 14-7-15.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "TopicViewController.h"
#import "AppData.h"
#import "CommentItemCell.h"
#import "UIView+Xib.h"
#import <UIImageView+AFNetworking.h>
#import "NSDate+General.h"
#import "Topic.h"
#import "Reply.h"
#import "Member.h"
#import "MemberViewController.h"
#import "TopicView2.h"


@interface TopicViewController ()

@property(nonatomic,strong) NSArray         *comments;

@property(nonatomic,strong) TopicView2      *topicView;
@property(nonatomic,strong) CommentItemCell *prototypeComment;


@end

@implementation TopicViewController

static NSString* commentIdentifier = @"CommentItemCell";

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
    
    UINib *commentNib = [UINib nibWithNibName:@"CommentItemCell" bundle:[NSBundle mainBundle]];
    
    [self.tableView registerNib:commentNib forCellReuseIdentifier:commentIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.topicView;
    
    [self.tableView reloadData];
}


- (NSArray*) comments{
    
    if(!_comments){
        
        NSString *topicId = [NSString stringWithFormat:@"%ld",(long)self.topic.identifier];
        [[AppData shareInstance] repliesWithTopicId:topicId success:^(id result) {
            
            NSError *error;
            _comments = [Reply arrayOfModelsFromDictionaries:result error:&error];
            _comments = [_comments sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(id obj1, id obj2) {
                Reply *reply1 = obj1;
                Reply *reply2 = obj2;
                return reply1.created<reply2.created;
            }];
            
            if(error){
                NSLog(@"error = %@",error);
            }
            else{
                self.topic.replies = self.comments.count;
                
                [self.topicView.activityView stopAnimating];
                self.topicView.refreshButton.hidden = NO;
                [self.tableView reloadData];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"error = %@",error);
        }];
    }
    
    return _comments;
}

- (TopicView2*) topicView{
    
    if(!_topicView){
        _topicView  = (TopicView2*)[TopicView2 viewFromXib];
        _topicView.topic = self.topic;
        _topicView.delegate = self;
        CGSize size = [_topicView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        _topicView.frame = CGRectMake(0, 0, size.width, size.height);
    }
    return _topicView;
}

- (CommentItemCell*) prototypeComment{
    
    if(!_prototypeComment){
        _prototypeComment = [self.tableView dequeueReusableCellWithIdentifier:commentIdentifier];
    }
    
    return _prototypeComment;
}


#pragma mark -
#pragma mark === UITableViewDataSource & UITableViewDelegate ===
#pragma mark -
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.comments.count;
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self configCell:self.prototypeComment forRowAtIndexPath:indexPath];
    CGSize size = [self.prototypeComment.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height+1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentIdentifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row%2==0){
        cell.backgroundColor = [UIColor whiteColor];
    }
    else{
        cell.backgroundColor = RGB_COLOR(245, 245, 245);
    }

    [self configCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void) configCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    
    if([cell isKindOfClass:[CommentItemCell class]]){
        
        CommentItemCell *commentCell = (CommentItemCell*)cell;
        [commentCell.contentLabel clearProperties];
        commentCell.comment = self.comments[indexPath.row];
        commentCell.contentLabel.delegate = self;
        commentCell.delegate = self;
    }
    
}

#pragma mark -
#pragma mark === TopicViewDelegate & CommentItemCellDelegate ===
#pragma mark -
- (void) refreshTopicReplies{
    
    self.comments = nil;
    [self.tableView reloadData];
    
}

- (void) memberSelected:(Member *)member{
    
    MemberViewController *memberCtl = [[MemberViewController alloc] init];
    memberCtl.member = member;
    memberCtl.title = member.username;
    [self.navigationController pushViewController:memberCtl animated:YES];
    
}

#pragma mark -
#pragma mark === TTTAttributedLabel ===
#pragma mark -
- (void) attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTextCheckingResult:(NSTextCheckingResult *)result{
    
    NSLog(@"did select");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
