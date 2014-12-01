//
//  CoreStore.h
//  GTODashboard
//
//  Created by Benjamin on 6/4/13.
//  Copyright (c) 2013 ActiveMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreStore : NSObject

+ (CoreStore *)sharedStore;
+ (CoreStore *)sharedStoreForGroup:(NSString *)group;

- (id)initWithGroup:(NSString *)group;

//Data
- (id)dataForKey:(NSString *)key;
- (void)setData:(id)data forKey:(NSString *)key;
- (void)removeDataForKey:(NSString *)key;

//String
- (NSString *)stringDataForKey:(NSString *)key;
- (void)setStringData:(NSString *)data forKey:(NSString *)key;

//Date
- (NSDate *)dateDataForKey:(NSString *)key;
- (void)setDateData:(NSDate *)data forKey:(NSString *)key;

//Bool
- (BOOL)BOOLDataForKey:(NSString *)key;
- (void)setBOOLData:(BOOL)data forKey:(NSString *)key;

//Integer
- (NSInteger)integerDataForKey:(NSString *)key;
- (void)setIntegerData:(NSInteger)data forKey:(NSString *)key;

//JSON
- (id)jsonDataForKey:(NSString *)key type:(Class)type;
- (void)setJsonData:(id)data forKey:(NSString *)key;

@end
