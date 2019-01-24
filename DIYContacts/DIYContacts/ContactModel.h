//
//  ContactModel.h
//  DIYContacts
//
//  Created by kangqijun on 2018/8/7.
//  Copyright © 2018年 Kangqijun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>
#import "UIImage+PDExtension.h"

@interface ContactModel : NSObject

@property (strong, nonatomic) NSString *headerImagePath;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *phoneArr;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *note;
@property (strong, nonatomic) NSString *photos;


@property (strong, nonatomic) CNContact *contact;
@property (assign, nonatomic) BOOL isSelect;
@property (assign, nonatomic) BOOL isEdit;
@property (strong, nonatomic) UIImage *header;

@end
