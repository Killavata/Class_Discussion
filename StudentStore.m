//
//  StudentStore.m
//  Class_Discussion
//
//  Created by sseverov on 5/1/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "StudentStore.h"
#import "Student.h"
#import "StudentImageStore.h"

@import CoreData;

@interface StudentStore()

@property (nonatomic) NSMutableArray *privateStudents;//Needed so we can change an array inside the class
@property (nonatomic, strong) NSMutableArray *allAssetTypes;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;

@end

@implementation StudentStore

+ (instancetype) sharedStore{
    static StudentStore *sharedStore = nil;
    
    //Do we need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

- (instancetype) initPrivate{
    self = [super init];
    if (self){
        //Read Class_Discussion.xcdatamodeld
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        
        //Where does the SQLite file go?
        NSString *path = self.itemArchivePath;
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error]) {
            @throw [NSException exceptionWithName:@"OpenFailure"
                                           reason:[error localizedDescription] userInfo:nil];
        }
        
        //Create the managed object context
        _context = [[NSManagedObjectContext alloc] init];
        _context.persistentStoreCoordinator = psc;
        
        [self loadAllItems];
    }
    
    return self;
}


//Returns real array when addressed from outside
- (NSArray *) allStudents{
    return [self.privateStudents copy];
}

- (Student *) createStudent{
    double order;
    if ([self.allStudents count] == 0){
        order = 1.0;
    }
    else{
        order = [[self.privateStudents lastObject] orderingValue] + 1.0;
    }
    NSLog(@"Adding after %lu items, order = %.2f", [self.privateStudents count], order);
    
    Student *newStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.context];
    
    newStudent.orderingValue = order;
    
    [self.privateStudents addObject:newStudent];
    
    return newStudent;
  
}


- (void) removeStudent:(Student *)student{
    NSString *key = student.studentKey;
    
    [[StudentImageStore sharedStore] deleteImageForKey:key];
    
    [self.context deleteObject:student];
    [self.privateStudents removeObjectIdenticalTo:student];
}


-(void) moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex{
    if (fromIndex==toIndex){
        return;
    }
    
    //Get pointer to object being moved so you can re-insert it
    Student *student = self.privateStudents[fromIndex];
    
    //Remove item from array
    [self.privateStudents removeObjectAtIndex:fromIndex];
    
    //Insert it at new location
    [self.privateStudents insertObject:student atIndex:toIndex];
    
    // Computing a new orderValue for the object that was moved
    double lowerBound = 0.0;
    
    // Is there an object before it in the array?
    if (toIndex > 0) {
        lowerBound = [self.privateStudents[(toIndex - 1)] orderingValue];
    } else {
        lowerBound = [self.privateStudents[1] orderingValue] - 2.0;
    }
    
    double upperBound = 0.0;
    
    // Is there an object after it in the array?
    if (toIndex < [self.privateStudents count] - 1) {
        upperBound = [self.privateStudents[(toIndex + 1)] orderingValue];
    } else {
        upperBound = [self.privateStudents[(toIndex - 1)] orderingValue] + 2.0;
    }
    
    double newOrderValue = (lowerBound + upperBound) / 2.0;
    
    NSLog(@"moving to order %f", newOrderValue);
    student.orderingValue = newOrderValue;

}


//SAVING AND LOADING DATA

- (NSString *)itemArchivePath
{
    // Make sure that the first argument is NSDocumentDirectory
    // and not NSDocumentationDirectory
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // Get the one document directory from that list
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (BOOL) saveChanges{
    NSError *error;
    BOOL successfull = [self.context save:&error];
    if (!successfull){
        NSLog (@"Error saving: %@", [error localizedDescription]);
    }
    
    return successfull;
}

- (void)loadAllItems
{
    if (!self.privateStudents) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"Student"
                                             inManagedObjectContext:self.context];
        
        request.entity = e;
        
        NSSortDescriptor *sd = [NSSortDescriptor
                                sortDescriptorWithKey:@"orderingValue"
                                ascending:YES];
        
        request.sortDescriptors = @[sd];
        
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        self.privateStudents = [[NSMutableArray alloc] initWithArray:result];
    }
}



@end
