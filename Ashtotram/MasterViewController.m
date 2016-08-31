//
//  MasterViewController.m
//  Ashtotram
//
//  Created by Manjunath Chandrashekar on 10/08/16.
//  Copyright (c) 2016 Great Apps. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "LoginViewController.h"
#import "InfoViewController.h"
#import "AshtotraDatabase.h"
#import "AppDelegate.h"

@interface MasterViewController ()

@property NSDictionary *objects;
@property NSArray *sectionTitles;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}
- (void) viewWillAppear:(BOOL)animated  {
    [super viewDidAppear:animated];
    AshtotraInfo *info = [AshtotraInfo sharedInstance];
    NSDictionary *array = [info getAshtotraList:info.prefLanguage];
    self.objects = array;
    self.sectionTitles = [[self.objects allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self.tableView reloadData];
    
    NSLog(@"Ashtotram: MasterVC: viewWillAppear:");
    AppDelegate *ad = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(!ad._loggedIn && ![FBSDKAccessToken currentAccessToken])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *vc =  (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        NSLog(@"Ashtotram: MasterVC: viewDidAppear: Not Logged in, putting up login screen.");
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:vc animated:YES completion:nil];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *sectionTitle = [self.sectionTitles objectAtIndex:indexPath.section];
        NSArray *sectionNames = [self.objects objectForKey:sectionTitle];
        NSString *name = [sectionNames objectAtIndex:indexPath.row];

        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:name];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
        
        //Animate the split view controller going out of view
        if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
            [UIView animateWithDuration:0.5 animations:^{
                self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
            } completion:^(BOOL finished) {
                self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAutomatic;
            }];
        }
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitles.count;
}
- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    return [self.sectionTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionTitle = [self.sectionTitles objectAtIndex:section];
    NSArray *sectionNames = [self.objects objectForKey:sectionTitle];
    return sectionNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //NSString *object = @"HEllo";//self.objects[indexPath.row];
    
    NSString *sectionTitle = [self.sectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionNames = [self.objects objectForKey:sectionTitle];
    NSString *name = [sectionNames objectAtIndex:indexPath.row];
    cell.textLabel.text = name;
    
    //cell.textLabel.text = [object description];
    return cell;
}

@end
