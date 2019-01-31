//
//  ViewController.m
//  DIYContacts
//
//  Created by kangqijun on 2018/8/6.
//  Copyright © 2018年 Kangqijun. All rights reserved.
//https://blog.csdn.net/luobo140716/article/details/49584865
//https://blog.csdn.net/zhouzhoujianquan/article/details/52218390

#import "ViewController.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "SystemContactsViewController.h"
#import "ContactsTableViewCell.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#import "CreateContactViewController.h"
#import "AddressBookManager.h"
#import "PersonModel.h"
#import "PersonCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, CNContactPickerDelegate, CNContactViewControllerDelegate>
{
    UITableView *mainTableView;
}

@property (nonatomic, strong) CTCallCenter *callCenter;
@property(nonatomic,strong)NSMutableArray *listContent;
@property (strong, nonatomic) NSMutableArray *sectionTitles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContactsData)];
    self.navigationItem.rightBarButtonItem = addItem;
    
    _sectionTitles=[NSMutableArray new];
    
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - ([UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height))];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.sectionIndexBackgroundColor=[UIColor clearColor];
    mainTableView.sectionIndexColor = [UIColor blackColor];
    [self.view addSubview:mainTableView];
    mainTableView.tableFooterView = [[UIView alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self initData];
        dispatch_sync(dispatch_get_main_queue(), ^
                      {
                          [self setTitleList];
                          [mainTableView reloadData];
                      });
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadContactData:) name:@"finish_add_contact" object:nil];
}

- (void)addContactsData
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加私密联系人" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"新建私密联系人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        CreateContactViewController *vc = [[CreateContactViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    UIAlertAction *systemAction = [UIAlertAction actionWithTitle:@"从手机通讯录添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        SystemContactsViewController *vc = [[SystemContactsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:addAction];
    [alertController addAction:systemAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)reloadContactData:(NSNotification *)notify
{
    NSMutableArray *arr = (NSMutableArray *)notify.object;
    self.listContent = arr;
    
    [mainTableView reloadData];
}

#pragma mark - 添加联系人
- (void)creatContact{
    
    CNMutableContact *contact = [[CNMutableContact alloc] init]; // 第一次运行的时候，会获取通讯录的授权（对通讯录进行操作，有权限设置）
    
    // 1、添加姓名（姓＋名）
    contact.givenName = @"san";
    contact.familyName = @"wangg";
    //    contact.nickname = @"hahahah"; // 昵称
    //    contact.nameSuffix = @"nameSuffix"; // 名字后缀
    //    contact.namePrefix = @"namePrefix"; // 前字后缀
    //    contact.previousFamilyName = @"previousFamilyName"; // 之前的familyName
    
    // 2、添加职位相关
    contact.organizationName = @"公司名称";
    contact.departmentName = @"开发部门";
    contact.jobTitle = @"工程师";
    
    // 3、这一部分内容会显示在联系人名字的下面，phoneticFamilyName属性设置的话，会影响联系人列表界面的排序
    //    contact.phoneticGivenName = @"GivenName";
    //    contact.phoneticFamilyName = @"FamilyName";
    //    contact.phoneticMiddleName = @"MiddleName";
    
    // 4、备注
    contact.note = @"同事";
    
    // 5、头像
    contact.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"1"]);
    
    // 6、添加生日
    NSDateComponents *birthday = [[NSDateComponents alloc] init];
    birthday.year = 1990;
    birthday.month = 6;
    birthday.day = 6;
    contact.birthday = birthday;
    
    
    // 7、添加邮箱
    CNLabeledValue *homeEmail = [CNLabeledValue labeledValueWithLabel:CNLabelEmailiCloud value:@"bvbdsmv@icloud.com"];
    //    CNLabeledValue *workEmail = [CNLabeledValue labeledValueWithLabel:CNLabelWork value:@"11111888888"];
    //    CNLabeledValue *iCloudEmail = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:@"34454554"];
    //    CNLabeledValue *otherEmail = [CNLabeledValue labeledValueWithLabel:CNLabelOther value:@"6565448"];
    contact.emailAddresses = @[homeEmail];
    
    
    // 8、添加电话
    CNLabeledValue *homePhone = [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone value:[CNPhoneNumber phoneNumberWithStringValue:@"11122233344"]];
    contact.phoneNumbers = @[homePhone];
    
    // 9、添加urlAddresses,
    CNLabeledValue *homeurl = [CNLabeledValue labeledValueWithLabel:CNLabelURLAddressHomePage value:@"http://baidu.com"];
    contact.urlAddresses = @[homeurl];
    
    // 10、添加邮政地址
    CNMutablePostalAddress *postal = [[CNMutablePostalAddress alloc] init];
    postal.city = @"北京";
    postal.country =  @"中国";
    CNLabeledValue *homePostal = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:postal];
    contact.postalAddresses = @[homePostal];
    
    
    // 获取通讯录操作请求对象
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    [request addContact:contact toContainerWithIdentifier:nil]; // 添加联系人操作（同一个联系人可以重复添加）
    // 获取通讯录
    CNContactStore *store = [[CNContactStore alloc] init];
    // 保存联系人
    [store executeSaveRequest:request error:nil]; // 通讯录有变化之后，还可以监听是否改变（CNContactStoreDidChangeNotification）
}


