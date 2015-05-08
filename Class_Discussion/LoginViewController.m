//
//  LoginViewController.m
//  Class_Discussion
//
//  Created by Hill, Oliver on 3/24/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "LoginViewController.h"
#import "CreateAccountViewController.h"
#import "ForgotPasswordViewController.h"
#import "Teacher.h"
#import "TableViewController.h"
#import "HomeScreenViewController.h";

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)createAccountButtonPressed:(id)sender;
- (IBAction)forgotPasswordButtonPressed:(id)sender;
-(void)invalidLogin;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([_passwordTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    }
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


    
    //Push new view to navigationController stack




- (IBAction)loginButtonPressed:(id)sender {
    if(([_usernameTextField.text  isEqual:@"Teacher"])&& ([_passwordTextField.text isEqual:@"password"])){
        HomeScreenViewController *homeScreen = (HomeScreenViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Home Screen"];
        [self.navigationController pushViewController:homeScreen animated:YES];
    }
    else
        [self invalidLogin];
    }

-(void)invalidLogin{
    UIAlertView * loginFailureAlert =[[UIAlertView alloc ] initWithTitle: @"Invalid Email or Password"
                                                              message:@"Please Try Again"
                                                             delegate:self
                                                    cancelButtonTitle:@"Ok"
                                                    otherButtonTitles: nil];
    [loginFailureAlert show];

}
- (IBAction)createAccountButtonPressed:(id)sender {
    CreateAccountViewController *createAccountScreen = (CreateAccountViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Create Account"];
    [self.navigationController pushViewController:createAccountScreen animated:YES];

}

- (IBAction)forgotPasswordButtonPressed:(id)sender {
    ForgotPasswordViewController *forgotPasswordScreen = (ForgotPasswordViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Forgot Password"];
    [self.navigationController pushViewController:forgotPasswordScreen animated:YES];
}


@end
