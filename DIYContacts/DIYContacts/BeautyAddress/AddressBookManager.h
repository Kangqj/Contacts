//
//  AddressBookManager.h
//  DIYContacts
//
//  Created by kangqijun on 2019/1/30.
//  Copyright © 2019 Kangqijun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>
@class PersonModel;
typedef void (^PersonsBlock)(NSMutableArray *personArr);

@interface AddressBookManager : NSObject
{
    NSArray *_addressArr;
    NSMutableArray *_persons;
    NSMutableArray *_listContent;
    NSMutableArray *_list2Content;
}

@property (nonatomic,strong) NSMutableArray *perArr;
@property (nonatomic,strong) UILocalizedIndexedCollation *localCollation;
//@property (nonatomic,strong) PersonsBlock getPersons;
@property (strong, nonatomic) NSMutableArray *sectionTitles;

+ (AddressBookManager *)sharedManager;
- (NSMutableArray *)getAllPerson;

@end
