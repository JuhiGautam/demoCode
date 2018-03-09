//
//  InfoDataCustomTableViewCell.m
//  ItemInfo
//
//  Created by Juhi Gautam on 08/03/18.
//  Copyright © 2018 Juhi Gautam. All rights reserved.
//

#import "InfoDataCustomTableViewCell.h"

@implementation InfoDataCustomTableViewCell

@synthesize descriptionLabel = _descriptionLabel;
@synthesize titleLabel = _titleLabel;
@synthesize iconImage = _iconImage;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 15, 40, 40)];
        [self.iconImage setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:self.iconImage];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImage.frame.origin.x+_iconImage.frame.size.width+5, 10, self.frame.size.width, 30)];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
        self.titleLabel.numberOfLines = 0;
        [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:self.titleLabel];
        
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImage.frame.origin.x+_iconImage.frame.size.width+5,_titleLabel.frame.origin.y+_titleLabel.frame.size.height, self.frame.size.width, 30)];
        self.descriptionLabel.textColor = [UIColor blackColor];
        self.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        self.descriptionLabel.numberOfLines = 0;
        [self.descriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:self.descriptionLabel];
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
