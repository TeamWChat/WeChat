//
//  WCEmotionView.m
//  Demo_Chat
//
//  Created by admin on 16/7/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCEmotionView.h"
#import "WCEmotionItemCell.h"
#import "WCHorizontalFlowLayout.h"

static const NSUInteger kEmotionPageCount           = 23;//23表情+1个删除s
static NSString *const  kEmotionItemCellIdentifier  = @"kEmotionItemCellIdentifier";

@interface WCEmotionView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *emotionTable;
@end


@implementation WCEmotionView

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setupCollectionView];
    }
    
    return self;
}

- (void)setupCollectionView {
    WCHorizontalFlowLayout *flowLayout = [[WCHorizontalFlowLayout alloc] init];
    flowLayout.maximumRow = 3;
    flowLayout.maximumColumn = 8;
    
    UICollectionView *emotionTable = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self addSubview:emotionTable];
    self.emotionTable = emotionTable;
    emotionTable.backgroundColor = [UIColor whiteColor];
    emotionTable.delegate = self;
    emotionTable.dataSource = self;
    emotionTable.pagingEnabled = YES;
    emotionTable.showsVerticalScrollIndicator = NO;
    emotionTable.showsHorizontalScrollIndicator = NO;
    emotionTable.alwaysBounceVertical = NO;
    emotionTable.alwaysBounceHorizontal = YES;
    emotionTable.scrollIndicatorInsets = flowLayout.sectionInset;
    
    [emotionTable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [emotionTable registerClass:[WCEmotionItemCell class] forCellWithReuseIdentifier:kEmotionItemCellIdentifier];
}

- (void)setEmotions:(NSArray<WCEmotion *> *)emotions {
    _emotions = emotions;
    [self.emotionTable reloadData];
    [self.emotionTable scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]
                              atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                      animated:NO];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return ceil(self.emotions.count*1.f/kEmotionPageCount);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger left = (_emotions.count - section * kEmotionPageCount);//剩余的个数
    NSInteger itemCount = (left > kEmotionPageCount)?kEmotionPageCount:left;//每页表情数
    return itemCount + 1;//表情数 + 1个(删除)
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WCEmotionItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kEmotionItemCellIdentifier forIndexPath:indexPath];
    NSInteger maxItemCountInSection = [collectionView numberOfItemsInSection:indexPath.section];
    if (indexPath.item != (maxItemCountInSection -1)) {//表情按钮
        cell.emotion = self.emotions[indexPath.section*kEmotionPageCount+indexPath.item];
    } else { //删除按钮
        cell.emotion = nil;
    }
    return cell;
}



@end
