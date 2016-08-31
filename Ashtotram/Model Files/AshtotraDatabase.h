//
//  AshtotraDatabase.h
//  Ashtotram
//
//  Created by Manjunath Chandrashekar on 26/08/16.
//  Copyright (c) 2016 Great Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface AshtotraDatabase : NSObject  {
    sqlite3 *database;
}
- (NSMutableArray *)getAshtotraLanguages;
- (NSMutableArray *)getAshtotraCategories;
- (NSDictionary *)getAshtotraNames: (NSString *) lang;
- (NSString *)getAshtotraDetails:(NSString *)name;

@end
