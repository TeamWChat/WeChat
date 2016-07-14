//
//  BaseTableViewCell.m
//  Demo_Chat
//
//  Created by 李世民 on 16/7/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BaseTableViewCell.h"



@implementation BaseTableViewCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self setStyle];
    
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setStyle];
    
   

    return self;
}


//添加contentlabel
-(void)contentLabelAddConstraint:(NSString *)str fontSize:(CGFloat)font
{
   
    CGSize size = [CommonUtils getLabelSize:str fontSize:font];
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
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textLabel);
        make.right.equalTo(self.contentView.mas_right);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self writeImageToPlist:image];
    }];
    
}

//将图片写入plist文件
-(void)writeImageToPlist:(UIImage *)image
{
    //获取沙盒路径，
    NSString *path_sandox = NSHomeDirectory();
    //创建一个存储plist文件的路径
    NSString *newPath = [path_sandox stringByAppendingPathComponent:@"/Documents/pic.plist"];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    //把图片转换为Base64的字符串
    NSData *data = UIImageJPEGRepresentation(image, 1);
    NSString *image64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [arr addObject:image64];
    //写入plist文件
    if ([arr writeToFile:newPath atomically:YES]) {
        NSLog(@"写入成功");
    };
    
    
    //1.获得数据库文件的路径
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    
    NSString *fileName = [doc stringByAppendingPathComponent:@"pic.sqlite"];
    
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]) {
        BOOL ret = [db executeUpdate:@"create table if not exists t_pic (photo blob)"];
        if (ret) {
            NSLog(@"添加成功");
        }
        else
        {
            NSLog(@"添加失败");
        }
    }
    if ([db open]) {
        BOOL ret = [db executeUpdate:@"insert into t_pic (photo) values (?)",data];
        if (ret) {
            NSLog(@"图片添加成功");
        }
        else
        {
            NSLog(@"图片添加失败");
        }
    }
    [db close];
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
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
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
