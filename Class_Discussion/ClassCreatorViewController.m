//
//  ClassCreatorViewController.m
//  Class_Discussion
//
//  Created by Luke Bakker on 4/29/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "ClassCreatorViewController.h"

@interface ClassCreatorViewController ()

@end

@implementation ClassCreatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    students=[[NSMutableArray alloc] init];
    for(int i=0; i<10; i++){
    student= [[UIButton alloc]initWithFrame:CGRectMake(100, 140, 100, 100)];
    [student setBackgroundImage:[UIImage imageNamed:@"table.png"] forState:UIControlStateNormal];
    [student addTarget:self action:@selector(studentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [students addObject: student];
   // [[students objectAtIndex:i] setTitle:@" " forState:UIControlStateNormal];
    [self.view addSubview:student];
    }
    clickCounter=0;
    clickMe = [[UIButton alloc]initWithFrame:CGRectMake(50, 70, 200, 300)];
    [clickMe setBackgroundImage:[UIImage imageNamed: @"table.png"]forState:UIControlStateNormal];
    [clickMe addTarget:self action:@selector(tableButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickMe];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)tableButtonClick:(id)sender{
    if(clickCounter==0){
    CGRect buttonFrame =clickMe.frame;
    buttonFrame.origin.x=startPoint.x-buttonFrame.size.width/2;
    buttonFrame.origin.y=startPoint.y-buttonFrame.size.height/2;
    clickMe.frame=buttonFrame;
    clickCounter++;
    }
}
-(IBAction)studentButtonClick:(id)sender{
    
    if(clickCounter>0 && clickCounter <students.count){
            student=[students objectAtIndex:clickCounter];
            CGRect buttonFrame =student.frame;
            buttonFrame.origin.x=startPoint.x-buttonFrame.size.width/2;
            buttonFrame.origin.y=startPoint.y-buttonFrame.size.height/2;
            student.frame=buttonFrame;
            clickCounter++;
        }

    }
-(void)timerTick{
    
}
    -(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
        
        startPoint =[[touches anyObject]locationInView:ClassCreator];
        if(clickCounter==0){
            CGRect buttonFrame =clickMe.frame;
            buttonFrame.origin.x=startPoint.x-buttonFrame.size.width/2;
            buttonFrame.origin.y=startPoint.y-buttonFrame.size.height/2;
            clickMe.frame=buttonFrame;
        }
        else if (clickCounter>0&& clickCounter<students.count){
            CGRect buttonFrame =student.frame;
            buttonFrame.origin.x=startPoint.x-buttonFrame.size.width/2;
            buttonFrame.origin.y=startPoint.y-buttonFrame.size.height/2;
            student.frame=buttonFrame;
        }
    }
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    startPoint =[[touches anyObject]locationInView:ClassCreator];
    
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
