//
//  StudentDetailViewController.m
//  Class_Discussion
//
//  Created by sseverov on 5/1/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "StudentDetailViewController.h"
#import "Student.h"
#import "StudentImageStore.h"
#import "StudentStore.h"

@interface StudentDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *yearField;
@property (weak, nonatomic) IBOutlet UITextField *gradeField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

- (IBAction)takePicture:(id)sender;
- (IBAction)backgroundTapped:(id)sender;

@end

@implementation StudentDetailViewController

- (instancetype)initForNewStudent:(BOOL)isNew
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        if (isNew) {
            
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                      target:self
                                                                                      action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                        target:self                                                                                 action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
        
//        // Make sure this is NOT in the if (isNew ) { } block of code
//        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//        [defaultCenter addObserver:self
//                          selector:@selector(updateFonts)
//                              name:UIContentSizeCategoryDidChangeNotification
//                            object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}





- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    Student *student = self.student;
    
    self.nameField.text = student.fullName;
    self.yearField.text = student.year;
    self.gradeField.text = [NSString stringWithFormat:@"%i",student.grade];
    
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    self.dateLabel.text = [dateFormatter stringFromDate:student.dateCreated];
    
    
    NSString *studentKey = self.student.studentKey;
    if (studentKey) {
        // Get image for image key from the image store
        UIImage *imageToDisplay = [[StudentImageStore sharedStore] imageForKey:studentKey];
        
        // Use that image to put on the screen in imageView
        self.imageView.image = imageToDisplay;
    } else {
        // Clear the imageView
        self.imageView.image = nil;
    }

    
}

- (void) viewDidAppear:(BOOL)animated{
        NSLog(@"View appeared");
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //Clear first responder
    [self.view endEditing:YES];
    
    //Save changes to the student info
    Student *student = self.student;
    student.fullName = self.nameField.text;
    student.year     = self.yearField.text;
    student.grade = [self.gradeField.text intValue];
    
}


- (void)save:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

- (void)cancel:(id)sender
{
    // If the user cancelled, then remoce the BNRItem from the store
    [[StudentStore sharedStore] removeStudent:self.student];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}


- (void) setStudent:(Student *)student{
    _student = student;
    self.navigationItem.title = _student.fullName;
}

- (IBAction)takePicture:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    //If the device has a camera-take a picture. Otherwise just choose it from the library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    //Place iimage picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //Get the picked image from the dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.student setThumbnailFromImage:image];
    
    
    //Store the image in the StudentImageStore for its key
    [[StudentImageStore sharedStore] setImage:image forKey:self.student.studentKey];
    
    //Put that image onto the screen in our imageView
    self.imageView.image = image;
    
    //Calling the dismiss method
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
    
}
@end
