//
//  WCProfileMineInfoViewController.m
//  Demo_Chat
//
//  Created by 李世民 on 16/7/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCProfileMineInfoViewController.h"
#import "WCProfileCell.h"
#import "AvatarSetViewController.h"

@interface WCProfileMineInfoViewController ()
@property (nonatomic,copy) NSArray *profileArray;
@end

@implementation WCProfileMineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



-(NSArray *)profileArray
{
    if (!_profileArray) {
        NSArray *array1 = @[@"头像",@"名字",@"微信号",@"我的二维码",@"我的地址"];
        NSArray *array2 = @[@"性别",@"地区",@"个性签名"];
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
    BaseTableViewCell *cell = [BaseTableViewCell baseCellWithTableView:tableView];
    cell.textLabel.text = sectionArray[indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [cell rightImageViewAddConstraint:AVATOR];
        return cell;
    }
    else
    {
        [cell contentLabelAddConstraint:@"qwrrttfddsagfdhkjhihjkjjjkl" fontSize:16];
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
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:[AvatarSetViewController new] animated:YES];
                break;
            case 1:
                
                break;
            case 2:
                
                break;
            case 3:
                
                break;
            case 4:
                
                break;
            default:
                break;
        }
        
    }
    else
    {
        
    }
}


-(instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        NSLog(@"设置group样式");
    }
    return self;
    
}
@end
