//
//  UpdateProfileViewController.m
//  Instagram
//
//  Created by Riley Schnee on 7/12/18.
//  Copyright © 2018 Riley Schnee. All rights reserved.
//

#import "UpdateProfileViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface UpdateProfileViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *profilePicView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextView *bioField;

@end

@implementation UpdateProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.profilePicView.file = PFUser.currentUser[@"picture"];
    self.nameField.text = PFUser.currentUser[@"name"];
    self.usernameField.text = PFUser.currentUser.username;
    self.bioField.text = PFUser.currentUser[@"bio"];
    self.profilePicView.layer.cornerRadius = self.profilePicView.frame.size.width/2;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.nameField endEditing:YES];
    [self.usernameField endEditing:YES];
    [self.bioField endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickedChangePic:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Do something with the images (based on your use case)
    //editedImage = [self resizeImage:originalImage withSize:CGSizeMake(100, 100)];
    [self.profilePicView setImage:editedImage];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveProfile:(id)sender {
    PFUser.currentUser[@"name"] = self.nameField.text;
    PFUser.currentUser[@"picture"] = [PFFile fileWithData:UIImagePNGRepresentation(self.profilePicView.image)];
    PFUser.currentUser[@"bio"] = self.bioField.text;
    PFUser.currentUser.username = self.usernameField.text;
    [PFUser.currentUser saveInBackground];
    [self.navigationController popViewControllerAnimated:YES];

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
