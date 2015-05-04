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

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *assetTypeButton;

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
    }
    
    return self;
}

- (void)dealloc
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}





- (void) viewWillAppear:(BOOL)animated{
            NSLog(@"Detail viewWillAppear completed");
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
    
//    NSString *typeLabel = [self.item.assetType valueForKey:@"label"];
//    if (!typeLabel) {
//        typeLabel = @"None";
//    }
//    
//   // self.assetTypeButton.title = [NSString stringWithFormat:@"Type: %@", typeLabel];
//    
//    [self updateFonts];
//

}

- (void) viewDidLoad{
        [super viewDidLoad];
        
        UIImageView *iv = [[UIImageView alloc] initWithImage:nil];
        
        // The contentMode of the image view in the XIB was Aspect Fit:
        iv.contentMode = UIViewContentModeScaleAspectFit;
        
        // Do not produce a translated constraint for this view
        iv.translatesAutoresizingMaskIntoConstraints = NO;
        
        // The image view was a subview of the view
        [self.view addSubview:iv];
        
        // The image view was pointed to by the imageView property
        self.imageView = iv;
        
        NSDictionary *nameMap = @{@"imageView": self.imageView,
                                  @"dateLabel": self.dateLabel,
                                  @"toolbar": self.toolbar};
        
        // imageView is 0 pts from superview at left and right edges
        NSArray *horizontalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                options:0
                                                metrics:nil
                                                  views:nameMap];
        
        // imaveView is 8 pts from dateLabel at its top edge...
        // ... and 8 pts from toolbar at its bottom edge
        NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"V:[dateLabel]-[imageView]-[toolbar]"
                                                options:0
                                                metrics:nil
                                                  views:nameMap];
        
        [self.view addConstraints:horizontalConstraints];
        [self.view addConstraints:verticalConstraints];

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

//- (void)updateFonts
//{
//    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
//    
//    self.nameLabel.font = font;
//    self.serialNumberLabel.font = font;
//    self.valueLabel.font = font;
//    self.dateLabel.font = font;
//    
//    self.nameField.font = font;
//}


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
