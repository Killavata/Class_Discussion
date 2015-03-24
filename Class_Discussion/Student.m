//
//  Student.m
//  Class_Discussion
//
//  Created by Hill, Oliver on 3/24/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Student.h"

@implementation Student : NSObject

@synthesize year;
@synthesize grade;
@synthesize fullName;

-(instancetype) init{
    self.fullName = nil;
    self.year = nil;
    return self;
}
-(instancetype)initWithName:(NSString *)studentName andYear:(NSInteger *)studentYear{
    self.year=studentYear;
    self.fullName = studentName;
    return self;
}

@end