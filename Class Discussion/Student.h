//
//  Student.h
//  Class Discussion
//
//  Created by Hill, Oliver on 3/23/15.
//  Copyright (c) 2015 Oliver Hill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Student : NSObject
@property NSInteger *grade;
@property NSInteger *year;//1,2,3 or 4 to denote freshman, sophomore, junior, senior.
@property NSString *fullName;

-(instancetype)init;
-(instancetype)initWithName:(NSString *)studentName andYear:(NSInteger *)studentYear;



//@property UIImage *studentPic;

//Possible addition: Array of classes the student is taking

@end