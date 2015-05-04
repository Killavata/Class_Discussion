//
//  StudentImageStore.m
//  Class_Discussion
//
//  Created by sseverov on 5/4/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "StudentImageStore.h"

@interface StudentImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation StudentImageStore

+ (instancetype)sharedStore
{
    static StudentImageStore *sharedStore;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

// No one should call init
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[StudentImageStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

// Secret designated initializer
- (instancetype)initPrivate
{
    self = [super init];
    
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    self.dictionary[key] = image;
}

- (UIImage *)imageForKey:(NSString *)key
{
    return self.dictionary[key];
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
}

@end
