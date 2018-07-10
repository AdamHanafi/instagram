//
//  PostCell.h
//  Instagram
//
//  Created by Riley Schnee on 7/9/18.
//  Copyright © 2018 Riley Schnee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>


@interface PostCell : UITableViewCell
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *postCaptionLabel;

@end
