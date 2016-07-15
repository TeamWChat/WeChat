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

//添加contentlabel
-(void)contentLabelAddConstraint:(NSString *)str fontSize:(CGFloat)font width:(CGFloat)width height:(CGFloat)height{
    
    CGSize size = [CommonUtils getLabelSize:str fontSize:font width:width height:height];
    UILabel * contentLabel = [[UILabel alloc] init];
    _contentLabel = contentLabel;
    [self.contentView addSubview:self.contentLabel];
    self.contentLabel.font = [UIFont systemFontOfSize:font];
    self.contentLabel.text = str;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.textLabel.mas_right).offset(10);
        make.centerY.equalTo(self.textLabel);
        make.right.equalTo(self.contentView.mas_right);
        make.size.mas_equalTo(size);
    }];
}

//添加右边图片
-(void)rightImageViewAddConstraint:(NSString *)url
{
    
    UIImageView *rightImageView = [[UIImageView alloc] init];
    _rightImageView = rightImageView;
    [self.contentView addSubview:_rightImageView];
    _rightImageView.layer.cornerRadius = 5.0f;
    _rightImageView.clipsToBounds = YES;
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textLabel);
        make.right.equalTo(self.contentView.mas_right);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [CommonUtils writeImageToFile:image imageName:@"/avatar.png"];
    }];
    
}




+(instancetype)baseCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"baseCellId";
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
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
