//
//  PersonModel.h
//  BeautyAddressBook
//
//  Created by 余华俊 on 15/10/22.
//  Copyright © 2015年 hackxhj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>
#import "UIImage+PDExtension.h"

@interface PersonModel : NSObject
@property (nonatomic,copy) NSString *firstName;
@property (nonatomic,copy) NSString *lastName;
@property (nonatomic,copy) NSString *name1;
@property (nonatomic,copy) NSString *phoneNumber;
@property (nonatomic,copy)  NSString *phonename;
@property (nonatomic,copy)  NSString *friendId;
@property (assign, nonatomic) NSInteger sectionNumber;
@property (assign, nonatomic) NSInteger recordID;
@property (assign, nonatomic) BOOL rowSelected;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *tel;
@property (nonatomic, strong) NSData *icon;//图片



@property (strong, nonatomic) NSString *headerImagePath;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *phoneArr;
@property (strong, nonatomic) NSString *note;
@property (strong, nonatomic) NSString *photos;


@property (strong, nonatomic) CNContact *contact;
@property (assign, nonatomic) BOOL isSelect;
@property (assign, nonatomic) BOOL isEdit;
@property (strong, nonatomic) UIImage *header;


@end
