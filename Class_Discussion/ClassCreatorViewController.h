//
//  ClassCreatorViewController.h
//  Class_Discussion
//
//  Created by Luke Bakker on 4/29/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassCreatorViewController : UIViewController{
    UIView *ClassCreator;
    CGPoint startPoint;
    CGRect table;
    UIButton *clickMe;
    UIButton *student;
    NSTimer  * moveTimer;
    int clickCounter;
    IBOutletCollection(UIButton) NSMutableArray *students;
    
    }

-(IBAction) tableButtonClick :(id)sender;
-(void)timerTick;
-(IBAction)studentButtonClick:(id)sender;
@end
