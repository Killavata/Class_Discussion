//
//  Section.h
//  Class_Discussion
//
//  Created by Luke Bakker on 2/25/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject
@property NSMutableArray *students;
-(Student)getStudent:(int) x ;
@end
