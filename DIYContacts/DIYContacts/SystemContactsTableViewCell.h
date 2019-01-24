//
//  SystemContactsTableViewCell.h
//  DIYContacts
//
//  Created by kangqijun on 2018/8/7.
//  Copyright © 2018年 Kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"

@protocol SystemContactsTableViewCellDelegate <NSObject>
@optional
- (void)selectContact:(PersonModel *)contact;
- (void)seeContactDetail:(PersonModel *)contact;

@end

@interface SystemContactsTableViewCell : UITableViewCell
{
    UIImageView *iconImageView;
}

@property (strong, nonatomic) PersonModel *curContact;
@property (weak, nonatomic) id <SystemContactsTableViewCellDelegate> selectDelegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)loadContactData:(PersonModel *)model;

@end
