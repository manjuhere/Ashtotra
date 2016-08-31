//
//  AshtotraInfo.h
//  Ashtotram
//
//  Created by Manjunath Chandrashekar on 26/08/16.
//  Copyright (c) 2016 Great Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AshtotraDatabase.h"
#import <sqlite3.h>

@interface AshtotraInfo : NSObject

@property (nonatomic) AshtotraDatabase *dbLink;
@property (nonatomic) NSMutableArray *languagesAvailable;
@property (nonatomic) NSString *prefLanguage;
@property (nonatomic) NSMutableArray *categories;
@property (nonatomic) NSDictionary *ashtotraName;
@property (nonatomic) NSString *ashtotraDetail;

+ (instancetype)sharedInstance;
- (NSMutableArray *) getAshtotraCategories;
- (NSDictionary *) getAshtotraList:(NSString *) s;
- (NSString *) getDetailAshtotra:(NSString *) s;

@end
