//
//  DetailViewController.m
//  Ashtotram
//
//  Created by Manjunath Chandrashekar on 10/08/16.
//  Copyright (c) 2016 Great Apps. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"Ashtotram: DetailVC: viewDidAppear:");
    if(![FBSDKAccessToken currentAccessToken] && ![FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Ashtotram: DetailVC: viewDidAppear: Not Logged in, displaying login screen.");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *vc =  (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
        [self.view.window.rootViewController presentViewController:vc animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
