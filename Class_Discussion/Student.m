//
//  Student.m
//  Class_Discussion
//
//  Created by Hill, Oliver on 2/27/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "Student.h"

@implementation Student

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
