//
//  SystemContactsTableViewCell.m
//  DIYContacts
//
//  Created by kangqijun on 2018/8/7.
//  Copyright © 2018年 Kangqijun. All rights reserved.
//

#import "SystemContactsTableViewCell.h"
#import "UIImage+PDExtension.h"

@implementation SystemContactsTableViewCell

@synthesize selectDelegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect rect = self.imageView.frame;
    self.imageView.frame = CGRectMake(rect.origin.x+40, rect.origin.y, rect.size.width, rect.size.height);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        float width = (self.frame.size.height)-20;
        iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, width, width)];
        iconImageView.image = [UIImage imageNamed:@"checkbox.normal.png"];
        [self.contentView addSubview:iconImageView];
        
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
        [selectBtn addTarget:self action:@selector(selectIconAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:selectBtn];
        
        UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        detailBtn.frame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height);
        [detailBtn addTarget:self action:@selector(goToDetailAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:detailBtn];
    }
    
    return self;
}

- (void)loadContactData:(PersonModel *)model
{
    self.curContact = model;
    
    CNContact *contact = model.contact;
    self.textLabel.text = [NSString stringWithFormat:@"%@ %@", contact.givenName, contact.familyName];
    
    if (contact.phoneNumbers.count > 0)
    {
        self.detailTextLabel.text = ((CNPhoneNumber *)(contact.phoneNumbers.lastObject.value)).stringValue;
    }
    
    UIImage *image = [UIImage imageWithData:contact.thumbnailImageData];
    self.imageView.image = [image circleImage];
    
    if (self.curContact.isSelect)
    {
        iconImageView.image = [UIImage imageNamed:@"checkbox.select.png"];
    }
    else
    {
        iconImageView.image = [UIImage imageNamed:@"checkbox.normal.png"];
    }
}

- (void)selectIconAction
{
    self.curContact.isSelect = !self.curContact.isSelect;
    
    if (self.curContact.isSelect)
    {
        iconImageView.image = [UIImage imageNamed:@"checkbox.select.png"];
    }
    else
    {
        iconImageView.image = [UIImage imageNamed:@"checkbox.normal.png"];
    }
    
    if (self.selectDelegate && [self.selectDelegate respondsToSelector:@selector(selectContact:)])
    {
        [selectDelegate selectContact:self.curContact];
    }
}

- (void)goToDetailAction
{
    if (self.selectDelegate && [self.selectDelegate respondsToSelector:@selector(seeContactDetail:)])
    {
        [selectDelegate seeContactDetail:self.curContact];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
