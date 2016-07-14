//
//  WCProfileWebViewController.m
//  Demo_Chat
//
//  Created by 李世民 on 16/7/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCProfileWebViewController.h"
#import "WCProfileWebView.h"

@interface WCProfileWebViewController ()
@property (nonatomic,strong)WCProfileWebView *wcWebView;
@end

@implementation WCProfileWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.wcWebView=[[WCProfileWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self.view addSubview:self.wcWebView];
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
