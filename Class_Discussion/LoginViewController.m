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

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)createAccountButtonPressed:(id)sender;
- (IBAction)forgotPasswordButtonPressed:(id)sender;


@end

@implementation LoginViewController

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


    
    //Push new view to navigationController stack




- (IBAction)loginButtonPressed:(id)sender {
    
}
- (IBAction)createAccountButtonPressed:(id)sender {
    CreateAccountViewController *createAccountScreen = [CreateAccountViewController alloc];
    [self.navigationController pushViewController:createAccountScreen animated:YES];

}

- (IBAction)forgotPasswordButtonPressed:(id)sender {
}


@end
