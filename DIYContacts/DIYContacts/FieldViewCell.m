//
//  FieldViewCell.m
//  DIYContacts
//
//  Created by kangqijun on 2018/8/7.
//  Copyright © 2018年 Kangqijun. All rights reserved.
//

#import "FieldViewCell.h"

@implementation FieldViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(FieldViewCellType)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.curType = type;
        
        float leftWidth = 60;
        float viewWidth = [UIScreen mainScreen].bounds.size.width;

        namelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, leftWidth, 45)];
        namelabel.textColor = [UIColor blueColor];
        namelabel.textAlignment = NSTextAlignmentCenter;
        namelabel.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:namelabel];
        
        switch (type)
        {
            case FieldViewCellType_name:
            {
                namelabel.text = @"Name";
                
                contentField = [[UITextField alloc] initWithFrame:CGRectMake(leftWidth, 0, viewWidth - leftWidth, namelabel.frame.size.height)];
                contentField.textAlignment = NSTextAlignmentLeft;
                contentField.font = [UIFont systemFontOfSize:14];
                [self.contentView addSubview:contentField];
                
                break;
            }
            case FieldViewCellType_phone:
            {
                namelabel.text = @"Phone";
                
                contentField = [[UITextField alloc] initWithFrame:CGRectMake(leftWidth, 0, viewWidth - leftWidth, namelabel.frame.size.height)];
                contentField.textAlignment = NSTextAlignmentLeft;
                contentField.font = [UIFont systemFontOfSize:14];
                [self.contentView addSubview:contentField];
                
                msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                msgBtn.frame = CGRectMake(viewWidth - 2*self.frame.size.height - 20, 0, viewWidth, namelabel.frame.size.height);
                [msgBtn setImage:[UIImage imageNamed:@"icon_msg.png"] forState:UIControlStateNormal];
                [msgBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:msgBtn];
                msgBtn.hidden = YES;
                
                phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                phoneBtn.frame = CGRectMake(viewWidth-10, 0, self.frame.size.height, self.frame.size.height);
                [phoneBtn setImage:[UIImage imageNamed:@"icon_call.png"] forState:UIControlStateNormal];
                [phoneBtn addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:phoneBtn];
                phoneBtn.hidden = YES;
                
                break;
            }
            case FieldViewCellType_email:
            {
                namelabel.text = @"Email";
                
                contentField = [[UITextField alloc] initWithFrame:CGRectMake(leftWidth, 0, viewWidth - leftWidth, namelabel.frame.size.height)];
                contentField.textAlignment = NSTextAlignmentLeft;
                contentField.font = [UIFont systemFontOfSize:14];
                [self.contentView addSubview:contentField];
                
                emailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                emailBtn.frame = CGRectMake(viewWidth-10, 0, self.frame.size.height, namelabel.frame.size.height);
                [emailBtn setImage:[UIImage imageNamed:@"icon_email.png"] forState:UIControlStateNormal];
                [emailBtn addTarget:self action:@selector(sendEmail) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:emailBtn];
                emailBtn.hidden = YES;
                
                break;
            }
            case FieldViewCellType_note:
            {
                namelabel.text = @"Notes";
                
                namelabel.frame = CGRectMake(0, 0, leftWidth, 80);
                
                noteTextView = [[UITextView alloc] initWithFrame:CGRectMake(leftWidth, 0, viewWidth - leftWidth, namelabel.frame.size.height)];
                noteTextView.textAlignment = NSTextAlignmentLeft;
                noteTextView.font = [UIFont systemFontOfSize:14];
                [self.contentView addSubview:noteTextView];
                
                break;
            }
            case FieldViewCellType_photo:
            {
                namelabel.text = @"Photes";
                
                namelabel.frame = CGRectMake(0, 0, leftWidth, 80);

                photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                photoBtn.frame = CGRectMake(viewWidth-10, 0, namelabel.frame.size.height, namelabel.frame.size.height);
                [photoBtn setTitle:@"add photo" forState:UIControlStateNormal];
                [photoBtn addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:photoBtn];
                photoBtn.hidden = YES;

                break;
            }
            default:
                break;
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(namelabel.frame.size.width-1, 0, 0.5, namelabel.frame.size.height)];
        line.backgroundColor = [UIColor lightGrayColor];
        [namelabel addSubview:line];
    }
    
    return self;
}


- (void)loadContactData:(PersonModel *)model
{
    self.curContact = model;
    
    if (model.isEdit)
    {
        msgBtn.hidden = YES;
        phoneBtn.hidden = YES;
        emailBtn.hidden = YES;
        photoBtn.hidden = YES;
    }
    else
    {
        msgBtn.hidden = NO;
        phoneBtn.hidden = NO;
        emailBtn.hidden = NO;
        photoBtn.hidden = NO;
    }
    
    switch (self.curType)
    {
        case FieldViewCellType_name:
        {
            contentField.text = model.name;
            
            contentField.userInteractionEnabled = model.isEdit;
            break;
        }
        case FieldViewCellType_phone:
        {
            if (model.phoneArr.count > 0)
            {
                contentField.text = [model.phoneArr objectAtIndex:0];
                contentField.userInteractionEnabled = model.isEdit;
            }
            
            break;
        }
        case FieldViewCellType_email:
        {
            contentField.text = model.email;
            contentField.userInteractionEnabled = model.isEdit;

            break;
        }
        case FieldViewCellType_note:
        {
            noteTextView.text = model.note;
            noteTextView.userInteractionEnabled = model.isEdit;

            break;
        }
        case FieldViewCellType_photo:
        {
            
            break;
        }
        default:
            break;
    }
}

- (void)sendMessage
{
    
}

- (void)callPhone
{
    
}


- (void)sendEmail
{
    
}


- (void)addPhoto
{
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
