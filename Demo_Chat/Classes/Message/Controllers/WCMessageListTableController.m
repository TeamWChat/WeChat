//
//  WCMessageListTableController.m
//  Demo_Chat
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCMessageListTableController.h"

static NSString *const kWCChatRoomsCellIdentifier = @"kWCChatRoomsCellIdentifier";

@interface WCMessageListTableController ()

@property (nonatomic, strong) NSArray *chatRooms;

@end

@implementation WCMessageListTableController

#pragma mark - Lazy Load

- (NSArray *)chatRooms {
    if (!_chatRooms) {
        _chatRooms = @[@"message1", @"message2"];
    }
    return _chatRooms;
}

#pragma mark - Initializaiton

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kWCChatRoomsCellIdentifier];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chatRooms.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWCChatRoomsCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.chatRooms objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"PushToChatRoom" sender:nil];
}

#pragma mark -


@end
