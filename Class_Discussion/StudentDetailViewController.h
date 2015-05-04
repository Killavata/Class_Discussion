//
//  StudentDetailViewController.h
//  Class_Discussion
//
//  Created by sseverov on 5/1/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Student;

@interface StudentDetailViewController : UIViewController

@property (nonatomic,strong) Student *student;
@property (nonatomic, copy) void (^dismissBlock)(void);

- (instancetype)initForNewStudent:(BOOL)isNew;

@end
