//
//  StudentsList.m
//  Class_Discussion
//
//  Created by sseverov on 4/20/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "StudentsList.h"

@interface StudentsList ()

@property NSArray *names;
@property NSMutableArray *workingStudents;
@property NSIndexPath *checkedIndexPath;

@end

@implementation StudentsList

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Sets the name of the particular table on the top
    self.navigationItem.title=self.className;
    
    //Initializes the dictionary and links it to the plist file so all the changes are reflected there
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Classes" ofType:@"plist"];
    NSMutableDictionary *classes=[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    //Initializes an array with names
    _names=[classes objectForKey:self.className];
    
    //Initializes an array with missing students
    
    //Indicates path to the file
    NSString *filePath=[self plistFileDocumentPath:@"Working Students.plist"];
    
    //Initializes an array with already existing data
    _workingStudents = [[NSMutableArray alloc] initWithContentsOfFile: filePath];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

// Specializes the number of sections in the table.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//Specializes how many rows there are in each section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.className isEqualToString:@"Working"]){
        return _workingStudents.count;
    }
    else{
        return _names.count;
    }
}


//Creates cells in the table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell" forIndexPath:indexPath];
    NSString *name;
    
    // Configure the cell...
    if ([self.className isEqualToString:@"Working"]){
        name = [[_workingStudents sortedArrayUsingSelector:@selector(localizedStandardCompare:)] objectAtIndex:indexPath.row];
    }
    else{
        name = [[_names sortedArrayUsingSelector:@selector(localizedStandardCompare:)] objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = name;
    
    
    return cell;
}

//What happens when the cell is pressed
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self.className isEqualToString:@"Working"]){//Works if we are not in the "Working" category
        NSString *name = [[_names sortedArrayUsingSelector:@selector(localizedStandardCompare:)] objectAtIndex:indexPath.row];
        
        //Puts or removes a check next to the cell
        UITableViewCell* cell=[tableView cellForRowAtIndexPath:indexPath];
        if([_checkedIndexPath isEqual:indexPath])
        {
            cell.accessoryType=UITableViewCellAccessoryNone;
            _checkedIndexPath=nil;
            [self missingStudent:name action:@"remove"];//Removes student from a file
        }
        else
        {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            _checkedIndexPath=indexPath;
            [self missingStudent:name action:@"add"];//Adds working student to a file
        }
    }
    
    
}

//Programmed methods

-(void) missingStudent:(NSString*) name action:(NSString*) action{//Writes data to the file
    //Creates copy of the file
    [self createPlistCopyInDocuments:@"Working Students.plist"];
    
    //Indicates path to which we will write to
    NSString *filePath=[self plistFileDocumentPath:@"Working Students.plist"];
    
    //Adds name to the list if we need to add it
    if ([action isEqualToString:@"add"]){
        [_workingStudents addObject:name];
    }
    
    //Removes occurenses of the same name
    [_workingStudents setArray:[[NSOrderedSet  orderedSetWithArray:_workingStudents] array]];//Removes duplicates
    
    //Writes to a file
    [_workingStudents writeToFile:filePath atomically:YES];
}


//Path to the file in documents directory. Path to the file with missing students
-(NSString*) plistFileDocumentPath:(NSString*) plistName{
    
    //Create a list of paths
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //Get a path to a documents directory
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //Create a full file path
    NSString *writablePath = [documentsDirectory stringByAppendingPathComponent:@"Working Students.plist"];
    
    
    return writablePath;
}


//Creates a copy of plist file
- (void)createPlistCopyInDocuments:(NSString *)plistName{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSString *plistFilePath = [self plistFileDocumentPath:plistName];
    
    success = [fileManager fileExistsAtPath:plistFilePath];//Checks if file on the specified path exists
    
    if (success) {//If exists then no need to create copy
        return;
    }
    
    //If file doesn't exist
    NSString *defaultPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:plistName];//Path to a file in a bundle directory
    success = [fileManager copyItemAtPath:defaultPath toPath:plistFilePath error:&error];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
