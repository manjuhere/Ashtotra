//
//  InfoViewController.h
//  Ashtotram
//
//  Created by Manjunath Chandrashekar on 15/08/16.
//  Copyright (c) 2016 Great Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBSDKCoreKit/FBSDKCoreKit.h"
#import "AshtotraInfo.h"
@interface InfoViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) AshtotraInfo *info;
@property (retain) IBOutlet UIView *dp;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

- (IBAction)backToList:(UIBarButtonItem *)sender;
- (IBAction)logout:(id)sender;

@end
