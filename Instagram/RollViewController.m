//
//  RollViewController.m
//  Instagram
//
//  Created by Riley Schnee on 7/12/18.
//  Copyright © 2018 Riley Schnee. All rights reserved.
//

#import "RollViewController.h"
#import "Post.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
@interface RollViewController ()
@property (weak, nonatomic) IBOutlet UITextView *captionContent;
@property (weak, nonatomic) IBOutlet UIImageView *picturePostView;
@property (weak, nonatomic) IBOutlet UIButton *pickPickButton;

@end

@implementation RollViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    self.pickPickButton.layer.cornerRadius = self.pickPickButton.frame.size.width / 10;
}

-(void)dismissKeyboard {
    [self.captionContent endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickedPickPicture:(id)sender {
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
    [self.picturePostView setImage:editedImage];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)clickedCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickedPost:(id)sender {
    [Post postUserImage:self.picturePostView.image withCaption:self.captionContent.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"Posting...");
        if(error){
            NSLog(@"Error posting picture: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Picture successfully posted!");
        }
    }];
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.tabBarController setSelectedIndex:0];

}

/*
 
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    
    
}
@end
