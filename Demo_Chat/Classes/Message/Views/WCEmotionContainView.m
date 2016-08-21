//
//  WCEmotionContainView.m
//  Demo_Chat
//
//  Created by admin on 16/8/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCEmotionContainView.h"
#import "WCEmotionView.h"
#import "WCEmotion.h"
#import "WCEmotionBag.h"

static const CGFloat kToolBarHeight = 50.f;

@interface WCEmotionContainView ()

@property (nonatomic, weak) UIScrollView *toolBarView;//底部表情选择菜单

@property (nonatomic, strong) NSMutableArray *tabBarItems;

@property (nonatomic, strong) NSMutableArray *emotionBags;//表情包

@property (nonatomic, weak) WCEmotionView *emotionView;

@property (nonatomic, assign) CGFloat contentWidth;//toolBarView的contentSize设置

@end


@implementation WCEmotionContainView

#pragma mark - Lazy Load

- (NSMutableArray *)emotionBags {
    if (!_emotionBags) {
        _emotionBags = [NSMutableArray array];
    }
    return _emotionBags;
}

- (UIScrollView *)toolBarView {
    if (!_toolBarView) {
        UIScrollView *toolBarView = [[UIScrollView alloc] init];
        [self addSubview:toolBarView];
        toolBarView.showsHorizontalScrollIndicator = NO;
        toolBarView.showsVerticalScrollIndicator = NO;
        _toolBarView = toolBarView;
    }
    return _toolBarView;
}

- (NSMutableArray *)tabBarItems {
    if (!_tabBarItems) {
        _tabBarItems = [NSMutableArray array];
    }
    return _tabBarItems;
}

- (WCEmotionView *)emotionView {
    if (!_emotionView) {
        WCEmotionView *emotionView = [[WCEmotionView alloc] init];
        [self addSubview:emotionView];
        emotionView.backgroundColor = [UIColor greenColor];
        _emotionView = emotionView;
    }
    return _emotionView;
}

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        [self setupLayoutConstraint];
    }
    return self;
}

- (void)setupLayoutConstraint {
    //toolBarView约束
    [self.toolBarView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.toolBarView autoSetDimension:ALDimensionHeight toSize:kToolBarHeight];
    //emotionView约束
    [self.emotionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.emotionView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.toolBarView withOffset:0];
    [self setNeedsLayout];
}

#pragma mark - Public

- (void)addEmotionBag:(WCEmotionBag *)emotionBag {
    UIFont *font = [UIFont systemFontOfSize:14.f];
    CGFloat itemWidth = [emotionBag.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                       options:(NSStringDrawingUsesFontLeading|
                                                                NSStringDrawingUsesLineFragmentOrigin)
                                                    attributes:@{NSFontAttributeName:font}
                                                       context:nil].size.width + 40;
    UIButton *tabBarItem = [[UIButton alloc] init];
    tabBarItem.titleLabel.font = font;
    [tabBarItem setTitle:emotionBag.title forState:UIControlStateNormal];
    [tabBarItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.toolBarView addSubview:tabBarItem];

    //设置Frame
    CGFloat width = itemWidth;
    CGFloat height = kToolBarHeight;
    CGFloat originY = 0;
    CGFloat originX = 0;
    if (self.emotionBags.count > 0) {
        UIButton *lastTabBarItem = [self.tabBarItems lastObject];
        [self addSeparatorWithLastTabBarItem:lastTabBarItem];
        originX = CGRectGetMaxX(lastTabBarItem.frame) + 1;
    }
    tabBarItem.frame = CGRectMake(originX, originY, width, height);
    
    
    //添加事件
    [tabBarItem addTarget:self action:@selector(respondsToTabBarItemTouch:) forControlEvents:UIControlEventTouchDown];
    [self.emotionBags addObject:emotionBag];
    [self.tabBarItems addObject:tabBarItem];
    
    self.contentWidth += itemWidth;
}

- (void)addSeparatorWithLastTabBarItem:(UIButton *)lastTabBarItem {
    UIView *separatorView = [[UIView alloc] init];
    CGFloat separatorHeight = 30.f;
    separatorView.frame = CGRectMake(CGRectGetMaxX(lastTabBarItem.frame),
                                     (CGRectGetHeight(lastTabBarItem.frame)-separatorHeight)/2,
                                     1,
                                     separatorHeight);
    separatorView.backgroundColor = [UIColor lightGrayColor];
    [self.toolBarView addSubview:separatorView];
}

- (void)setContentWidth:(CGFloat)contentWidth {
    _contentWidth = contentWidth;
    
    CGFloat toolBarViewContentWidth = contentWidth;
    if (contentWidth < kScreenWidth) {
        toolBarViewContentWidth = kScreenWidth + 10;
    }
    self.toolBarView.contentSize = CGSizeMake(toolBarViewContentWidth, 50);
}

- (void)respondsToTabBarItemTouch:(UIButton *)sender {
    self.emotionView.emotions = [[self.emotionBags objectAtIndex:[self.tabBarItems indexOfObject:sender]] emotions];
    
    NSLog(@"ddd");
}

@end
