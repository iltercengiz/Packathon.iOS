//
//  FeedViewController.m
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedTableViewCell.h"

@interface FeedViewController ()

@property Feed *feed;

@end

@implementation FeedViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshFeed:) forControlEvents:UIControlEventValueChanged];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.feed) {
        [self.refreshControl beginRefreshing];
        self.tableView.contentOffset = CGPointMake(0.0, -CGRectGetHeight(self.refreshControl.frame));
        [self refreshFeed:self.refreshControl];
    }
}

#pragma mark - Private methods

- (IBAction)refreshFeed:(id)sender {
    [[RemoteProcedureProxy sharedInstance] feedsWithCompletion:^(Feed *feed, NSError *error) {
        if (!error) {
            self.feed = feed;
            [self.tableView reloadData];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Network error", @"")
                                                                           message:error.localizedDescription ?: NSLocalizedString(@"Failed to fetch feeds", @"")
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Dismiss", @"") style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:dismissAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FeedTableViewCell class]) forIndexPath:indexPath];
    FeedItem *feedItem = self.feed.feedItems[indexPath.row];
    [cell configureWithFeedItem:feedItem];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feed.count.integerValue;
}

@end
