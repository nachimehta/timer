//
//  CrystalBallViewController.m
//  timer
//
//  Created by Matthew Miller on 9/30/12.
//  Copyright (c) 2012 Treehousecs.jamesmatt. All rights reserved.
//

#import "MainScreenViewController.h"

@interface MainScreenViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *uniformSwitch;
@property (weak, nonatomic) IBOutlet UILabel *timeDisplay;
@end



@implementation MainScreenViewController

@synthesize inputTextField;
@synthesize timeDisplay;
@synthesize datePicker;
@synthesize AM_Input;
@synthesize PM_Input;
@synthesize numAlarms;
@synthesize numDaysField;
-(void)awakeFromNib
{
}
-(void)goToTimer2{
    [self dateChange:(self.datePicker)];
    
    TimerAppDelegate *appDelegate = (TimerAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.textfield = inputTextField.text;
    appDelegate.am = AM_Input.text.integerValue;
    appDelegate.pm = PM_Input.text.integerValue;
    appDelegate.numAlarm= numAlarms.text.integerValue;
    appDelegate.numDays = numDaysField.text.integerValue;
    appDelegate.uniform = _uniformSwitch.on;
    
    UIStoryboard *timer2StoryBoard = [UIStoryboard storyboardWithName:@"Timer2Storyboard" bundle:nil];
    UIViewController *timer2VC =[timer2StoryBoard instantiateInitialViewController];
    timer2VC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:timer2VC animated:YES completion:nil];


}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hideKeyboard {
    [inputTextField resignFirstResponder];
    [AM_Input resignFirstResponder];
    [PM_Input resignFirstResponder];
    [numAlarms resignFirstResponder];
    [numDaysField resignFirstResponder];


}
- (IBAction)dateChange:(id)sender {
    UIDatePicker *picker = sender;
    NSString *hourString;
    NSString *minuteString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    hourString = [dateFormatter stringFromDate:picker.date];
    [dateFormatter setDateFormat:@"mm"];
    minuteString = [dateFormatter stringFromDate:picker.date];
    double minuteDouble = [minuteString doubleValue];
    int minuteInt=(int)(minuteDouble+(minuteDouble>0? 0.5:-0.5));
    double hourDouble = [hourString doubleValue];
    int hourInt=(int)(hourDouble+(hourDouble>0? 0.5:-0.5));
    TimerAppDelegate *appDelegate = (TimerAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.test = hourInt*60+minuteInt;
}

@end
