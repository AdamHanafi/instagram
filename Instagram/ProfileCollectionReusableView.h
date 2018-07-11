//
//  ProfileCollectionReusableView.h
//  Instagram
//
//  Created by Riley Schnee on 7/10/18.
//  Copyright © 2018 Riley Schnee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface ProfileCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *profilePicView;
@property (weak, nonatomic) IBOutlet UILabel *numPostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;

@end
