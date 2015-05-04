//
//  Student.m
//  Class_Discussion
//
//  Created by sseverov on 4/28/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "Student.h"
@import CoreData;


@implementation Student

@dynamic fullName;
@dynamic year;
@dynamic grade;
@dynamic thumbnail;
@dynamic dateCreated;
@dynamic studentKey;
@dynamic orderingValue;

@dynamic section;

-(void) setThumbnailFromImage:(UIImage *)image{
    CGSize origImageSize = image.size;
    
    //The rectangle of the thumbnail
    CGRect newRect = CGRectMake(0, 0, 40, 40);
    
    //Figure out a scaling ratio to make sure we maintain the same aspect ratio
    float ratio = MAX(newRect.size.width / origImageSize.width, newRect.size.height / origImageSize.height);
    
    //Create a transparent bitmap context with a scaling factor
    //equal to that of the screen
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
    //Create a path that is a rounded rectangle
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect  cornerRadius:5.0];
    
    //Make all subsequent drawing clip to this rounded rectangle
    [path addClip];
    
    //Center the image in the thumbnail rectangle
    CGRect projectRect;
    projectRect.size.width = ratio * origImageSize.width;
    projectRect.size.height = ratio * origImageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width)/2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height)/2.0;
    
    //Draw the image on it
    [image drawInRect:projectRect];
    
    //Get the image from the image context; keep it as our thumbnail
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    self.thumbnail = smallImage;
    
    //Cleanup image context resources; We're done
    UIGraphicsEndImageContext();
    
}

-(void) awakeFromInsert{
    [super awakeFromInsert];
    
    self.dateCreated = [NSDate date];
    
    //Create an NSUUID object - and get its string representation
    NSUUID *uuid = [[NSUUID alloc] init];
    NSString *key = [uuid UUIDString];
    self.studentKey = key;
}




@end
