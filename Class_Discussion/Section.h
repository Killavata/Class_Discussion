//
//  Section.h
//  Class_Discussion
//
//  Created by Luke Bakker on 2/27/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Section : NSManagedObject

@property (nonatomic, retain) NSString * sectionName;
@property (nonatomic,strong) NSString * sectionKey;
@property (nonatomic) double orderingValue;

@property (nonatomic, retain) NSManagedObject *student;

@end
