//
//  Section.m
//  Class_Discussion
//
//  Created by Luke Bakker on 2/27/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "Section.h"
@import CoreData;

@interface Section()

@end

@implementation Section

-(void) awakeFromInsert{
    [super awakeFromInsert];
    
    
    //Create an NSUUID object - and get its string representation
    NSUUID *uuid = [[NSUUID alloc] init];
    NSString *key = [uuid UUIDString];
    self.sectionKey = key;
}

@end
