//
//  ContactsTableViewCell.m
//  DIYContacts
//
//  Created by kangqijun on 2018/8/7.
//  Copyright © 2018年 Kangqijun. All rights reserved.
//

#import "ContactsTableViewCell.h"

@implementation ContactsTableViewCell
@synthesize curContact;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadContactData:(PersonModel *)model
{
    self.curContact = model;
    
    self.textLabel.text = model.name;
    
    if (model.phoneArr.count > 0)
    {
        self.detailTextLabel.text = [model.phoneArr objectAtIndex:0];
    }
    
    self.imageView.image = model.header;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
