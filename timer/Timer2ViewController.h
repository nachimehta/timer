//
//  Timer2ViewController.h
//  timer
//
//  Created by Matthew Miller on 10/1/12.
//  Copyright (c) 2012 Treehousecs.jamesmatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerAppDelegate.h"

@interface Timer2ViewController : UIViewController
{
    
    UILabel *progress;
    NSTimer *timer;
    int currMinute;
    int currSeconds;
}

-(IBAction)cancel;
@end
