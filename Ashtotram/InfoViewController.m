//
//  InfoViewController.m
//  Ashtotram
//
//  Created by Manjunath Chandrashekar on 15/08/16.
//  Copyright (c) 2016 Great Apps. All rights reserved.
//

#import "InfoViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Ashtotram: InfoVC: viewDidLoad:");
    self.dp = [[FBSDKProfilePictureView alloc] init];
    self.username.text = @"Manjunath Chandrashekar";
    self.email.text = @"manjunathchandrashekarhere@ymail.com";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToList:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)logout:(id)sender   {
    AppDelegate *ad = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [ad.login logOut];
    if (![FBSDKAccessToken currentAccessToken]) {
        ad._loggedIn = NO;
    } else  {
        ad._loggedIn = YES;
    }
    if (!ad._loggedIn)  {
        NSLog(@"Ashtotram: InfoVC: logOut: Logged out successfully, displaying login screen.");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *vc =  (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self dismissViewControllerAnimated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"Ashtotram: InfoVC: logOut: dismissViewCtrlHandler: View Controller dismissed");
            [vc setModalPresentationStyle:UIModalPresentationFullScreen];
            [self.view.window.rootViewController presentViewController:vc animated:NO completion:nil];
        }];
        
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
