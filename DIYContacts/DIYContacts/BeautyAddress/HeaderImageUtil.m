//
//  HeaderImageUtil.m
//  DIYContacts
//
//  Created by kangqijun on 2019/1/24.
//  Copyright © 2019 Kangqijun. All rights reserved.
//

#import "HeaderImageUtil.h"

@implementation HeaderImageUtil

+ (UIImage *)getPersionHeaderImage:(PersonModel *)person
{
    if (person.headerImagePath)
    {
        return [UIImage imageWithContentsOfFile:person.headerImagePath];
    }
    else if (person.header)
    {
        return person.header;
    }
    
    NSString *title = person.phonename;
    NSString *fid = person.tel;
    
    NSArray *tximgLis=@[@"tx_one",@"tx_two",@"tx_three",@"tx_four",@"tx_five"];
    NSString *strImg;
    if(fid.length!=0)//利用号码不同来随机颜色
    {
        NSString *strCarc= fid.length<7? [fid substringToIndex:fid.length]:[fid substringToIndex:7];
        int allnum=[strCarc intValue];
        strImg=tximgLis[allnum%5];
    }else
    {
        strImg=tximgLis[0];
    }
    if(title.length!=0)
    {
        title= title.length<2? [title substringToIndex:title.length]:[title substringToIndex:2];
    }else
    {
        title=@"测试";
    }
    
    CDFInitialsAvatar *topAvatar = [[CDFInitialsAvatar alloc] initWithRect:CGRectMake(0, 0, 50, 50) fullName:title];
    topAvatar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:strImg]];
    
    topAvatar.initialsFont=[UIFont fontWithName:@"STHeitiTC-Light" size:14];
    return topAvatar.imageRepresentation;
    
    //    CALayer *mask = [CALayer layer]; // this will become a mask for UIImageView
    //    UIImage *maskImage = [UIImage imageNamed:@"AvatarMask"]; // circle, in this case
    //    mask.contents = (id)[maskImage CGImage];
    //    mask.frame = _tximg.bounds;
    //    _tximg.layer.mask = mask;
    //    _tximg.layer.cornerRadius = YES;
    //    _tximg.image = topAvatar.imageRepresentation;
    //    _topAvatar=topAvatar;
    
}

@end
