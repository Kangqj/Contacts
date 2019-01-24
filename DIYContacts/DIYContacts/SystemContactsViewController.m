//
//  SystemContactsViewController.m
//  DIYContacts
//
//  Created by kangqijun on 2018/8/7.
//  Copyright © 2018年 Kangqijun. All rights reserved.
//

#import "SystemContactsViewController.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "SystemContactsTableViewCell.h"
#import "UIImage+PDExtension.h"

#define kContactKeyArray @[ CNContactPhoneNumbersKey, \
CNContactEmailAddressesKey, \
CNContactUrlAddressesKey, \
CNContactOrganizationNameKey, \
CNContactDepartmentNameKey, \
CNContactJobTitleKey, \
[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName], \
[CNContactViewController descriptorForRequiredKeys]]


@interface SystemContactsViewController () <UITableViewDelegate, UITableViewDataSource, SystemContactsTableViewCellDelegate>
{
    
}

@property (strong, nonatomic) UITableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (strong, nonatomic) CNContactStore *contactStore;

@end

@implementation SystemContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *finishItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishAddContactsData)];
    UIBarButtonItem *allItem = [[UIBarButtonItem alloc] initWithTitle:@"Select All" style:UIBarButtonItemStylePlain target:self action:@selector(selectAllContactsData)];
    self.navigationItem.rightBarButtonItems = @[finishItem, allItem];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - ([UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    self.dataArr = [NSMutableArray array];
    
    //创建CNContactStore对象,用与获取和保存通讯录信息
    self.contactStore = [[CNContactStore alloc] init];
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {//首次访问通讯录会调用
        [self.contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error) return;
            if (granted) {//允许
                NSLog(@"授权访问通讯录");
                [self fetchContactWithContactStore:self.contactStore];//访问通讯录
            }else{//拒绝
                NSLog(@"拒绝访问通讯录");//访问通讯录
            }
        }];
    }
    else{
        [self fetchContactWithContactStore:self.contactStore];//访问通讯录
    }
}

- (void)__checkAuthorizationStatus
{
    //这里有一个枚举类:CNEntityType,不过没关系，只有一个值:CNEntityTypeContacts
    switch ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts])
    {
            //存在权限
        case CNAuthorizationStatusAuthorized:
            //获取通讯录
            
            break;
            
            //权限未知
        case CNAuthorizationStatusNotDetermined:
            //请求权限
            
            break;
            //如果没有权限
        case CNAuthorizationStatusRestricted:
        case CNAuthorizationStatusDenied://需要提示
            break;
            
        default:
            break;

    }
}


- (void)fetchContactWithContactStore:(CNContactStore *)contactStore
{
    WS(weakSelf);
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized) {//有权限访问
        NSError *error = nil;
        //创建数组,必须遵守CNKeyDescriptor协议,放入相应的字符串常量来获取对应的联系人信息
//        NSArray <id<CNKeyDescriptor>> *keysToFetch = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactThumbnailImageDataKey];
        
        NSArray <id<CNKeyDescriptor>> *keysToFetch = kContactKeyArray;
        
        //创建获取联系人的请求
        CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
        //遍历查询
        [contactStore enumerateContactsWithFetchRequest:fetchRequest error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            if (!error) {
                
                PersonModel *model = [[PersonModel alloc] init];
                model.contact = contact;
                model.name = [NSString stringWithFormat:@"%@ %@", contact.givenName, contact.familyName];
                
                NSMutableArray *arr = [NSMutableArray array];
                
                for (CNLabeledValue *phoneValue in contact.phoneNumbers)
                {
                    [arr addObject:((CNPhoneNumber *)phoneValue.value).stringValue];
                }
                
                model.phoneArr = arr;

                UIImage *image = [UIImage imageWithData:contact.thumbnailImageData];
                model.header = [image circleImage];

                [weakSelf.dataArr addObject:model];
                
                if (*stop)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.mainTableView reloadData];
                    });
                }
                
            }else{
                NSLog(@"error:%@", error.localizedDescription);
            }
        }];
    }else{//无权限访问
        NSLog(@"拒绝访问通讯录");
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SystemContactsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    static NSString *cellId = @"m_cell_id";
    
    if (cell == nil)
    {
        cell = [[SystemContactsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectDelegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.indentationLevel = 1;
        cell.indentationWidth = 40;
    }
    
    PersonModel *contact = [self.dataArr objectAtIndex:indexPath.row];
    [cell loadContactData:contact];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)selectContact:(PersonModel *)contact
{
    
}

- (void)seeContactDetail:(PersonModel *)contact
{
    CNContactViewController *contactVC = [CNContactViewController viewControllerForContact:contact.contact];
    contactVC.displayedPropertyKeys = @[CNContactNamePrefixKey,
                                        CNContactGivenNameKey,
                                        CNContactMiddleNameKey,
                                        CNContactFamilyNameKey,
                                        CNContactNameSuffixKey,
                                        CNContactNicknameKey,
                                        CNContactOrganizationNameKey,
                                        CNContactDepartmentNameKey,
                                        CNContactJobTitleKey,
                                        CNContactPhoneNumbersKey,
                                        CNContactEmailAddressesKey,
                                        CNContactUrlAddressesKey];
    
    contactVC.allowsEditing    = YES;
    contactVC.allowsActions    = YES;
    contactVC.contactStore     = self.contactStore;
//    contactVC.delegate = self;
    
    [self.navigationController pushViewController:contactVC animated:YES];
}

- (void)selectAllContactsData
{
    for (PersonModel *model in self.dataArr)
    {
        model.isSelect = YES;
    }
    
    [self.mainTableView reloadData];
}

- (void)finishAddContactsData
{
    NSMutableArray *arr = [NSMutableArray array];
    
    for (PersonModel *model in self.dataArr)
    {
        if (model.isSelect)
        {
            [arr addObject:model];
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"finish_add_contact" object:arr];
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
