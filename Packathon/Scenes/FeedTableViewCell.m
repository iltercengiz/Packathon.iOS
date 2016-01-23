//
//  FeedTableViewCell.m
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import "FeedTableViewCell.h"
#import "FeedItem.h"

@interface FeedTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation FeedTableViewCell

- (void)configureWithFeedItem:(FeedItem *)feedItem {
    self.titleLabel.text = feedItem.title;
    self.contentLabel.text = feedItem.content;
    self.dateLabel.text = [self.dateFormatter stringFromDate:feedItem.createdAt];
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [NSDateFormatter new];
        _dateFormatter.dateFormat = @"HH:mm";
    }
    return _dateFormatter;
}

@end
