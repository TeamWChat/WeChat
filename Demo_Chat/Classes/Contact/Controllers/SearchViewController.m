//
//  SearchViewController.m
//  Demo_Chat
//
//  Created by 李世民 on 16/7/18.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SearchViewController.h"
#import "UIImage+ImageEffects.h"


@interface SearchViewController ()<UISearchBarDelegate,UISearchControllerDelegate>
@property (nonatomic, strong) UIImageView *fuzzyView;
@property (nonatomic, strong) UIView *adviceView;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController
{
    self = [super initWithSearchResultsController:searchResultsController];
    if (self) {
        self.searchBar.delegate  = self;
        
        self.searchBar.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
        for (UIView *view in self.searchBar.subviews) {
            
            // for before iOS7.0
            if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [view removeFromSuperview];
                break;
            }
            // for later iOS7.0(include)
            if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
                [[view.subviews objectAtIndex:0] removeFromSuperview];
                break;
            }
        }
        self.searchBar.placeholder = @"搜索";
        
        
        UITextField *field = [self.searchBar valueForKey:@"searchField"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"语音"] forState:UIControlStateNormal];
        [self.searchBar addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(field.mas_right).offset(-5);
            make.centerY.equalTo(field.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
    }
    return self;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    searchBar.showsCancelButton = YES;
    UIButton *btn=[searchBar valueForKey:@"cancelButton"];
    [btn setTintColor:GreenColorForWeixin];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
   
    //高斯模糊背景  微信有可能是图片
    [self.view addSubview:[self setGsBackGroundImageView]];
}


//高斯模糊背景
-(UIImageView *)setGsBackGroundImageView
{
    //获取截图
    UIImage *screenImage = [self.delegae getScreen];
    
    UIImage *gsImage = [screenImage blurImageAtFrame:CGRectMake(0, 0 , WIDTH, HEIGHT)];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:gsImage];
    bgImageView.frame = CGRectMake(0, 20, WIDTH, HEIGHT+64);
    return bgImageView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
