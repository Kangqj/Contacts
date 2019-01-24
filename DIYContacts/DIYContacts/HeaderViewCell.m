//
//  HeaderViewCell.m
//  DIYContacts
//
//  Created by kangqijun on 2018/8/7.
//  Copyright © 2018年 Kangqijun. All rights reserved.
//

#import "HeaderViewCell.h"
#import "UIImage+PDExtension.h"

@implementation HeaderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-70)/2, 5, 70, 70)];
        iconImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:iconImageView];
        iconImageView.layer.masksToBounds = YES;
        iconImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        iconImageView.layer.borderWidth = 1.0;
        iconImageView.layer.cornerRadius = iconImageView.frame.size.width/2;
        iconImageView.userInteractionEnabled = YES;
        
        headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        headerBtn.frame = CGRectMake(0, 0, iconImageView.frame.size.width, iconImageView.frame.size.width);
        [headerBtn setBackgroundImage:[UIImage imageNamed:@"defult"] forState:UIControlStateNormal];
        [headerBtn setTitle:@"add photo" forState:UIControlStateNormal];
        headerBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [headerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [headerBtn addTarget:self action:@selector(setHeaderImage) forControlEvents:UIControlEventTouchUpInside];
        [iconImageView addSubview:headerBtn];
    }
    
    return self;
}

- (void)loadContactData:(PersonModel *)model
{
    [headerBtn setBackgroundImage:model.header forState:UIControlStateNormal];
    
    if (model.isEdit)
    {
        [headerBtn setTitle:@"add photo" forState:UIControlStateNormal];
    }
    else
    {
        [headerBtn setTitle:nil forState:UIControlStateNormal];
    }
}

- (void)setHeaderImage
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
