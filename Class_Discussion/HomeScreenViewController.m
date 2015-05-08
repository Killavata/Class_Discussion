//
//  HomeScreenViewController.m
//  Class_Discussion
//
//  Created by ohill on 5/6/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "TableViewController.h"
@interface HomeScreenViewController ()
- (IBAction)goToStudentScreen:(id)sender;


@end

@implementation HomeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//just for architecture purposes, will eventually be a table view
- (IBAction)goToStudentScreen:(id)sender {
    TableViewController *studentScreen = (TableViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"Student Screen"];
    [self.navigationController pushViewController:studentScreen animated:YES];
}
@end
