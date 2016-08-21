//
//  WCHorizontalFlowLayout.m
//  Demo_Chat
//
//  Created by admin on 16/8/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCHorizontalFlowLayout.h"

static const CGFloat    kSectionInsetMargin      = 15.f;

@interface WCHorizontalFlowLayout ()
@end

@implementation WCHorizontalFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sectionInset = UIEdgeInsetsMake(kSectionInsetMargin,
                                             kSectionInsetMargin,
                                             kSectionInsetMargin,
                                             kSectionInsetMargin);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;//设置水平滚动
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
}

- (void)invalidateLayout {
    [super invalidateLayout];
    CGRect collectionViewFrame = self.collectionView.frame;
    if (!CGRectEqualToRect(collectionViewFrame, CGRectZero)) {
        self.itemSize = CGSizeMake((CGRectGetWidth(self.collectionView.frame)-2*kSectionInsetMargin)/self.maximumColumn,
                                   (CGRectGetHeight(self.collectionView.frame)-2*kSectionInsetMargin)/self.maximumRow);
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributesInRect =[super layoutAttributesForElementsInRect:rect];
    NSArray *attributes = [[NSArray alloc] initWithArray:attributesInRect copyItems:YES];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [self modifyLayoutAttributes:attribute];
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    [self modifyLayoutAttributes:attributes];
    return attributes;
}

- (void)modifyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes {
    NSIndexPath *indexPath = attributes.indexPath;
    CGFloat originX = CGRectGetWidth(self.collectionView.frame)*indexPath.section+(indexPath.item%self.maximumColumn)*self.itemSize.width+kSectionInsetMargin;
    CGFloat originY = kSectionInsetMargin + (indexPath.item/8)*self.itemSize.height;
    attributes.frame = CGRectMake(originX, originY, CGRectGetWidth(attributes.frame), CGRectGetHeight(attributes.frame));
}


@end
