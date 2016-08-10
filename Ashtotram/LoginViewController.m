//
//  LoginViewController.m
//  Ashtotram
//
//  Created by Manjunath Chandrashekar on 10/08/16.
//  Copyright (c) 2016 Great Apps. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (nonatomic) BOOL loginStatus;

@end

@implementation LoginViewController {
    NSArray *ashList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ashList = [NSArray arrayWithObjects:@"Shiva", @"Ganesh", @"Lakshmi",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginButtonClicked:(id)sender
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    if (![FBSDKAccessToken currentAccessToken]) {
        [login logInWithReadPermissions: @[@"public_profile", @"email"]
                                handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                    if (error) {
                                        NSLog(@"Process error");
                                        NSLog(@"Unexpected login error: %@", error);
                                        NSString *alertMessage = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?: @"There was a problem logging in. Please try again later.";
                                        NSString *alertTitle = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops";
                                        [[[UIAlertView alloc] initWithTitle:alertTitle
                                                                    message:alertMessage
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil] show];
                                    } else if (result.isCancelled) {
                                        NSLog(@"Cancelled");
                                        NSString *alertMessage = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?: @"Please Enable Permissions to Proceed further.";
                                        NSString *alertTitle = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Permission Denied";
                                        [[[UIAlertView alloc] initWithTitle:alertTitle
                                                                    message:alertMessage
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil] show];
                                        
                                    } else {
                                        NSLog(@"Logged in");
                                        NSLog(@"Result : %@", result.token);
                                        self.loginStatus = YES;
                                        [self loadDestinationVC];
                                    }
                                }];
    }
}

-(void)loadDestinationVC{
    if(self.loginStatus == YES){
        [self shouldPerformSegueWithIdentifier:@"loginConditionSegue" sender:self];
    }
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
