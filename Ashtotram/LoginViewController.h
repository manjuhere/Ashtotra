//
//  LoginViewController.h
//  Ashtotram
//
//  Created by Manjunath Chandrashekar on 10/08/16.
//  Copyright (c) 2016 Great Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginButtonClicked:(id)sender;
@end
