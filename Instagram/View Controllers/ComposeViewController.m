//
//  ComposeViewController.m
//  Instagram
//
//  Created by Riley Schnee on 7/9/18.
//  Copyright © 2018 Riley Schnee. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *picturePostView;
@property (weak, nonatomic) IBOutlet UITextView *captionContent;
@property (nonatomic) BOOL useCamera;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self dismissViewControllerAnimated:YES completion:nil];

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
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    // imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    self.useCamera = false;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Camera or Photo Roll?" message:@"How would you like to get your picture?" preferredStyle:(UIAlertControllerStyleActionSheet)];
    // create a cancel action
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // handle cancel response here. Doing nothing will dismiss the view.
        self.useCamera = true;
    }];
    // add the cancel action to the alertController
    [alert addAction:cameraAction];
    
    // create an OK action
    UIAlertAction *rollAction = [UIAlertAction actionWithTitle:@"Photo Roll" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           // handle response here.
           self.useCamera = false;
    }];
    // add the OK action to the alert controller
    [alert addAction:rollAction];
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
        
        
        if (self.useCamera && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else {
            NSLog(@"Camera 🚫 available so we will use photo library instead");
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        
    }];
    [self presentViewController:imagePickerVC animated:YES completion:nil];

    
}
@end