-(void)setTitleList
{
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    [self.sectionTitles removeAllObjects];
    [self.sectionTitles addObjectsFromArray:[theCollation sectionTitles]];
    NSMutableArray * existTitles = [NSMutableArray array];
    for(int i=0;i<[_listContent count];i++)//过滤 就取存在的索引条标签
    {
        PersonModel *pm=_listContent[i][0];
        for(int j=0;j<_sectionTitles.count;j++)
        {
            if(pm.sectionNumber==j)
                [existTitles addObject:self.sectionTitles[j]];
        }
    }
    
    
    
    
    [self.sectionTitles removeAllObjects];
    self.sectionTitles =existTitles;
    
}


-(NSMutableArray*)listContent
{
    if(_listContent==nil)
    {
        _listContent=[NSMutableArray new];
    }
    return _listContent;
}

-(void)initData
{
    self.listContent = [[AddressBookManager sharedManager] getAllPerson];
    if(_listContent == nil)
    {
        NSLog(@"数据为空或通讯录权限拒绝访问，请到系统开启");
        return;
    }
}

//开启右侧索引条
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionTitles;
}

//几个  section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_listContent count];
    
}
//对应的section有多少row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[_listContent objectAtIndex:(section)] count];
    
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
//section的高度

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if(self.sectionTitles==nil||self.sectionTitles.count==0)
        return nil;
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"uitableviewbackground"]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)];
    label.backgroundColor = [UIColor clearColor];
    NSString *sectionStr=[self.sectionTitles objectAtIndex:(section)];
    [label setText:sectionStr];
    [contentView addSubview:label];
    return contentView;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdenfer=@"addressCell";
    PersonCell *personcell=(PersonCell*)[tableView dequeueReusableCellWithIdentifier:cellIdenfer];
    if(personcell==nil)
    {
        personcell=[[PersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenfer];
    }
    
    NSArray *sectionArr=[_listContent objectAtIndex:indexPath.section];
    PersonModel *people = (PersonModel *)[sectionArr objectAtIndex:indexPath.row];
    [personcell setData:people];
    
    return personcell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *sectionArr=[_listContent objectAtIndex:indexPath.section];
    PersonModel *people = (PersonModel *)[sectionArr objectAtIndex:indexPath.row];
    
    CreateContactViewController *vc = [[CreateContactViewController alloc] init];
    vc.curContact = people;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)monitorTelephoneCall {
    // MsgAppStarting
    // MsgAppReactivate
    self.callCenter = [[CTCallCenter alloc] init];
    self.callCenter.callEventHandler = ^(CTCall * call) {
        if ([call.callState isEqualToString:CTCallStateDisconnected]) {// Call has been disconnected
            NSLog(@"电话 --- 断开连接");
        }
        else if ([call.callState isEqualToString:CTCallStateConnected]) {// Call has just been connected
            NSLog(@"电话 --- 接通");
            // 通知 H5 当前截屏操作
            dispatch_async(dispatch_get_main_queue(), ^{
                // do somethings
            });
            
        }
        else if ([call.callState isEqualToString:CTCallStateIncoming]) {// Call is incoming
            NSLog(@"电话 --- 待接通");
        }
        else if ([call.callState isEqualToString:CTCallStateDialing]) {// Call is Dialing
            NSLog(@"电话 --- 拨号中");
            // 通知 H5 当前截屏操作
            dispatch_async(dispatch_get_main_queue(), ^{
                // do somethings
            });
            
        }
        else {// Nothing is done"
            NSLog(@"电话 --- 无操作");
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
