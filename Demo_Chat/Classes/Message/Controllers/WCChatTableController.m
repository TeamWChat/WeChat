//
//  WCChatTableController.m
//  Demo_Chat
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCChatTableController.h"
#import "WCOutputToolManager.h"
#import "WCChatRoomDetailViewController.h"

//static NSString *const kWCChatRoomsCellIdentifier = @"kWCChatRoomsCellIdentifier";

@interface WCChatTableController ()

@property (nonatomic, weak) WCOutputToolManager *toolManager;



@end

@implementation WCChatTableController

#pragma mark - Lazy Load


#pragma mark - Initializaiton

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - Setup UI

- (void)setupUI {
    [self setupToolManager];
}

- (void)setupToolManager {
    WCOutputToolManager *toolManager = [WCOutputToolManager showInSupperController:self];
    self.toolManager = toolManager;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    WCChatRoomDetailViewController *roomDetailVC = [[WCChatRoomDetailViewController alloc] init];
//    roomDetailVC.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController pushViewController:roomDetailVC animated:YES];
    [self.toolManager endTyping];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWCChatRoomsCellIdentifier forIndexPath:indexPath];
//    
//    cell.textLabel.text = [self.chatRooms objectAtIndex:indexPath.row];
//    
//    return cell;
//}

@end
