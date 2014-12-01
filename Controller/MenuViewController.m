//
//  MenuViewController.m
//  V2EX
//
//  Created by Chris Huang on 14-7-7.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "MenuViewController.h"
#import "UIImage+Color.h"
#import "MenuItemCell.h"
#import "UIView+Xib.h"
#import "UIImage+Color.h"
#import "UIColor+GL.h"
#import "TopicListViewController.h"
#import "AllNodesViewController.h"
#import "BookmarkViewController.h"
#import "SettingViewController.h"
#import "AccountViewController.h"

#define MENU_CELL_TAG   100
#define MENU_WIDTH      240

@interface MenuViewController ()

@property(nonatomic,strong) NSArray         *menuIcons;
@property(nonatomic,strong) NSArray         *menuNames;

@property(nonatomic,strong) NSArray         *controllers;

@end

@implementation MenuViewController

static NSString *menuCellIndentifier    = @"MenuCell";
static NSString *accountCellIndentifier = @"AccountCell";

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
    
    UINib *accountNib = [UINib nibWithNibName:@"AccountCell" bundle:nil];
    [self.menuView registerNib:accountNib forCellReuseIdentifier:accountCellIndentifier];
    
    UINib *menuNib = [UINib nibWithNibName:@"MenuItemCell" bundle:nil];
    [self.menuView registerNib:menuNib forCellReuseIdentifier:menuCellIndentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuShow:) name:MENU_ACTIVE_NOTIFICATION object:nil];

    
    self.menuView.backgroundColor = [UIColor appMenuBackgroundColor];
}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    [self tableView:self.menuView didSelectRowAtIndexPath:indexPath];
    [self.menuView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (NSArray*) menuIcons{
    
    if(!_menuIcons){
        _menuIcons = @[@"icon_account.png",
                       @"icon_hot.png",
                       @"icon_latest.png",
                       @"icon_all_nodes.png",
                       @"icon_bookmark.png",
                       @"icon_setting.png"];
    }
    return _menuIcons;
}

- (NSArray*) menuNames{
    
    if(!_menuNames){
        _menuNames = @[@"未登录",@"最热话题",@"最新话题",@"所有节点",@"收藏节点",@"设置"];
    }
    
    return _menuNames;
}

- (NSArray*) controllers{
    
    if(!_controllers){
        
        AccountViewController *account = [[AccountViewController alloc] initWithNibName:@"AccountViewController" bundle:nil];
        UINavigationController *navAcc = [[UINavigationController alloc] initWithRootViewController:account];
        
        TopicListViewController *hot = [[TopicListViewController alloc] initWithNibName:@"TopicListViewController" bundle:nil];
        hot.topicRefer = TopicReferHot;
        UINavigationController *navHot = [[UINavigationController alloc] initWithRootViewController:hot];
        
        TopicListViewController *newest = [[TopicListViewController alloc] initWithNibName:@"TopicListViewController" bundle:nil];
        newest.topicRefer = TopicReferLatest;
        UINavigationController *navNew = [[UINavigationController alloc] initWithRootViewController:newest];
        
        AllNodesViewController *allNodes = [[AllNodesViewController alloc] initWithNibName:@"AllNodesViewController" bundle:nil];
        UINavigationController *navNodes = [[UINavigationController alloc] initWithRootViewController:allNodes];
        
        BookmarkViewController *bookmark = [[BookmarkViewController alloc] initWithNibName:@"BookmarkViewController" bundle:nil];
        UINavigationController *navBookmark = [[UINavigationController alloc] initWithRootViewController:bookmark];
        
        SettingViewController *setting = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
        UINavigationController *navSet = [[UINavigationController alloc] initWithRootViewController:setting];
        
        _controllers = @[navAcc,
                         navHot,
                         navNew,
                         navNodes,
                         navBookmark,
                         navSet];
    }
    
    return _controllers;
}


- (void) menuShow:(id)sender{
    
    [UIView animateWithDuration:.3 animations:^{
        self.contentView.frame = CGRectMake(MENU_WIDTH, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    } completion:^(BOOL finished) {
        [self.view bringSubviewToFront:self.gestureView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuHide:)];
        [self.gestureView addGestureRecognizer:tap];
    }];
    
}

- (void) menuHide:(id)sender{
    
    [UIView animateWithDuration:.3 animations:^{
        self.contentView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    } completion:^(BOOL finished) {
        [self.view sendSubviewToBack:self.gestureView];
        [self.gestureView removeGestureRecognizer:self.gestureView.gestureRecognizers.lastObject];
    }];
}

#pragma mark - UITableViewDatasource & UITableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.menuIcons count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if(indexPath.row==0)
        return 150.0f;
    else
        return 60.0f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell;
    if(indexPath.row==0){
        cell = [tableView dequeueReusableCellWithIdentifier:accountCellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:menuCellIndentifier];
        cell.selectedBackgroundView = [self selectedBackgroundViewForCell:cell];
        [self configCell:cell indexPath:indexPath];
    }
    
    return cell;
}

- (UIView*) selectedBackgroundViewForCell:(UITableViewCell*)cell{
    
    UIView *selectView = [[UIView alloc] initWithFrame:cell.bounds];
    selectView.backgroundColor = [UIColor appMenuSelectColor];
    
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, cell.bounds.size.height)];
    colorView.backgroundColor = [UIColor appMainColor];
    [selectView addSubview:colorView];
    
    return selectView;
}

- (void) configCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexPath{
    
    if([cell isKindOfClass:[MenuItemCell class]]){
        MenuItemCell *menuCell = (MenuItemCell*)cell;
        menuCell.iconView.image = [[UIImage imageNamed:self.menuIcons[indexPath.row]] imageTintedWithColor:[UIColor whiteColor]];
        menuCell.nameLabel.text = self.menuNames[indexPath.row];
    }

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==0)  return;
    
    UIViewController *controller = self.controllers[indexPath.row];
    if([controller isKindOfClass:[UINavigationController class]]){
        UIViewController *topCtl = ((UINavigationController*)controller).topViewController;
        topCtl.title = self.menuNames[indexPath.row];
        [topCtl viewWillAppear:YES];
    }
    else{
        controller.title = self.menuNames[indexPath.row];
    }
    
    if(![controller isEqual:[NSNull null]]){
        [self.contentView addSubview:controller.view];
        [self menuHide:nil];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
