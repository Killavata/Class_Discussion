//
//  StudentImageViewController.m
//  Class_Discussion
//
//  Created by sseverov on 5/4/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "StudentImageViewController.h"

@interface StudentImageViewController ()

@end

@implementation StudentImageViewController

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //We must cast the view to UIImageView so the compiler knows it's okay to send it setImage
    UIImageView *imageView = (UIImageView *) self.view;
    imageView.image = self.image;
}

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

@end
