//
//  ProjectTableViewCell.m
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import "ProjectTableViewCell.h"

@interface ProjectTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *gitHubButton;
@property (weak, nonatomic) IBOutlet UIButton *websiteButton;
@property (weak, nonatomic, readwrite) IBOutlet UIButton *voteButton;
@property (weak, nonatomic, readwrite) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *websiteButtonToGitHubButtonConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *websiteButtonToSuperViewConstraint;

@property (nonatomic) Project *project;

@end

@implementation ProjectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.voteButton.layer.cornerRadius = 8.0;
    self.voteButton.layer.masksToBounds = YES;
}

- (void)configureWithProject:(Project *)project voted:(BOOL)voted {
    self.project = project;
    self.projectNameLabel.text = project.name;
    self.teamNameLabel.text = project.teamName;
    self.voteButton.backgroundColor = voted ? [UIColor greenColor] : [UIColor darkGrayColor];
    
    BOOL shouldShowGitHubButton = (project.git != nil);
    if (shouldShowGitHubButton) {
        self.gitHubButton.hidden = NO;
        self.websiteButtonToSuperViewConstraint.priority = UILayoutPriorityDefaultLow;
        self.websiteButtonToGitHubButtonConstraint.priority = UILayoutPriorityDefaultHigh;
    } else {
        self.gitHubButton.hidden = YES;
        self.websiteButtonToSuperViewConstraint.priority = UILayoutPriorityDefaultHigh;
        self.websiteButtonToGitHubButtonConstraint.priority = UILayoutPriorityDefaultLow;
    }
    BOOL shouldShowWebsiteButton = (project.website != nil);
    self.websiteButton.hidden = !shouldShowWebsiteButton;
}

- (IBAction)didTapGitHubButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(projectTableViewCell:didRequestToOpenGitHub:)]) {
        [self.delegate projectTableViewCell:self didRequestToOpenGitHub:self.project];
    }
}

- (IBAction)didTapWebsiteButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(projectTableViewCell:didRequestToOpenWebsite:)]) {
        [self.delegate projectTableViewCell:self didRequestToOpenWebsite:self.project];
    }
}

- (IBAction)didTapVoteButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(projectTableViewCell:didRequestToVoteProject:)]) {
        [self.delegate projectTableViewCell:self didRequestToVoteProject:self.project];
    }
}

@end
