//
//  CrystalBallViewController.h
//  timer
//
//  Created by Matthew Miller on 9/30/12.
//  Copyright (c) 2012 Treehousecs.jamesmatt. All rights reserved.
//  chang

#import <UIKit/UIKit.h>
#import "TimerAppDelegate.h"
#import "Timer2ViewController.h"
@interface MainScreenViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *done;
@property (weak, nonatomic) IBOutlet UITextField *AM_Input;
@property (weak, nonatomic) IBOutlet UITextField *PM_Input;
@property (weak, nonatomic) IBOutlet UITextField *numAlarms;
@property (weak, nonatomic) IBOutlet UITextField *numDaysField;


- (IBAction)goToTimer2;
@end