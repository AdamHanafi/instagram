//
//  PostCell.m
//  Instagram
//
//  Created by Riley Schnee on 7/9/18.
//  Copyright © 2018 Riley Schnee. All rights reserved.
//

#import "PostCell.h"
#import "UIImageView+AFNetworking.h"
#import "DateTools.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    self.postImageView.file = post.image;
    [self.postImageView loadInBackground];
    self.postCaptionLabel.text = [NSString stringWithFormat:@"%@ %@", post.author.username, post.caption];
    self.numLikesLabel.text = [NSString stringWithFormat:@"%@ likes", post.likeCount];
    self.usernameLabel.text = post.author.username;
    self.heartButton.selected = [post.likedBy containsObject:[PFUser currentUser]];
    self.bookmarkButton.selected = false;
    //self.postProfilePicView.file = poster.image;
    //[self.postProfilePicView loadInBackground];
    self.postProfilePicView.layer.cornerRadius = 25;
    
    // Format createdAt date string
    NSString *createdAtOriginalString = post[@"createdAt"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    // Convert String to Date
    NSDate *dateAgo = [formatter dateFromString:createdAtOriginalString];
    
    self.timeAgoLabel.text = [NSString stringWithFormat:@"%@", dateAgo.shortTimeAgoSinceNow];
}

- (IBAction)clickedHeart:(id)sender {
    if(self.heartButton.selected){
        self.heartButton.selected = false;
        self.post.likeCount = [NSNumber numberWithInteger:([self.post.likeCount intValue] - 1)];
        [self.post.likedBy removeObject:[PFUser currentUser]];
        [self.post saveInBackground];
    } else if(!self.heartButton.selected) {
        self.heartButton.selected = true;
        self.post.likeCount = [NSNumber numberWithInteger:([self.post.likeCount intValue] + 1)];
        [self.post.likedBy addObject:[PFUser currentUser]];
        [self.post saveInBackground];
    }
    self.numLikesLabel.text = [NSString stringWithFormat:@"%@ likes", self.post.likeCount];

}
- (IBAction)clickedComment:(id)sender {
}
- (IBAction)clickedSend:(id)sender {
}
- (IBAction)clickedBookmark:(id)sender {
    if(self.bookmarkButton.selected){
        self.bookmarkButton.selected = false;
    } else if(!self.bookmarkButton.selected){
        self.bookmarkButton.selected = true;
    }
}



@end
