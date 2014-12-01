//
//  SnsWallViewController.m
//  V2EX
//
//  Created by Chris Huang on 14-8-5.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "SnsWallViewController.h"

@interface SnsWallViewController ()

@property(nonatomic,retain) NSArray             *weiboTopics;
@property(nonatomic,retain) SnsPostCell         *prototypeCell;

@property(nonatomic,retain) NSMutableArray      *mwPhotos;

@end

@implementation SnsWallViewController

static NSString *SnsWallIndentifier    = @"SnsPost";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Weibo Wall";
    
    UINib *nib = [UINib nibWithNibName:@"SnsPostCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:SnsWallIndentifier];
    
}

- (NSArray*) weiboTopics{
    
    if(!_weiboTopics){
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"topics" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        NSError *error;
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if(json){
            _weiboTopics = json[@"statuses"];
        }
        
    }
    
    return _weiboTopics;
}

- (SnsPostCell*) prototypeCell{
    
    if(!_prototypeCell){
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:SnsWallIndentifier];
    }
    
    return _prototypeCell;
}


#pragma mark -
#pragma mark === UITableViewDatasource & UITableViewDelegate ===
#pragma mark -
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.weiboTopics count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self configCell:self.prototypeCell forRowAtIndexPath:indexPath];
    
    return  self.prototypeCell.actualCellHeight;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:SnsWallIndentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void) configCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    
    if([cell isKindOfClass:[SnsPostCell class]]){
        SnsPostCell *postCell = (SnsPostCell*)cell;
        [postCell.contentLabel clearProperties];
        postCell.delegate = self;
        postCell.topic = self.weiboTopics[indexPath.row];
    }
}

#pragma mark -
#pragma mark === SnsPhotoCellDelegate ===
#pragma mark -
- (void) selectPhoto:(NSArray *)photos atIndex:(NSInteger)index{
    
    if(!self.mwPhotos){
        self.mwPhotos = [[NSMutableArray alloc] init];
    }
    else{
        [self.mwPhotos removeAllObjects];
    }
    
    for(NSString *picUrl in photos){
        MWPhoto *photo = [[MWPhoto alloc] initWithURL:[NSURL URLWithString:picUrl]];
        [self.mwPhotos addObject:photo];
    }
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.enableSwipeToDismiss = YES;

    [browser setCurrentPhotoIndex:index];
    [self.navigationController pushViewController:browser animated:YES];
    
}



#pragma mark -
#pragma mark === MWPhotoBrowserDelegate ===
#pragma mark -
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    
    return self.mwPhotos.count;
    
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    
    if (index < self.mwPhotos.count)
        return [self.mwPhotos objectAtIndex:index];
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
