//
//  CrystalBallAppDelegate.h
//  timer
//
//  Created by Matthew Miller on 9/30/12.
//  Copyright (c) 2012 Treehousecs.jamesmatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerAppDelegate : UIResponder <UIApplicationDelegate>
{
    int test;
    NSTimer *timer;
    int test2;
    NSString *textfield;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) int test;
@property (nonatomic) int test2;
@property (nonatomic) NSString *textfield;
@property (nonatomic) int am;
@property (nonatomic) int pm;
@property (nonatomic) int numAlarm;
@property (nonatomic) int numDays;
@property (nonatomic) bool uniform;

@end
