//
//  TimerViewController.h
//  Class_Discussion
//
//  Created by Luke Bakker on 4/6/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *timer;
@property NSTimer * theTime;
@property int timeInt;
@end
