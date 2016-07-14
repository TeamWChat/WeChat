//
//  WCProfileWebView.m
//  Demo_Chat
//
//  Created by 李世民 on 16/7/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCProfileWebView.h"
#import <objc/runtime.h>


#define PURSEURL @"http://jandan.net/ooxx"

@implementation WCProfileWebView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.myRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:PURSEURL]];
        [self loadRequest:self.myRequest];
        self.delegate = self;
    }
    return self;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"正在加载");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载完毕");
}


@end
