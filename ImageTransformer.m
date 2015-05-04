//
//  ImageTransformer.m
//  Class_Discussion
//
//  Created by sseverov on 4/28/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "ImageTransformer.h"
@import UIKit;

@implementation ImageTransformer

+ (Class)transformedValueClass{
    return [NSData class];
}

- (id) transformedValue:(id)value{
    if (!value) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSData class]]){
        return value;
    }

    return UIImagePNGRepresentation(value);
}

- (id) reverseTransformedValue:(id)value{
    return [UIImage imageWithData:value];
}

@end
