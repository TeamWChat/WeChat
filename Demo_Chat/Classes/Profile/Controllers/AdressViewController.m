//
//  AdressViewController.m
//  Demo_Chat
//
//  Created by 李世民 on 16/7/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "AdressViewController.h"
#import "WCProfileAdressInfoModel.h"
#import "AddAdressInfoViewController.h"

@interface AdressViewController ()
@property (nonatomic,copy) NSMutableArray *userAdressInfoArray;

@end

@implementation AdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(NSMutableArray *)userAdressInfoArray
{
    if (!_userAdressInfoArray) {
        _userAdressInfoArray = [NSMutableArray array];
    }
    return _userAdressInfoArray;
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
        return self.userAdressInfoArray.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
        }
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        cell.textLabel.text = @"左帅";
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.text = @"saaaaaaaaaaaaafsadfsagdkljklsakdgj;lksad;glk;saldkg;laskd;lgkas;ldkgl;sadjlkgfjlksadjfsdga";
        return cell;
    }
   else
   {
       BaseTableViewCell *cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
       cell.textLabel.text = @"新增地址";
       return cell;
   }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        WCNavigationController *nav = [[WCNavigationController alloc] initWithRootViewController:[AddAdressInfoViewController new]];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
