//
//  ClassesList.m
//  Class_Discussion
//
//  Created by sseverov on 4/7/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "ClassesList.h"
#import "StudentsList.h"

@interface ClassesList ()

@property (atomic)  NSMutableDictionary *classes;
@property UIBarButtonItem *emptyButton;

@end

@implementation ClassesList

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initializes the dictionary and links it to the plist file so all the changes are reflected there
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Classes" ofType:@"plist"];
    _classes=[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    //Initializing and placing the button to empty the list of the missing people
    _emptyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector (addItem:)];
    self.navigationItem.rightBarButtonItem = _emptyButton;
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getImageFilename:(NSString *)table//Picks pictures corresponding to the rows(tables)
{
    NSString *imageFilename = [[table lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    imageFilename = [imageFilename stringByAppendingString:@".jpg"];
    
    return imageFilename;
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
    return [_classes count];
}

//Creates cells in the table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *class = [[[_classes allKeys] sortedArrayUsingSelector:@selector(localizedStandardCompare:)] objectAtIndex:indexPath.row];
    cell.textLabel.text = class;
    cell.imageView.image = [UIImage imageNamed:[self getImageFilename:class]];
    
    return cell;
}

//What happens when the cell is pressed
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}


//Empties the list of working students
-(IBAction)emptyPressed:(id)sender{
    //Creates a path to the document with the names of missing students
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *finalPath = [documentsDirectory stringByAppendingPathComponent:@"Working Students.plist"];
    
    //Removes the file from the directory
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    [fileManager removeItemAtPath:finalPath error:&error];
    
    //Creates a new file in the documents directory
    NSString *defaultPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Working Students.plist"];//Path to a file in a bundle directory
    [fileManager copyItemAtPath:defaultPath toPath:finalPath error:&error];
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
