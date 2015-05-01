//
//  CreateAccountViewController.m
//  Class_Discussion
//
//  Created by Hill, Oliver on 3/25/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "CreateAccountViewController.h"

@interface CreateAccountViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
- (IBAction)createAccountButton:(id)sender;
-(BOOL) isValidEmail:(NSString *)checkString;
@end

@implementation CreateAccountViewController



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
-(BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; 
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (IBAction)createAccountButton:(id)sender {
    if(([_passwordTextField.text isEqualToString:_confirmPasswordTextField.text])&&(_passwordTextField.text.length >6))
        if([self isValidEmail: _emailTextField.text])
            NSLog(@"Create Account");
        else{
            UIAlertView * emailFailAlert =[[UIAlertView alloc ] initWithTitle: @"Email Error"
                                              message:@"Please enter a valid email adress"
                                              delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles: nil];
            [emailFailAlert show];
        }
    else{
        UIAlertView * passwordFailAlert =[[UIAlertView alloc ] initWithTitle: @"Password Error"
                                            message:@"Please check that your passwords are at least 6 characters in length and match each other"
                                            delegate:self
                                            cancelButtonTitle:@"Ok"
                                            otherButtonTitles: nil];
        [passwordFailAlert show];
    }

}
       
@end
