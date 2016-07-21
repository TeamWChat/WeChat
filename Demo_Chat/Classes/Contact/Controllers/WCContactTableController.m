//
//  WCContactTableController.m
//  Demo_Chat
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCContactTableController.h"
#import "BaseTableViewCell.h"
#import "SearchViewController.h"

@interface WCContactTableController ()<UISearchResultsUpdating,UISearchControllerDelegate,WCSearchControllerDelegate>
@property (nonatomic,strong) SearchViewController *searchController;
@property (nonatomic,copy) NSMutableArray *searchResults;
@property (nonatomic,copy) NSMutableArray *dataArray;
@end

@implementation WCContactTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSearchControllerView];
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            NSMutableArray *array = [NSMutableArray array];
            for (int j = 0; j < 20; j++) {
                 NSString *str = [NSString stringWithFormat:@"这是%d",j];
                [array addObject:str];
            }
            [_dataArray addObject:array];
        }
    }
    return _dataArray;
}


-(void)setSearchControllerView
{
    self.searchController = [[SearchViewController alloc] initWithSearchResultsController:nil];
    self.searchController.searchBar.frame = CGRectMake(0, 0, WIDTH, 40);
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
//    self.searchController.searchResultsUpdater = self;
    self.searchController.delegae = self;
    self.searchController.delegate = self;
    self.tableView.sectionIndexColor = [UIColor blackColor];
    self.tableView.sectionIndexBackgroundColor=[UIColor clearColor];
    
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    
    self.tableView.tableHeaderView.frame = self.searchController.searchBar.frame;

}

//截屏
-(UIImage *)getScreen
{
    
    UIGraphicsBeginImageContextWithOptions(self.tableView.frame.size, YES, 0);
    [self.tableView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


-(void)willPresentSearchController:(UISearchController *)searchController
{
    self.hidesBottomBarWhenPushed = YES;
}
-(void)willDismissSearchController:(UISearchController *)searchController
{
    self.hidesBottomBarWhenPushed = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *array = self.dataArray[section];
    return array.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"contractCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSArray *array = self.dataArray[indexPath.section];
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    return [[self createSectionsTitle] objectAtIndex:section+1];
}

-(NSArray *)createSectionsTitle
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:UITableViewIndexSearch];
    for (char c = 'A'; c < 'A' + self.dataArray.count; c++) {
        [array addObject:[NSString stringWithFormat:@"%c",c]];
    }
    [array addObject:@"#"];
    return array;
}

#pragma mark 
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
   
    return [self createSectionsTitle];
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (index == 0) {
        [tableView scrollRectToVisible:self.searchController.searchBar.frame animated:YES];
        return -1;
    }
    
    return index - 1;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


-(void)deletaDataWithIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = self.dataArray[indexPath.section];
    [array removeObjectAtIndex:indexPath.row];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self deletaDataWithIndexPath:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED;
{
    UITableViewRowAction *edAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"备注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    edAction.backgroundColor = [UIColor grayColor];
    return @[edAction];
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
