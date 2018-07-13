//
//  DetailViewController.h
//  Instagram
//
//  Created by Riley Schnee on 7/11/18.
//  Copyright © 2018 Riley Schnee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic) Post *post;
@end
