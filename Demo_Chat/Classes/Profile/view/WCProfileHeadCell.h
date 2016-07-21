//
//  WCProfileHeadCell.h
//  Demo_Chat
//
//  Created by 李世民 on 16/7/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCProfileHeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;

+(instancetype)weHeadCellWithTabelView:(UITableView *)tableView;
@end
