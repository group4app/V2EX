//
//  CoreStore.m
//  GTODashboard
//
//  Created by Benjamin on 6/4/13.
//  Copyright (c) 2013 ActiveMobile. All rights reserved.
//

#import "CoreStore.h"

@interface CoreStore()
#pragma mark – Private properties
@property (nonatomic, strong) NSString              *group;
@property (nonatomic, strong) NSUserDefaults        *store;
@end

@implementation CoreStore

static NSMutableDictionary *coreStoreDictionary = nil;

#pragma mark - Singleton methods

+ (CoreStore *)sharedStore {
    return [self sharedStoreForGroup:@"_shared_"];
}

+ (CoreStore *)sharedStoreForGroup:(NSString *)group {
    if (coreStoreDictionary == nil) {
        @synchronized(self) {
            if (coreStoreDictionary == nil) {
                coreStoreDictionary = [[NSMutableDictionary alloc] init];
            }
        }
    }
    CoreStore *dataStore = coreStoreDictionary[group];
    if (dataStore == nil) {
        @synchronized(self) {
            if (dataStore == nil) {
                dataStore = [[CoreStore alloc] initWithGroup:group];
                [coreStoreDictionary setValue:dataStore forKey:group];
            }
        }
    }
    return dataStore;
}

#pragma mark - Initialization

- (id)init {
    // Forbid calls to –init or +new
    NSAssert(NO, @"Cannot create instance of Singleton");
    // You can return nil or [self initSingleton] here,
    // depending on how you prefer to fail.
    return nil;
}

- (id)initWithGroup:(NSString *)group {
    self = [super init];
    if (self) {
        _group = group;
        _store = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

#pragma mark - Public property & method

- (id)dataForKey:(NSString *)key {
    NSString *groupKey = [NSString stringWithFormat:@"%@_%@",_group,key];
    id data = [_store objectForKey:groupKey];
    return data == [NSNull null] ? nil :data;
}

- (void)setData:(id)data forKey:(NSString *)key {
    NSString *groupKey = [NSString stringWithFormat:@"%@_%@",_group,key];
    [_store setObject:data forKey:groupKey];
    [_store synchronize];
}

- (void)removeDataForKey:(NSString *)key {
    NSString *groupKey = [NSString stringWithFormat:@"%@_%@",_group,key];
    [_store removeObjectForKey:groupKey];
    [_store synchronize];
}

- (NSString *)stringDataForKey:(NSString *)key {
    return (NSString *)[self dataForKey:key];
}
- (void)setStringData:(NSString *)data forKey:(NSString *)key {
    [self setData:(NSString*)data forKey:key];
}

- (NSDate *)dateDataForKey:(NSString *)key {
    return (NSDate *)[self dataForKey:key];
}

- (void)setDateData:(NSDate *)data forKey:(NSString *)key {
    [self setData:data forKey:key];
}

- (BOOL)BOOLDataForKey:(NSString *)key {
    NSString *groupKey = [NSString stringWithFormat:@"%@_%@",_group,key];
    BOOL data = [_store boolForKey:groupKey];
    return data;
}
- (void)setBOOLData:(BOOL)data forKey:(NSString *)key {
    NSString *groupKey = [NSString stringWithFormat:@"%@_%@",_group,key];
    [_store setBool:data forKey:groupKey];
    [_store synchronize];
}

- (NSInteger)integerDataForKey:(NSString *)key {
    NSString *groupKey = [NSString stringWithFormat:@"%@_%@",_group,key];
    NSInteger data = [_store integerForKey:groupKey];
    return data;
}
- (void)setIntegerData:(NSInteger)data forKey:(NSString *)key {
    NSString *groupKey = [NSString stringWithFormat:@"%@_%@",_group,key];
    [_store setInteger:data forKey:groupKey];
    [_store synchronize];
}



@end
