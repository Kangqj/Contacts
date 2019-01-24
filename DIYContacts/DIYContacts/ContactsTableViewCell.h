//
//  ContactsTableViewCell.h
//  DIYContacts
//
//  Created by kangqijun on 2018/8/7.
//  Copyright © 2018年 Kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"

@interface ContactsTableViewCell : UITableViewCell
@property (strong, nonatomic) PersonModel *curContact;

- (void)loadContactData:(PersonModel *)model;

@end
