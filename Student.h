//
//  Student.h
//  Class_Discussion
//
//  Created by sseverov on 4/28/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@import UIKit;


@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * fullName;
@property (nonatomic) int  grade;
@property (nonatomic,retain) NSString * year;
@property (nonatomic,strong) NSDate * dateCreated;
@property (nonatomic,strong) NSString * studentKey;
@property (nonatomic, retain) UIImage* thumbnail;
//@property (nonatomic, strong) NSData * thumbnailData;
@property (nonatomic) double orderingValue;

@property (nonatomic, retain) NSManagedObject *section;

- (void) setThumbnailFromImage: (UIImage *) image;


@end
