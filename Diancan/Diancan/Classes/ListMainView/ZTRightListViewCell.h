//
//  ZTLeftListViewCell.h
//  Diancan
//
//  Created by 李炜 on 12-4-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTCategory.h"
#import "ZTRecipe.h"

@interface ZTRightListViewCell : UIView{
    UIView *currentView;
}
- (id)initWithFrame:(CGRect)frame recipe:(ZTRecipe *)aRecipe;
-(void)loadRecipe:(ZTRecipe *)aRecipe;
@property(nonatomic,retain) ZTRightListViewCell *previousZTRightListViewCell;
@property(nonatomic,retain) ZTRightListViewCell *behindZTRightListViewCell;
@property CGPoint startPoint;
@property(nonatomic,retain) ZTRecipe *recipe;
@property(nonatomic,retain)UIView *buttomView;
@property BOOL isExtend;
@end

