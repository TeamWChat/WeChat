//
//  WCProfileMineInfoViewController.m
//  Demo_Chat
//
//  Created by 李世民 on 16/7/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCProfileMineInfoViewController.h"
#import "WCProfileCell.h"
#import "WCProfilePersonInfo.h"
#import "AvatarSetViewController.h"
#import "NameChangeViewController.h"
#import "AdressViewController.h"


@interface WCProfileMineInfoViewController ()
@property (nonatomic,copy) NSArray *profileArray;
@end

@implementation WCProfileMineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
 
}

#define UserAvatar @"头像"
#define UserName @"名字"
#define UserId @"微信号"
#define UserCode @"我的二维码"

#define UserAdress @"我的地址"
#define UserSex @"性别"
#define UserLocation @"地区"
#define UserWantSay @"个性签名"

-(NSArray *)profileArray
{
    if (!_profileArray) {
        NSArray *array1 = @[UserAvatar,UserName,UserId,UserCode,UserAdress];
        NSArray *array2 = @[UserSex,UserLocation,UserWantSay];
        NSMutableArray *array = [NSMutableArray arrayWithObjects:array1,array2, nil];
        _profileArray = [array mutableCopy];
    }
    return _profileArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 5;
    }
    return 3;
}

//头像地址
#define AVATOR @"http://ww4.sinaimg.cn/large/610dc034jw1f5md1e68p9j20fk0ncgo0.jpg"

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionArray = self.profileArray[indexPath.section];
    WCProfilePersonInfo *model = [WCProfilePersonInfo shareInstance];

    
    
    BaseTableViewCell *cell = [BaseTableViewCell baseCellWithTableView:tableView];
    cell.textLabel.text = sectionArray[indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [cell rightImageViewAddConstraint:AVATOR];
        return cell;
    }
    else
    {
        NSString *text = @"";
        if ([cell.textLabel.text isEqualToString:UserName]) {
            
            text = model.userName;
        }
        else if([cell.textLabel.text isEqualToString:UserId])
        {
            text = model.userId;
        }
        else if ([cell.textLabel.text isEqualToString:UserCode])
        {
            text = @"";
        }
        else if ([cell.textLabel.text isEqualToString:UserAdress])
        {
            text = model.adress;
        }
        else if ([cell.textLabel.text isEqualToString:UserSex])
        {
            text = model.sex;
        }
        else if ([cell.textLabel.text isEqualToString:UserLocation])
        {
            text = model.location;
        }
        else if ([cell.textLabel.text isEqualToString:UserWantSay])
        {
            text = model.whatHeWhatToSay;
        }
        [cell contentLabelAddConstraint:text fontSize:16 width:270 height:CGFLOAT_MAX];
        
        return cell;
    }
    return nil;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return [WCProfileCell weProfileCellAddHeight];
    }
    return 40;
}


//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed=YES;
    UIViewController *viewController = [[UIViewController alloc] init];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0://头像
                viewController = [AvatarSetViewController new];
                break;
            case 1://名字
                viewController = [NameChangeViewController new];
                break;
            case 2://微信号
                
                break;
            case 3://我的二维码
                
                break;
            case 4://我的地址
                viewController = [AdressViewController new];
                break;
            default:
                break;
        }
        
    }
    else
    {
        switch (indexPath.row) {
            case 0://性别
                
                break;
            case 1://地区
                
                break;
            case 2://个性签名
                
                break;
            default:
                break;
        }
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
    self.hidesBottomBarWhenPushed=NO;
    
}

#pragma mark 
//每次显示刷新
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}



-(instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        NSLog(@"设置group样式");
    }
    return self;
    
}
@end
