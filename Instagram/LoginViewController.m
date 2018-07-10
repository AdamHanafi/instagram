//
//  LoginViewController.m
//  Instagram
//
//  Created by Riley Schnee on 7/9/18.
//  Copyright © 2018 Riley Schnee. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

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
- (IBAction)clickedSignUp:(id)sender {
    if([self.passwordField.text isEqual:@""]){
        [self noPasswordAlert];
    } else if([self.usernameField.text isEqual:@""]){
        [self noUsernameAlert];
    }else{
        [self registerUser];
    }
}

- (IBAction)clickedLogin:(id)sender {
    if([self.passwordField.text isEqual:@""]){
        [self noPasswordAlert];
    } else if([self.usernameField.text isEqual:@""]){
        [self noUsernameAlert];
    }else{
        [self loginUser];
    }
}

// HELPER FUNCTIONS

- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            [self errorAlert];
        } else {
            NSLog(@"User registered successfully");
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (void)loginUser{
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            [self errorAlert];
        } else {
            NSLog(@"User logged in successfully");
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (void)noPasswordAlert{
    UIAlertController *emptyPWDAlert = [UIAlertController alertControllerWithTitle:@"Empty Password" message:@"You must enter a password" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { // handle response here.
    }];
    // add the OK action to the alert controller
    [emptyPWDAlert addAction:okAction];
    [self presentViewController:emptyPWDAlert animated:YES completion:nil];
}

- (void)noUsernameAlert{
    UIAlertController *emptyUSRAlert = [UIAlertController alertControllerWithTitle:@"Empty Username" message:@"You must enter a username" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { // handle response here.
    }];
    // add the OK action to the alert controller
    [emptyUSRAlert addAction:okAction];
    [self presentViewController:emptyUSRAlert animated:YES completion:nil];
}

- (void)errorAlert{
    // Present error alert controller
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"An Error Occurred" message:@"Please try again later" preferredStyle:(UIAlertControllerStyleAlert)];
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { // handle response here.
    }];
    // add the OK action to the alert controller
    [errorAlert addAction:okAction];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
