//
//  ProjectsViewController.m
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import "ProjectsViewController.h"
#import "ProjectTableViewCell.h"
#import "PopupTransitioningDelegate.h"
#import <SafariServices/SafariServices.h>

#define kPackathonVotedIdentifier @"packathonVotedIdentifier"

@interface ProjectsViewController () <ProjectTableViewCellDelegate>

@property (nonatomic) ProjectList *projectList;
@property PopupTransitioningDelegate *transitioningDelegate;
@property (nonatomic) NSNumber *votedIdentifier;

@end

@implementation ProjectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshProjects:) forControlEvents:UIControlEventValueChanged];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.projectList) {
        [self.refreshControl beginRefreshing];
        self.tableView.contentOffset = CGPointMake(0.0, -CGRectGetHeight(self.refreshControl.frame));
        [self refreshProjects:self.refreshControl];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ProfileSegue"]) {
        UIViewController *viewController = segue.destinationViewController;
        viewController.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = [PopupTransitioningDelegate new];
        viewController.transitioningDelegate = self.transitioningDelegate;
    }
}

#pragma mark - Getter

- (NSNumber *)votedIdentifier {
    if (!_votedIdentifier) {
        _votedIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:kPackathonVotedIdentifier];
    }
    return _votedIdentifier;
}

#pragma mark - Private methods

- (IBAction)refreshProjects:(id)sender {
    [[RemoteProcedureProxy sharedInstance] projectsWithCompletion:^(ProjectList *projectList, NSError *error) {
        if (!error) {
            self.projectList = projectList;
            [self.tableView reloadData];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Network error", @"")
                                                                           message:error.localizedDescription ?: NSLocalizedString(@"Failed to fetch projects", @"")
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Dismiss", @"") style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:dismissAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - ProjectTableViewCellDelegate

- (void)projectTableViewCell:(ProjectTableViewCell *)cell didRequestToOpenGitHub:(Project *)project {
    SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:project.git]];
    [self presentViewController:safariViewController animated:YES completion:nil];
}

- (void)projectTableViewCell:(ProjectTableViewCell *)cell didRequestToOpenWebsite:(Project *)project {
    SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:project.website]];
    [self presentViewController:safariViewController animated:YES completion:nil];
}

- (void)projectTableViewCell:(ProjectTableViewCell *)cell didRequestToVoteProject:(Project *)project {
    if ([RemoteProcedureProxy sharedInstance].isLoggedIn) {
        cell.voteButton.hidden = YES;
        [cell.activityIndicator startAnimating];
        [[RemoteProcedureProxy sharedInstance] voteProject:project completion:^(NSString *message, BOOL status) {
            cell.voteButton.hidden = NO;
            [cell.activityIndicator stopAnimating];
            if (status) {
                [[NSUserDefaults standardUserDefaults] setObject:project.identifier forKey:kPackathonVotedIdentifier];
                cell.voteButton.backgroundColor = [UIColor greenColor];
            }
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Vote", @"")
                                                                           message:message ?: NSLocalizedString(@"Failed to vote", @"")
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Dismiss", @"") style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:dismissAction];
            [self presentViewController:alert animated:YES completion:nil];
        }];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Authentication error", @"")
                                                                       message:NSLocalizedString(@"You need to be logged in to vote", @"")
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Dismiss", @"") style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:dismissAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProjectTableViewCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    Project *project = self.projectList.projects[indexPath.row];
    [cell configureWithProject:project voted:(project.identifier.integerValue == self.votedIdentifier.integerValue)];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.projectList.count.integerValue;
}

@end
