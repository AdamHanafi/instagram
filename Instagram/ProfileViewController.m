//
//  ProfileViewController.m
//  Instagram
//
//  Created by Riley Schnee on 7/9/18.
//  Copyright © 2018 Riley Schnee. All rights reserved.
//

#import "ProfileViewController.h"
#import "Parse.h"
#import "PostCollectionCell.h"
#import "ProfileCollectionReusableView.h"
#import <ParseUI/ParseUI.h>
#import "Post.h"
#import "DetailViewController.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *posts;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // self.numPostsLabel =
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self fetchPosts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchPosts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    //[query whereKey:@"likesCount" greaterThan:@100];
    
    query.limit = 20;
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.posts = posts;
            NSLog(@"Posts assigned to array");
            NSLog(@"%@", self.posts);
            NSLog(@"%lu", self.posts.count);
            [self.collectionView reloadData];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
            
        }
    }];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UICollectionViewCell  *tappedCell = sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
    Post *post = self.posts[indexPath.item];
    NSLog(@"%d", [[segue destinationViewController] isKindOfClass:[DetailViewController class]]);
    DetailViewController *detailViewController = [segue destinationViewController];
    
    detailViewController.post = post;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionCell" forIndexPath:indexPath];
    cell.post = self.posts[indexPath.item];
    cell.postImageView.file = cell.post.image;
    [cell.postImageView loadInBackground];
    //cell.postImageView.layer.cornerRadius = cell.postImageView.frame.size.width/2;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    ProfileCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ProfileCollectionReusableView" forIndexPath:indexPath];
    
    return header;
}

@end

