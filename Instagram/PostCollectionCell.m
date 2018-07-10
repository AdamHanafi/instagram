//
//  PostCollectionCell.m
//  Instagram
//
//  Created by Riley Schnee on 7/10/18.
//  Copyright © 2018 Riley Schnee. All rights reserved.
//

#import "PostCollectionCell.h"
#import "Post.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@implementation PostCollectionCell

- (void)setPost:(Post *)post {
    _post = post;
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
}

@end
