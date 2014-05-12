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
- (IBAction)splitSlidder:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *sliderValue;
@property (weak, nonatomic) IBOutlet UILabel *splitLabel;
@property (weak, nonatomic) IBOutlet UILabel *billAfterSplitLabel;

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
   
    
   
}

- (void)viewDidAppear:(BOOL)animated {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int intValue = [defaults integerForKey:@"default_tip"];
 
    [self.tipControl setSelectedSegmentIndex:intValue];
    
    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)splitSlidder:(id)sender {
    int sliderValue;
    sliderValue = lroundf(self.sliderValue.value);
    [self.sliderValue setValue:sliderValue animated:YES];
    
    [self updateValues];
    
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

#pragma mark - Usr defined methods
-(void)updateValues
{
    float billAmount = [self.billTextField.text floatValue];
    float splitBy= self.sliderValue.value;
    
    NSArray *tipValue = @[@(0.1), @(0.15), @(0.2)];
   
    float billAfterSplit = (billAmount/splitBy);

    
    float tipAmount = billAfterSplit * [tipValue[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = billAfterSplit+tipAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.tipTotal.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    self.splitLabel.text = [NSString stringWithFormat:@"%0.0f", self.sliderValue.value];
    self.billAfterSplitLabel.text = [NSString stringWithFormat:@"$%0.2f",billAfterSplit];
}

- (void) onSettingsButton {
     [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
    
}
@end
