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

- (void)loadView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.view = imageView;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //We must cast the view to UIImageView so the compiler knows it's okay to send it setImage
    UIImageView *imageView = (UIImageView *) self.view;
    imageView.image = self.image;
}





@end
