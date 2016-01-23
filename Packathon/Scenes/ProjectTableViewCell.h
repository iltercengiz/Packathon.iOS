//
//  ProjectTableViewCell.h
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@protocol ProjectTableViewCellDelegate;

@interface ProjectTableViewCell : UITableViewCell

@property (weak, nonatomic, readonly) IBOutlet UIButton *voteButton;
@property (weak, nonatomic, readonly) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) id<ProjectTableViewCellDelegate> delegate;

- (void)configureWithProject:(Project *)project voted:(BOOL)voted;

@end

@protocol ProjectTableViewCellDelegate <NSObject>

@optional
- (void)projectTableViewCell:(ProjectTableViewCell *)cell didRequestToOpenGitHub:(Project *)project;
- (void)projectTableViewCell:(ProjectTableViewCell *)cell didRequestToOpenWebsite:(Project *)project;
- (void)projectTableViewCell:(ProjectTableViewCell *)cell didRequestToVoteProject:(Project *)project;

@end
