//
//  BaseTableViewCell.m
//  Demo_Chat
//
//  Created by 李世民 on 16/7/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "WCProfilePersonInfo.h"



@implementation BaseTableViewCell


-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setStyle];
    }
    
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         [self setStyle];
    }
   
    return self;
}

-(instancetype)initWithAccess:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isAccess:(UITableViewCellAccessoryType)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = type;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}












+(instancetype)baseCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style access:(UITableViewCellAccessoryType)access
{
    static NSString *identifier = @"baseCellId";
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BaseTableViewCell alloc] initWithAccess:(UITableViewCellStyle)style reuseIdentifier:identifier isAccess:access];
        
    }
    return cell;
}

-(void)setStyle{
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
