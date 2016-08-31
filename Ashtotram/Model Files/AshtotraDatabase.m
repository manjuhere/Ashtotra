//
//  AshtotraDatabase.m
//  Ashtotram
//
//  Created by Manjunath Chandrashekar on 26/08/16.
//  Copyright (c) 2016 Great Apps. All rights reserved.
//

#import "AshtotraDatabase.h"
#import "AshtotraInfo.h"

@implementation AshtotraDatabase

- (id) init {
    if ((self = [super init])) {
        [self openDB];
    }
    return self;
}

-(void) openDB  {
    @try    {
        //open file manager and get database from mainBundle path.
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:@"ashtotra_db.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)    {
            NSLog(@"Cannot locate database file '%@'.", dbPath);
        }
        if(!(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK))    {
            NSLog(@"An error has occurred.");
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        NSLog(@"Connected to Database uccessfully ");
    }

}

-(sqlite3_stmt *) performQuery: (const char *) query    {
    sqlite3_stmt *sqlStatement;
    if(sqlite3_prepare(database, query, -1, &sqlStatement, NULL) != SQLITE_OK)    {
        NSLog(@"Problem with prepare statement");
    }
    return sqlStatement;
}

- (NSMutableArray *) getAshtotraLanguages   {
    NSMutableArray *ashArray = [[NSMutableArray alloc] init];
    @try    {
        //if file successfully obtained and databse opened, query for all available tables
        NSString *query = @"SELECT tbl_name FROM sqlite_master WHERE type = 'table';";
        sqlite3_stmt *sqlStatement = [self performQuery:[query UTF8String]];
        //get all languages available (tables) and put it into array.
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            NSString *language = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,0)];
            [ashArray addObject:language];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        return ashArray;
    }
}

- (NSMutableArray *)getAshtotraCategories   {
    NSMutableArray *ashArray = [[NSMutableArray alloc] init];
    @try {
        NSString *query =[NSString stringWithFormat:@"SELECT category FROM %@;", [AshtotraInfo sharedInstance].prefLanguage];
        sqlite3_stmt *sqlStatement = [self performQuery:[query UTF8String]];
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            NSString *ctgr = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,0)];
            if (![ashArray containsObject:ctgr])    {
                [ashArray addObject:ctgr];
            }
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        return ashArray;
        
    }
}

- (NSDictionary *) getAshtotraNames: (NSString *) lang  {
    NSMutableDictionary *ashDict = [[NSMutableDictionary alloc] init];
    @try {
        for (NSString *x in [AshtotraInfo sharedInstance].getAshtotraCategories)   {
            NSMutableArray *names = [[NSMutableArray alloc] init];
            NSString *query =[NSString stringWithFormat:@"SELECT name FROM %@ WHERE category='%@';", lang,x];
            sqlite3_stmt *sqlStatement = [self performQuery:[query UTF8String]];
            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                NSString *name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,0)];
                if (![names containsObject:name])   {
                    [names addObject:name];
                }
                NSString *ctgr = [x stringByReplacingOccurrencesOfString:@"doc_" withString:@""].capitalizedString;
                [ashDict setObject:names forKey:ctgr];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        return ashDict;
    }
}

- (NSString *) getAshtotraDetails:(NSString *) name  {
    NSString *ashDetails = [[NSString alloc] init];
    @try {
        NSString *query =[NSString stringWithFormat:@"SELECT detail FROM %@ WHERE name='%@';", [AshtotraInfo sharedInstance].prefLanguage, name];
        sqlite3_stmt *sqlStatement = [self performQuery:[query UTF8String]];
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            NSString *names = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,0)];
            ashDetails = [names stringByReplacingOccurrencesOfString:@"।" withString:@"।\n"];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        return ashDetails;
    }
}

@end
