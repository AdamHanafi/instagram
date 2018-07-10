//
//  PostCollectionCell.h
//  Instagram
//
//  Created by Riley Schnee on 7/10/18.
//  Copyright © 2018 Riley Schnee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#import "Post.h"

@interface PostCollectionCell : UICollectionViewCell
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;

@end
