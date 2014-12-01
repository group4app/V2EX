//
//  Member.h
//  V2EX
//
//  Created by Chris Huang on 14-10-23.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

@protocol Member

@end

@interface Member : JSONModel

@property(nonatomic,assign) NSInteger                         identifier;
@property(nonatomic,strong) NSString<Optional>                *status;
@property(nonatomic,strong) NSString<Optional>                *url;
@property(nonatomic,strong) NSString<Optional>                *found;
@property(nonatomic,strong) NSString                          *username;
@property(nonatomic,strong) NSString<Optional>                *website;
@property(nonatomic,strong) NSString<Optional>                *twitter;
@property(nonatomic,strong) NSString<Optional>                *psn;
@property(nonatomic,strong) NSString<Optional>                *github;
@property(nonatomic,strong) NSString<Optional>                *btc;
@property(nonatomic,strong) NSString<Optional>                *location;
@property(nonatomic,strong) NSString                          *tagline;
@property(nonatomic,strong) NSString<Optional>                *bio;
@property(nonatomic,strong) NSString                          *avatarMini;
@property(nonatomic,strong) NSString                          *avatarNormal;
@property(nonatomic,strong) NSString                          *avatarLarge;
@property(nonatomic,assign) NSInteger                         created;

//from website
@property(nonatomic,strong) NSString<Optional>                *info;
@property(nonatomic,strong) NSString<Optional>                *rank;
@property(nonatomic,strong) NSString<Optional>                *joinTime;

@end
