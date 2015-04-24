//
//  TimerViewController.m
//  Class_Discussion
//
//  Created by Luke Bakker on 4/6/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController (){
    int counter;
    __weak IBOutlet UILabel *timer;
}
@end

@implementation TimerViewController

@synthesize timer;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Stop:(id)sender {
    
        [_theTime invalidate];
    
}
- (IBAction)startTimer:(id)sender {
    _theTime= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown)userInfo:nil repeats:YES];
   
    
}
-(void)countDown{
    _timeInt++;
     timer.text= [NSString stringWithFormat:@" %i",_timeInt];
    
}
- (IBAction)goToTableCreator:(id)sender {
    UIViewController *tableBuilder = (UIViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"table builder"];
    [self.navigationController pushViewController:tableBuilder animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
