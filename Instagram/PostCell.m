//
//  PostCell.m
//  Instagram
//
//  Created by Riley Schnee on 7/9/18.
//  Copyright © 2018 Riley Schnee. All rights reserved.
//

#import "PostCell.h"
#import "UIImageView+AFNetworking.h"

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
    self.postCaptionLabel.text = post[@"caption"];
    self.numLikesLabel.text = [NSString stringWithFormat:@"%@ likes", post[@"likeCount"]];
    self.usernameLabel.text = post.author.username;

    //self.postProfilePicView.file = poster.image;
    //[self.postProfilePicView loadInBackground];
}

- (IBAction)clickedHeart:(id)sender {
    if(self.heartButton.highlighted){
        self.heartButton.highlighted = false;
        //self.post.likeCount = *self.post.likeCount + *[NSNumber numberWithInteger:1];
    } else {
        self.heartButton.highlighted = true;
        //self.post.likeCount = *self.post.likeCount - *[NSNumber numberWithInteger:1];
    }
    self.numLikesLabel.text = [NSString stringWithFormat:@"%@ likes", self.post.likeCount];

}
- (IBAction)clickedComment:(id)sender {
}
- (IBAction)clickedSend:(id)sender {
}
- (IBAction)clickedBookmark:(id)sender {
    if(self.bookmarkButton.highlighted){
        self.bookmarkButton.highlighted = false;
    } else {
        self.bookmarkButton.highlighted = true;
    }
    
}



@end
