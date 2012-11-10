//
//  Timer2ViewController.m
//  timer
//
//  Created by Matthew Miller on 10/1/12.
//  Copyright (c) 2012 Treehousecs.jamesmatt. All rights reserved.
//

#import "Timer2ViewController.h"
#import "TimerAppDelegate.h"

@interface Timer2ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewer;
@end

@implementation Timer2ViewController
NSMutableArray *randomAlarmTimes;
-(void)cancel{
    TimerAppDelegate *appDelegate = (TimerAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.test=-2;
    appDelegate.test2=60;
    currMinute=-2;
    if (_imageViewer.isHidden==false){
        _imageViewer.hidden=TRUE;
    }
    [self dismissViewControllerAnimated:YES completion:Nil];

}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)pictureTapped:(UITapGestureRecognizer *)sender {
    
    _imageViewer.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	progress=[[UILabel alloc] initWithFrame:CGRectMake(110, 15, 200, 100)];
    progress.textColor=[UIColor redColor];
    progress.backgroundColor=[UIColor clearColor];
    [self.view addSubview:progress];
    TimerAppDelegate *appDelegate = (TimerAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.am!=0 && appDelegate.numAlarm!=0 &&appDelegate.pm!=0){
        int intAM=appDelegate.am;
        int intPM=appDelegate.pm;
        randomAlarmTimes =[[NSMutableArray alloc] init];
        for (int j = 0; j<appDelegate.numDays;j++){
            for (int i=0; i<appDelegate.numAlarm;i++){
                int tempHour=arc4random() % (intPM-intAM);
                int randomHour=(tempHour+intAM)%24;
                int randomMinute=(arc4random()%60);
                NSDate *today = [NSDate date];
                NSMutableString *desc = [NSMutableString stringWithString:[today description]];
                [desc replaceCharactersInRange:NSMakeRange(11,5) withString:[NSString stringWithFormat: @"%d:%d", randomHour,randomMinute]];
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit|NSDayCalendarUnit) fromDate:today];
                int day = [components day]+j;
                NSString *dayString;
                if (day < 10){
                    dayString = [NSString stringWithFormat:@"0%d",day];
                }
                else{
                    dayString = [NSString stringWithFormat:@"%d",day];
                }
                [desc replaceCharactersInRange:NSMakeRange(8,2) withString: dayString];
                NSDateFormatter *df=[[NSDateFormatter alloc] init];
                [df setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
                NSDate *date= [df dateFromString:desc];
                
            //NSDateComponents *randcomponents = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit|NSDayCalendarUnit) fromDate:today];
           // NSLog(@"%@",[date description]);
           // NSLog(@"%d,%d", randcomponents.day, randcomponents.hour);
                if ([randomAlarmTimes containsObject:date]){
                    i--;
                }
                else{
                    [randomAlarmTimes addObject:date];
                }
            }
        }
        appDelegate.numAlarm=appDelegate.numAlarm-1;
        [progress setText: [NSString stringWithFormat:@"%d times left.",[randomAlarmTimes count]]];
        [self startRandom];
    }
    else
    {if(!appDelegate.test2) {
        currSeconds= 60;
        [progress setText: @"Time: 1:00"];
    }else
    {
    currSeconds=appDelegate.test2;
    [progress setText:[NSString stringWithFormat:@"%@%d%@%02d",@"Time : ",appDelegate.test,@":",00]];
    }
    currMinute = appDelegate.test-1;
    [self start];
    }
}
-(void)start
{
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    
}
-(void)startRandom
{
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired2) userInfo:nil repeats:YES];
    }
-(void)timerFired2
{
    TimerAppDelegate *appDelegate= (TimerAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSLog(@"Running %d", appDelegate.test);
    
    if (appDelegate.test==-2){
        _imageViewer.hidden=true;
    }
  
    if([randomAlarmTimes count]>0){
        NSDate* currentDate=[NSDate date];
        for(int i =0; i < [randomAlarmTimes count]; i++){
            NSDate *temp = [randomAlarmTimes objectAtIndex:(i)];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *string=[dateFormatter stringFromDate:currentDate];
            NSString *hi = [[temp description] substringToIndex:(16)];
            //NSLog(@"description: %@ currTime: %@", hi,string);
            if ([string isEqualToString:hi]){
                NSLog(@"It worked!");
                _imageViewer.image=[UIImage imageNamed:@"images.png"];
                if ([_imageViewer isHidden])
                {
                    _imageViewer.hidden=false;
                }
                [randomAlarmTimes removeObject: [randomAlarmTimes objectAtIndex:(i)]];
            [progress setText:[NSString stringWithFormat:@"%d times left",[randomAlarmTimes count]]];
                appDelegate.test=-1;
                UIApplication* app = [UIApplication sharedApplication];
                UILocalNotification* alarm = [[UILocalNotification alloc] init];
                alarm.fireDate = nil;
                alarm.alertBody = @"Check timer!";
                [app presentLocalNotificationNow:(alarm)];
             }
        }
    }
NSLog(@"%d",appDelegate.test);

}
-(void)timerFired
{
    TimerAppDelegate *appDelegate = (TimerAppDelegate *)[[UIApplication sharedApplication] delegate];
    if((currMinute>0 || currSeconds>=0) && currMinute>=0)
    {
        if(currSeconds==0)
        {
            currMinute-=1;
            currSeconds=60;
            appDelegate.test=currMinute;
        }
        else if(currSeconds>0)
        {
            currSeconds-=1;
            appDelegate.test2= currSeconds;
        }
        if(currMinute>-1)
            [progress setText:[NSString stringWithFormat:@"%@%d%@%02d",@"Time : ",currMinute,@":",currSeconds]];
    }
    else if (currMinute==-2)
    {

    }
    else
    {
        UIApplication* app = [UIApplication sharedApplication];
        UILocalNotification* alarm = [[UILocalNotification alloc] init];
        alarm.fireDate = nil;
        alarm.alertBody = @"Check timer!";
        [app presentLocalNotificationNow:(alarm)];
        if (_imageViewer.isHidden==true)
        {
            _imageViewer.hidden=false;
        }
        _imageViewer.image=[UIImage imageNamed:@"images.png"];
        currMinute=-2;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
