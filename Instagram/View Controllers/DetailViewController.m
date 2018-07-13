//
//  DetailViewController.m
//  Instagram
//
//  Created by Riley Schnee on 7/11/18.
//  Copyright © 2018 Riley Schnee. All rights reserved.
//

#import "DetailViewController.h"
#import "DateTools.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *postUserLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet PFImageView *postUserImageView;
@property (weak, nonatomic) IBOutlet UILabel *postLikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *postCommentLabel;
@property (weak, nonatomic) IBOutlet UIButton *heartButton;
@property (weak, nonatomic) IBOutlet UIButton *bookmarkButton;
@property (weak, nonatomic) IBOutlet UILabel *timeAgoLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.postImageView.file = self.post.image;
    [self.postImageView loadInBackground];
    self.postCommentLabel.text = [NSString stringWithFormat:@"%@ %@", self.post.author.username, self.post.caption];
    self.postLikeLabel.text = [NSString stringWithFormat:@"%@ likes", self.post.likeCount];
    self.postUserLabel.text = self.post.author.username;
    self.heartButton.selected = [self.post.likedBy containsObject:PFUser.currentUser.objectId];
    self.bookmarkButton.selected = false;
    self.postUserImageView.file = self.post.author[@"picture"];
    [self.postUserImageView loadInBackground];
    self.postUserImageView.layer.cornerRadius = self.postUserImageView.frame.size.width/2;
    NSDate *date = self.post.createdAt;
    NSString *ago = [date shortTimeAgoSinceNow];
    self.timeAgoLabel.text = [NSString stringWithFormat:@"%@", ago];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickedLike:(id)sender {
    if(self.heartButton.selected){
        self.heartButton.selected = false;
        self.post.likeCount = [NSNumber numberWithInteger:([self.post.likeCount intValue] - 1)];
        [self.post removeObject:PFUser.currentUser.objectId forKey:@"likedBy"];
        [self.post saveInBackground];
        
    } else if(!self.heartButton.selected) {
        self.heartButton.selected = true;
        self.post.likeCount = [NSNumber numberWithInteger:([self.post.likeCount intValue] + 1)];
        [self.post addUniqueObject:PFUser.currentUser.objectId forKey:@"likedBy"];
        [self.post saveInBackground];
        
    }
    self.postLikeLabel.text = [NSString stringWithFormat:@"%@ likes", self.post.likeCount];
 
}
- (IBAction)clickedBookmark:(id)sender {
    if(self.bookmarkButton.selected){
        self.bookmarkButton.selected = false;
    } else if(!self.bookmarkButton.selected){
        self.bookmarkButton.selected = true;
    }
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
