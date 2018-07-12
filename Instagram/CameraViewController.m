//
//  CameraViewController.m
//  Instagram
//
//  Created by Riley Schnee on 7/12/18.
//  Copyright © 2018 Riley Schnee. All rights reserved.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "Post.h"

@interface CameraViewController () <AVCapturePhotoCaptureDelegate>
@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (weak, nonatomic) IBOutlet UIImageView *captureImageView;
@property (nonatomic) AVCaptureSession *session;
@property (nonatomic) AVCapturePhotoOutput *stillImageOutput;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (weak, nonatomic) IBOutlet UITextView *captionContent;
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.captionContent endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTakePhoto:(id)sender {
    AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey: AVVideoCodecTypeJPEG}];
    [self.stillImageOutput capturePhotoWithSettings:settings delegate:self];

}
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error {
    
    NSData *imageData = photo.fileDataRepresentation;
    UIImage *image = [UIImage imageWithData:imageData];
    // Add the image to captureImageView here...
    self.captureImageView.image = image;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.session = [AVCaptureSession new];
    self.session.sessionPreset = AVCaptureSessionPresetPhoto;
    AVCaptureDevice *backCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    else if (self.session && [self.session canAddInput:input]) {
        [self.session addInput:input];
        // The remainder of the session setup will go here...
        self.stillImageOutput = [AVCapturePhotoOutput new];
        if ([self.session canAddOutput:self.stillImageOutput]) {
            [self.session addOutput:self.stillImageOutput];
            
            //Configure the Live Preiview here
            self.videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
            if (self.videoPreviewLayer) {
                self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
                self.videoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
                [self.previewView.layer addSublayer:self.videoPreviewLayer];
                [self.session startRunning];
            }
            
        }
    }
    
}
- (IBAction)goToCameraRoll:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.videoPreviewLayer.frame = self.previewView.bounds;
}

- (IBAction)clickedPost:(id)sender {
    [Post postUserImage:self.captureImageView.image withCaption:self.captionContent.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
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

@end
