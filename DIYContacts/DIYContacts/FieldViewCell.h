//
//  FieldViewCell.h
//  DIYContacts
//
//  Created by kangqijun on 2018/8/7.
//  Copyright © 2018年 Kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"

typedef enum
{
    FieldViewCellType_name = 0,
    FieldViewCellType_phone,
    FieldViewCellType_email,
    FieldViewCellType_note,
    FieldViewCellType_photo,
    
}FieldViewCellType;

@interface FieldViewCell : UITableViewCell
{
    UILabel *namelabel;
    UITextField *contentField;
    UITextView  *noteTextView;
    
    UIButton *msgBtn;
    UIButton *phoneBtn;
    UIButton *emailBtn;
    UIButton *photoBtn;

}

@property (strong, nonatomic) PersonModel *curContact;
@property (assign, nonatomic)  FieldViewCellType curType;

- (void)loadContactData:(PersonModel *)model;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(FieldViewCellType)type;

@end
