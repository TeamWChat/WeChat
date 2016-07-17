//
//  WCEmotionView.m
//  Demo_Chat
//
//  Created by admin on 16/7/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCEmotionView.h"
#import "WCEmotionItemCell.h"

static const CGFloat    kCollectionInsetMargin      = 15.f;
static const NSUInteger kEmotionPageCount           = 23;//23表情+1个删除s
static const NSUInteger kEmotionMaxRow              = 3;//3行
static const NSUInteger kEmotionMaxColumn           = 8;//8列
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
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//设置水平滚动
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(kCollectionInsetMargin,
                                               kCollectionInsetMargin,
                                               kCollectionInsetMargin,
                                               kCollectionInsetMargin);
    
    UICollectionView *emotionTable = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    emotionTable.backgroundColor = [UIColor redColor];
    [self addSubview:emotionTable];
    self.emotionTable = emotionTable;
    
    emotionTable.delegate = self;
    emotionTable.dataSource = self;
    emotionTable.pagingEnabled = YES;
    emotionTable.showsVerticalScrollIndicator = NO;
    emotionTable.showsHorizontalScrollIndicator = NO;
    
    [emotionTable registerClass:[WCEmotionItemCell class] forCellWithReuseIdentifier:kEmotionItemCellIdentifier];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat emotionViewWidth = self.frame.size.width;
    CGFloat emotionViewHeight = self.frame.size.height;
    //设置emotionTable的frame
    CGFloat emotionTableHeight = emotionViewHeight - 80;
    self.emotionTable.frame = CGRectMake(0, 0, emotionViewWidth, emotionTableHeight);
    
    //计算itemSize
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.emotionTable.collectionViewLayout;
    
    CGFloat itemWidth = (emotionViewWidth - 2 * kCollectionInsetMargin)/kEmotionMaxColumn;
    CGFloat itemHeight = (emotionTableHeight - 2 * kCollectionInsetMargin)/kEmotionMaxRow;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (void)setEmotions:(NSArray<WCEmotion *> *)emotions {
    _emotions = emotions;
    
    [self setNeedsLayout];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return (self.emotions.count/kEmotionPageCount);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger left = (_emotions.count - section * kEmotionPageCount);//剩余的个数
    NSInteger itemCount = (left > kEmotionPageCount)?kEmotionPageCount:left;//每页表情数
    return itemCount + 1;//表情数 + 1个(删除)
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WCEmotionItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kEmotionItemCellIdentifier forIndexPath:indexPath];
    
    if (indexPath.item != kEmotionPageCount) {//表情按钮
        cell.emotion = self.emotions[indexPath.section*kEmotionPageCount+indexPath.item];
        cell.backgroundColor = [UIColor clearColor];
    } else { //删除按钮
        cell.emotion = nil;
        cell.backgroundColor = [UIColor blackColor];
    }

    return cell;
}



@end
