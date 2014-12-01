//
//  BaseTableViewController.m
//  V2EX
//
//  Created by Chris Huang on 14-8-17.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configNavigationBar];
}

- (void) configNavigationBar{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(menuActive:)];
    
}

- (void) menuActive:(id)sender{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_ACTIVE_NOTIFICATION object:nil];
}

@end
