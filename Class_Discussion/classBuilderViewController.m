//
//  classBuilderViewController.m
//  Class_Discussion
//
//  Created by Luke Bakker on 4/15/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "classBuilderViewController.h"

@interface classBuilderViewController ()

@end

@implementation classBuilderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint  touchPoint =[[touches anyObject]locationInView:self.view];
    [circle setCenter:touchPoint];
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
