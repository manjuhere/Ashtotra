//
//  LoginViewController.m
//  Ashtotram
//
//  Created by Manjunath Chandrashekar on 10/08/16.
//  Copyright (c) 2016 Great Apps. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginButtonClicked:(id)sender
{
    if ([self loginFB]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

-(BOOL)loginFB  {
    AppDelegate *ad = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (![FBSDKAccessToken currentAccessToken]) {   //No FB Access token, so get the token.
        [ad.login logInWithReadPermissions: @[@"public_profile", @"email"]
                                handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                    if (error) {
                                        NSLog(@"Ashtotram: LoginVC: FbHandler: Process error");
                                        NSLog(@"Ashtotram: LoginVC: FbHandler: Unexpected login error: %@", error);
                                        NSString *alertMessage = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?: @"There was a problem logging in. Please try again later.";
                                        NSString *alertTitle = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops";
                                        [[[UIAlertView alloc] initWithTitle:alertTitle
                                                                    message:alertMessage
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil] show];
                                    } else if (result.isCancelled) {
                                        NSLog(@"Ashtotram: LoginVC: FbHandler: Login Cancelled");
                                        NSString *alertMessage = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?: @"Please Enable Permissions to Proceed further.";
                                        NSString *alertTitle = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Permission Denied";
                                        [[[UIAlertView alloc] initWithTitle:alertTitle
                                                                    message:alertMessage
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil] show];
                                        
                                    } else {
                                        NSLog(@"Ashtotram: LoginVC: FbHandler: Logged in Successfully ");
                                        NSLog(@"Ashtotram: LoginVC: FbHandler: Logged in with User ID : %@", result.token.userID);
                                        NSLog(@"Ashtotram: LoginVC: FbHandler: Logged in with token : %@", [FBSDKAccessToken currentAccessToken]);
                                        ad._loggedIn = YES;
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                    }
                                }];
    } else  {   //FB Token exists so set authenticated as true
        NSLog(@"Ashtotram: LoginVC: Logged in with token : %@", [FBSDKAccessToken currentAccessToken]);
        ad._loggedIn = YES;
    }
    return ad._loggedIn;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
