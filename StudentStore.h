//
//  StudentStore.h
//  Class_Discussion
//
//  Created by sseverov on 5/1/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Student;

@interface StudentStore : NSObject

@property (nonatomic,strong,readonly) NSArray *allStudents;//Immutable so can't be changed outside of the class

+ (StudentStore *) sharedStore;
- (Student *) createStudent;
- (void) removeStudent: (Student*) student;
- (void) moveItemAtIndex:(NSUInteger) fromIndex toIndex:(NSUInteger)toIndex;

@end
