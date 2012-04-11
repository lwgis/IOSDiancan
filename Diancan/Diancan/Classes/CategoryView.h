//
//  CategoryView.h
//  Diancan
//
//  Created by 李炜 on 12-3-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FoodView.h"
#import "ZTCategory.h"
@interface CategoryView : UIView{
    NSInteger showIndex;
}
@property(nonatomic,retain)UIImageView *categoryImageView;

@property(nonatomic,retain)UILabel *labelTopCategoryName;
@property(nonatomic,assign) ZTCategory *category;
@property BOOL isVerticalMoved;
@property BOOL isHorizontalMoved;
@property CGPoint startMyPoint;
@property(nonatomic,retain)NSMutableArray *listFoodView;
@property(nonatomic,assign) CategoryView *previousCategoryView;
@property(nonatomic,assign) CategoryView *behindCategoryView;
@property(nonatomic,assign) FoodView *currentFoodView;
-(CategoryView *)verticalMoverView:(CGFloat)distance;
-(CategoryView *)verticalMoverNext:(CGFloat)distance;
-(void)horizontalMoveView:(CGFloat)distance;
-(void)horizontalMoveNext:(CGFloat)distance;
-(void)setTitleImage:(BOOL)isTop;
-(void)loadDataByCategory:(ZTCategory *)category;
-(void)setCategoryInfo:(ZTCategory *)category;
-(void)ShowFoodView:(NSInteger)index Animation:(BOOL)isAnimation;
@end
