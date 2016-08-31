//
//  AshtotraInfo.m
//  Ashtotram
//
//  Created by Manjunath Chandrashekar on 26/08/16.
//  Copyright (c) 2016 Great Apps. All rights reserved.
//

#import "AshtotraInfo.h"

@implementation AshtotraInfo

@synthesize dbLink;
@synthesize languagesAvailable;
@synthesize prefLanguage;
@synthesize categories;
@synthesize ashtotraName;
@synthesize ashtotraDetail;

+ (instancetype)sharedInstance
{
    static AshtotraInfo *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AshtotraInfo alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}


-(id) init {
    if ((self = [super init])) {
        dbLink = [[AshtotraDatabase alloc] init];
        self.languagesAvailable = [dbLink getAshtotraLanguages];
        self.prefLanguage = [self.languagesAvailable objectAtIndex:1];
    }
    return self;
}

-(NSMutableArray *) getAshtotraCategories   {
    self.categories = [dbLink getAshtotraCategories];
    return self.categories;
}

-(NSDictionary *) getAshtotraList:(NSString *)s   {
    self.ashtotraName = [dbLink getAshtotraNames:s];
    return self.ashtotraName;
}

- (NSString *) getDetailAshtotra:(NSString *) s {
    self.ashtotraDetail = [dbLink getAshtotraDetails:s];
    return self.ashtotraDetail;
}
- (void) dealloc {
    self.prefLanguage = nil;
    self.languagesAvailable = nil;
    self.ashtotraName = nil;
    self.ashtotraDetail = nil;
}

@end
