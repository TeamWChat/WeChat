//
//  InfoCell.m
//  Demo_Chat
//
//  Created by 李世民 on 16/7/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "InfoCell.h"

@implementation InfoCell

+(instancetype)infoCellWithTabelView:(UITableView *)tableView
{
    static NSString *identifier = @"HeadCell";
//    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
//    if (cell==nil) {
      InfoCell *  cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.leftLabel];
        self.rightLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.rightLabel];
        
        self.avatarImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.avatarImage];
        
        [self addConstraints];
    }
    return self;
}

-(void)addConstraints
{
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(2);
        make.centerY.equalTo(self.contentView);
        // 40高度
        make.height.equalTo(@40);
    
    }];
    
    // label2: 位于右上角
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //左边贴着label1
        make.left.equalTo(_leftLabel.mas_right).with.offset(2);
        make.centerY.equalTo(self.contentView);
        //上边贴着父view
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        
        //右边的间隔保持大于等于2，注意是lessThanOrEqual
        //这里的“lessThanOrEqualTo”放在从左往右的X轴上考虑会更好理解。
        //即：label2的右边界的X坐标值“小于等于”containView的右边界的X坐标值。
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        
        //只设置高度40
        make.height.equalTo(@40);
    }];
    
 
    
    //设置label1的content hugging 为1000
    [_leftLabel setContentHuggingPriority:UILayoutPriorityRequired
                               forAxis:UILayoutConstraintAxisHorizontal];
    
    //设置label1的content compression 为1000
    [_leftLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                             forAxis:UILayoutConstraintAxisHorizontal];
    
    //设置右边的label2的content hugging 为1000
    [_rightLabel setContentHuggingPriority:UILayoutPriorityRequired
                               forAxis:UILayoutConstraintAxisHorizontal];
    
    //设置右边的label2的content compression 为250
    [_rightLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                             forAxis:UILayoutConstraintAxisHorizontal];
}

//添加右边图片
-(void)rightImageViewAddConstraint:(NSString *)url
{
    _avatarImage.layer.cornerRadius = 5.0f;
    _avatarImage.clipsToBounds = YES;
    [_avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(self.contentView.mas_height).offset(-5);
        make.width.equalTo(self.contentView.mas_height).offset(-5);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        
    }];
    [_avatarImage sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [CommonUtils writeImageToFile:image imageName:@"/avatar.png"];
    }];
    
}
-(void)setTitals:(NSString *)titals
{
    _titals = titals;
    self.leftLabel.text = titals;

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
