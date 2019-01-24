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
