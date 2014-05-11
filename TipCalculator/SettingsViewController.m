//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Bhargava, Rajat on 5/7/14.
//  Copyright (c) 2014 rnb. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
-(void)onDone;
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;
- (IBAction)defaultTipAction:(id)sender;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(onDone)];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int intValue = [defaults integerForKey:@"default_tip"];
    NSLog(@"Saved value:%d", intValue);
    if(intValue){
        //select the segment
        [self.defaultTipControl setSelectedSegmentIndex:intValue];
         NSLog(@"I am in value:%d", intValue);
    }
    
    //Load the current default value. Select it.
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Defined Methods
-(void)onDone
{
    //Save the default
    int selectedSegmentIndex = self.defaultTipControl.selectedSegmentIndex;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:selectedSegmentIndex forKey:@"default_tip"];
    [defaults synchronize];
    NSLog(@"Default Index:%d", selectedSegmentIndex);
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (IBAction)defaultTipAction:(id)sender {
}
@end
