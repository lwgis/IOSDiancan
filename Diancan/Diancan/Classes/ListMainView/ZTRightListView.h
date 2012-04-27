//
//  ZTRightListView.h
//  Diancan
//
//  Created by 李炜 on 12-4-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTCategory.h"
@interface ZTRightListView : UIScrollView<UIScrollViewDelegate>
@property NSInteger categoryIndex;
@property(nonatomic,retain)NSMutableArray *listRecipe;
-(void)loadRecipeWithCategory:(ZTCategory *)category;
@property NSInteger categoryID;
@end
