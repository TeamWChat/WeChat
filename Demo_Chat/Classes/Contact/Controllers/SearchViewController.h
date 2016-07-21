//
//  SearchViewController.h
//  Demo_Chat
//
//  Created by 李世民 on 16/7/18.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WCSearchControllerDelegate <NSObject>

-(UIImage *)getScreen;

@end

@interface SearchViewController : UISearchController
//@property (nonatomic,strong) UISearchController *searchController;
//@property (nonatomic,copy) NSMutableArray *searchResults;
@property (nonatomic,weak)id<WCSearchControllerDelegate> delegae;

//截图
@property (nonatomic,copy) UIImage *screenImage;
@end
