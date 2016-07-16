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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didSendMessage:)
                                                 name:kWCInputViewDidSendMessageNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kWCInputViewDidSendMessageNotification
                                                  object:nil];
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
    [self.toolManager popDown];
}

#pragma mark - Notification Selector

- (void)didSendMessage:(NSNotification *)notification {
    NSString *message = notification.userInfo[kWCInputViewMessageKey];
    NSLog(@"%@", message);
}

#pragma mark - UITableViewDataSource

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
