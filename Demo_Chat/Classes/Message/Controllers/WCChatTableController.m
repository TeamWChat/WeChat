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

static NSString *const kWCChatRoomsCellIdentifier = @"kWCChatRoomsCellIdentifier";

@interface WCChatTableController () <UITableViewDelegate, UITableViewDataSource, WCOutputToolManagerDelegate>

@property (nonatomic, weak) WCOutputToolManager *toolManager;

@property (nonatomic, weak) UITableView         *messagesTable;

@property (nonatomic, weak) NSLayoutConstraint  *messagesTableTop;

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
    [self setupMessagesTable];
}

- (void)setupToolManager {
    WCOutputToolManager *toolManager = [WCOutputToolManager showInSupperController:self];
    toolManager.delegate = self;
    self.toolManager = toolManager;
}

- (void)setupMessagesTable {
    UITableView *messagesTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    messagesTable.delegate = self;
    messagesTable.dataSource = self;
    [self.view addSubview:messagesTable];
    self.messagesTable = messagesTable;
    messagesTable.backgroundColor = [UIColor orangeColor];
    
    //约束
    self.messagesTableTop = [messagesTable autoPinToTopLayoutGuideOfViewController:self withInset:0];
    [messagesTable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [messagesTable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [messagesTable autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.toolManager.view];
    
    //定义Cell
    [messagesTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kWCChatRoomsCellIdentifier];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWCChatRoomsCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return cell;
}

#pragma mark - WCOutputToolManagerDelegate

- (void)toolManager:(WCOutputToolManager *)toolManager willChangeFrameWithValue:(CGFloat)value duration:(CGFloat)duration{
    self.messagesTableTop.constant = -value;
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
