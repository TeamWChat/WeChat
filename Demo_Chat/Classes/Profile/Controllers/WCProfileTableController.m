//
//  WCProfileTableController.m
//  Demo_Chat
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCProfileTableController.h"
#import "WCProfileHeadCell.h"
#import "WCProfileCell.h"
#import "WCProfileWebViewController.h"
#import "WCProfileMineInfoViewController.h"

@interface WCProfileTableController ()
@property (nonatomic,strong) NSArray *cas;
@end

@implementation WCProfileTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

-(NSArray *)cas
{
    if (!_cas) {
        NSArray *array0 = @[];
        NSArray *array1 = @[@"相册",@"收藏",@"钱包",@"卡包"];
        NSArray *array2 = @[@"表情"];
        NSArray *array3 = @[@"设置"];
        
        NSMutableArray *arrayM = [[NSMutableArray alloc] initWithObjects:array0,array1,array2,array3, nil];
        
        _cas = [arrayM mutableCopy];
    
        
    }
    return _cas;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 4;
    }
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        WCProfileHeadCell *cell = [WCProfileHeadCell  weHeadCellWithTabelView:tableView];
        return cell;
    }
    else
    {
        WCProfileCell *cell = [WCProfileCell weCellWithTabelView:tableView];
        NSInteger section = indexPath.section;
        NSInteger row = indexPath.row;
        NSArray *array = self.cas[section];
        cell.whatLabel.text = array[row];
        cell.iconImageView.image = [UIImage imageNamed:array[row]];
        return cell;
    }
    
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {//第几组
        case 0://第一组
              [self.navigationController pushViewController:[WCProfileMineInfoViewController new] animated:YES];
            break;
        case 1://第二组
            switch (indexPath.row) {//第几行
                    
                case 0://2.1
                  
                    break;
                case 1://2.2
                    
                    break;
                case 2://2.3
                    [self.navigationController pushViewController:[WCProfileWebViewController new] animated:YES];
                    break;
                case 3://2.4
                    
                    break;
                default:
                    break;
            }

            break;
        case 2://第三组
            
            break;
        case 3://第四组
            
            break;
        default:
            break;
    }
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
