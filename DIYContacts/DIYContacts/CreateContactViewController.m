//
//  CreateContactViewController.m
//  DIYContacts
//
//  Created by kangqijun on 2018/8/7.
//  Copyright © 2018年 Kangqijun. All rights reserved.
//

#import "CreateContactViewController.h"
#import "HeaderViewCell.h"
#import "FieldViewCell.h"

@interface CreateContactViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *mainTableView;

@end

@implementation CreateContactViewController

@synthesize curContact;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - ([UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    if (self.curContact)
    {
        UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editContactsData)];
        self.navigationItem.rightBarButtonItem = editItem;
    }
    else
    {
        UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneContactsData)];
        self.navigationItem.rightBarButtonItem = editItem;
    }
}

- (void)editContactsData
{
    self.curContact.isEdit = !self.curContact.isEdit;
    
    [self.mainTableView reloadData];
}

- (void)doneContactsData
{
    CNMutableContact * contact = [[CNMutableContact alloc] init];
    contact.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"22"]);
    //设置名字
    contact.givenName = @"三强";
    //设置姓氏
    contact.familyName = @"钱";
    CNLabeledValue *homeEmail = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:@"316045346@qq.com"];
    CNLabeledValue *workEmail =[CNLabeledValue labeledValueWithLabel:CNLabelWork value:@"316045346@qq.com"];
    contact.emailAddresses = @[homeEmail,workEmail];
    /*
    //家庭
    CONTACTS_EXTERN NSString * const CNLabelHome                             NS_AVAILABLE(10_11, 9_0);
    //工作
    CONTACTS_EXTERN NSString * const CNLabelWork                             NS_AVAILABLE(10_11, 9_0);
    //其他
    CONTACTS_EXTERN NSString * const CNLabelOther                            NS_AVAILABLE(10_11, 9_0);
    
    // 邮箱地址
    CONTACTS_EXTERN NSString * const CNLabelEmailiCloud                      NS_AVAILABLE(10_11, 9_0);
    
    // url地址
    CONTACTS_EXTERN NSString * const CNLabelURLAddressHomePage               NS_AVAILABLE(10_11, 9_0);
    
    // 日期
    CONTACTS_EXTERN NSString * const CNLabelDateAnniversary                  NS_AVAILABLE(10_11, 9_0);
     */
    
    contact.phoneNumbers = @[[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone value:[CNPhoneNumber phoneNumberWithStringValue:@"12344312321"]]];
    CNMutablePostalAddress * homeAdress = [[CNMutablePostalAddress alloc]init];
    homeAdress.street = @"贝克街";
    homeAdress.city = @"伦敦";
    homeAdress.state = @"英国";
    homeAdress.postalCode = @"221B";
    contact.postalAddresses = @[[CNLabeledValue labeledValueWithLabel:CNLabelHome value:homeAdress]];
    NSDateComponents * birthday = [[NSDateComponents  alloc]init];
    birthday.day=7;
    birthday.month=5;
    birthday.year=1992;
    contact.birthday=birthday;
    
    //    //初始化方法
    CNSaveRequest * saveRequest = [[CNSaveRequest alloc]init];
    //    添加联系人（可以）
    [saveRequest addContact:contact toContainerWithIdentifier:nil];
    //    写入
    CNContactStore * store = [[CNContactStore alloc]init];
    [store executeSaveRequest:saveRequest error:nil];
}

- (void)deleteContact
{
    CNContactStore * store = [[CNContactStore alloc]init];
    //检索条件，检索所有名字中GivenName是W的联系人
    NSPredicate * predicate = [CNContact predicateForContactsMatchingName:@"W"];
    //提取数据
    NSArray * contacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:@[CNContactGivenNameKey] error:nil];
    CNMutableContact *contact1 = [contacts objectAtIndex:0];
    
    //    //初始化方法
    CNSaveRequest * saveRequest = [[CNSaveRequest alloc]init];
    
    //删除联系人（不行）
    [saveRequest deleteContact:contact1];
}

- (void)updateContact
{
    CNContactStore * store = [[CNContactStore alloc]init];
    //检索条件，检索所有名字中有zhang的联系人
    NSPredicate * predicate = [CNContact predicateForContactsMatchingName:@"张"];
    //提取数据
    NSArray * contacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:@[CNContactGivenNameKey] error:nil];
    CNMutableContact *contact2 = [[contacts objectAtIndex:0] mutableCopy];
    //    修改联系人的属性
    contact2.givenName = @"asdfasdfas";
    //    实例化一个CNSaveRequest
    CNSaveRequest * saveRequest = [[CNSaveRequest alloc]init];
    [saveRequest updateContact:contact2];
    [store executeSaveRequest:saveRequest error:nil];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 45;
    
    if (indexPath.row == 0)
    {
        height = 80;
    }
    else if (indexPath.row == 4)
    {
        height = 80;
    }
    else if (indexPath.row == 5)
    {
        height = 80;
    }
    
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"";
    switch (indexPath.row)
    {
        case 0:
            cellIdentifier = @"header";
            break;
        case 1:
            cellIdentifier = @"name";
            break;
        case 2:
            cellIdentifier = @"phone";
            break;
        case 3:
            cellIdentifier = @"email";
            break;
        case 4:
            cellIdentifier = @"notes";
            break;
        case 5:
            cellIdentifier = @"phones";
            break;
        default:
            break;
    }
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (indexPath.row == 0 && cell == nil)
    {
        cell = [[HeaderViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if(indexPath.row > 0 && cell == nil)
    {
        cell = [[FieldViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier type:(FieldViewCellType)(indexPath.row-1)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.curContact)
    {
        if (indexPath.row == 0)
        {
            HeaderViewCell *headerCell = (HeaderViewCell *)cell;
            [headerCell loadContactData:self.curContact];
        }
        else
        {
            FieldViewCell *headerCell = (FieldViewCell *)cell;
            [headerCell loadContactData:self.curContact];
        }
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
