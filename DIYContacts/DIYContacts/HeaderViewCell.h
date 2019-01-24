//
//  HeaderViewCell.h
//  DIYContacts
//
//  Created by kangqijun on 2018/8/7.
//  Copyright © 2018年 Kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"

@interface HeaderViewCell : UITableViewCell
{
    UIButton *headerBtn;
}

- (void)loadContactData:(PersonModel *)model;

@end
