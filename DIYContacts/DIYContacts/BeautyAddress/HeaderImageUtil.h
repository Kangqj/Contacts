//
//  HeaderImageUtil.h
//  DIYContacts
//
//  Created by kangqijun on 2019/1/24.
//  Copyright © 2019 Kangqijun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDFInitialsAvatar.h"
#import "PersonModel.h"

@interface HeaderImageUtil : NSObject

+ (UIImage *)getPersionHeaderImage:(PersonModel *)person;

@end
