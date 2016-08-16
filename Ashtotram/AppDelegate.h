//
//  AppDelegate.h
//  Ashtotram
//
//  Created by Manjunath Chandrashekar on 10/08/16.
//  Copyright (c) 2016 Great Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBSDKLoginKit/FBSDKLoginKit.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic) BOOL _loggedIn;
@property (strong, nonatomic) FBSDKLoginManager *login;
@property (strong, nonatomic) UIWindow *window;


@end

