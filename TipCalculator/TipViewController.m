//
//  TipViewController.m
//  TipCalculator
//
//  Created by Bhargava, Rajat on 5/6/14.
//  Copyright (c) 2014 rnb. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipTotal;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)onSettingsButton;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    NSLog(@"I am in View Did load");
    
   
}

- (void)viewDidAppear:(BOOL)animated {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int intValue = [defaults integerForKey:@"default_tip"];
    NSLog(@"This is the int value:%d", intValue);
    NSLog(@"Saved value:%d", intValue);
    //if(intValue!=0){
        //select the segment
        [self.tipControl setSelectedSegmentIndex:intValue];
        NSLog(@"I am in the main page:%d", intValue);
   // }
    
    
    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

#pragma mark - Usr defined methods
-(void)updateValues
{
    float billAmount = [self.billTextField.text floatValue];
    
    NSArray *tipValue = @[@(0.1), @(0.15), @(2.0)];
    float tipAmount = billAmount* [tipValue[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = billAmount+tipAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.tipTotal.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void) onSettingsButton {
     [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
    
}
@end
