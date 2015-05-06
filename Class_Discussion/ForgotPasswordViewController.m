 //
//  ForgotPasswordViewController.m
//  Class_Discussion
//
//  Created by Hill, Oliver on 3/25/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailAdressTextField;
- (IBAction)sendEmailButton:(id)sender;
-(BOOL) isValidEmail:(NSString *)checkString;
-(BOOL) isEmailAssociatedWithAccount: (NSString *)testEmail;
-(void) invadlidEmail;
-(void) emailNotFound;
-(void) sendEmail;


@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL) isEmailAssociatedWithAccount:(NSString *)testEmail{
    return YES;
}

-(BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (IBAction)sendEmailButton:(id)sender {
    if([self isValidEmail:_emailAdressTextField.text])
        if([self isEmailAssociatedWithAccount:_emailAdressTextField.text])
            [self sendEmail];
        else
            [self emailNotFound];
    else
        [self invadlidEmail];
}
-(void)sendEmail{
    
}
-(void)invadlidEmail{
    UIAlertView * emailFailAlert =[[UIAlertView alloc ] initWithTitle: @"Invalid Email"
                                                              message:@"Please enter a valid email adress so you can retrieve your password"
                                                             delegate:self
                                                    cancelButtonTitle:@"Ok"
                                                    otherButtonTitles: nil];
    [emailFailAlert show];

}
-(void)emailNotFound{
    UIAlertView * emailFailAlert =[[UIAlertView alloc ] initWithTitle: @"Email adress not associated with an account"
                                                              message:@"Please enter a valid email adress"
                                                             delegate:self
                                                    cancelButtonTitle:@"Ok"
                                                    otherButtonTitles: nil];
    [emailFailAlert show];
}
@end
