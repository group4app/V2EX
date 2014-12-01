//
//  BookmarkItemCell.h
//  V2EX
//
//  Created by Chris Huang on 14-8-17.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookmarkItemCell;
@class Node;

@protocol BookmarkItemCellDelegate <NSObject>

- (void) deleteCell:(BookmarkItemCell*)cell;

@end

@interface BookmarkItemCell : UITableViewCell<UIGestureRecognizerDelegate>

@property(nonatomic,weak) IBOutlet UIView          *mainView;
@property(nonatomic,weak) IBOutlet UILabel         *titleLabel;
@property(nonatomic,weak) IBOutlet UILabel         *subTitleLabel;
@property(nonatomic,weak) IBOutlet UIButton        *deleteButton;

@property(nonatomic,strong) Node            *node;
@property(nonatomic,strong) NSIndexPath     *indexPath;

@property(nonatomic,weak) id<BookmarkItemCellDelegate> delegate;

- (IBAction)deleteButtonPressed:(id)sender;

@end
