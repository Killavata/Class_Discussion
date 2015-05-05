//
//  StudentsList.m
//  Class_Discussion
//
//  Created by sseverov on 4/20/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "StudentsList.h"
#import "StudentCell.h"
#import "Student.h"
#import "StudentStore.h"
#import "StudentDetailViewController.h"
#import "StudentImageStore.h"
#import "StudentImageViewController.h"


@interface StudentsList () <UIPopoverControllerDelegate>

@property (nonatomic,strong) UIPopoverController *imagePopover;



@end

@implementation StudentsList

- (instancetype) init{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Students";
        
        //Create a new bar button item that will add new item
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewStudent:)];
        
        //Set this bar button item as the right item in the navigationItem
        navItem.rightBarButtonItem = bbi;
        
        //Set the edit button
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Load the NIB file
    UINib *nib = [UINib nibWithNibName:@"StudentCell" bundle:nil];
    
    //Register this NIB, which contains the cell
    [self.tableView registerNib:nib forCellReuseIdentifier:@"StudentCell"];
    
    
    
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
    return [[[StudentStore sharedStore] allStudents] count];//Counts the number of students
}


//Creates cells in the table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell" forIndexPath:indexPath];
    
    NSArray *students = [[StudentStore sharedStore] allStudents];
    Student *student = students[indexPath.row];
    
    //Configure the cell with the students info
    cell.nameLabel.text = student.fullName;
    cell.thumbnailView.image = student.thumbnail;
    
    __weak StudentCell *weakCell = cell;
    
    cell.actionBlock = ^{
        NSLog(@"Going to show image for %@", student);
        
        StudentCell *strongCell = weakCell;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            NSString *studentKey = student.studentKey;
            
            // If there is no image, we don't need to display anything
            UIImage *img = [[StudentImageStore sharedStore] imageForKey:studentKey];
            if (!img) {
                return; }
            
            // Make a rectangle for the frame of the thumbnail relative to
            // our table view
            CGRect rect = [self.view convertRect:strongCell.thumbnailView.bounds
                                        fromView:strongCell.thumbnailView];
            
            // Create a new BNRImageViewController and set its image
            StudentImageViewController *ivc = [[StudentImageViewController alloc] init];
            ivc.image = img;
            
            // Present a 600x600 popover from the rect
            self.imagePopover = [[UIPopoverController alloc]
                                 initWithContentViewController:ivc];
            self.imagePopover.delegate = self;
            self.imagePopover.popoverContentSize = CGSizeMake(600, 600);
            [self.imagePopover presentPopoverFromRect:rect
                                               inView:self.view
                             permittedArrowDirections:UIPopoverArrowDirectionAny
                                             animated:YES];
        }
    };

    
    return cell;
}

//What happens when the cell is pressed
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    StudentDetailViewController *detailViewController = [[StudentDetailViewController alloc] init];
    
    NSArray *students = [[StudentStore sharedStore] allStudents];
    Student *selectedStudent = students[indexPath.row];
    
    //Gives new controller information about which student was selected
    detailViewController.student = selectedStudent;
    
    //Push it onto the top of the stack
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    
}



- (IBAction)addNewStudent:(id)sender{
    // Create a new student and add it to the store
        Student* newStudent = [[StudentStore sharedStore] createStudent];
    
    StudentDetailViewController *detailViewController = [[StudentDetailViewController alloc] initForNewStudent:YES];
    
    detailViewController.student = newStudent;
    
    detailViewController.dismissBlock = ^{
        [self.tableView reloadData];
    };
    
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
//    
//    navController.modalPresentationStyle = UIModalPresentationFormSheet;
//    
//    [self presentViewController:navController animated:YES completion:NULL];
    
    [self.navigationController presentViewController:detailViewController animated:YES completion:NULL];
    
    
}

//removes image popover
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.imagePopover = nil;
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSArray *students = [[StudentStore sharedStore] allStudents];
        Student *student = students[indexPath.row];
        [[StudentStore sharedStore] removeStudent:student];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[StudentStore sharedStore] moveItemAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
    
}


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
