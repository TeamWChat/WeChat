//
//  WCProfileCell.h
//  Demo_Chat
//
//  Created by 李世民 on 16/7/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCProfileCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *whatLabel;


+(instancetype)weCellWithTabelView:(UITableView *)tableView;
+(CGFloat)weProfileCellAddHeight;
@end
