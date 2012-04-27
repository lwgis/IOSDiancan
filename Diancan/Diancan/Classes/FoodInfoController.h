//
//  FoodInfoController.h
//  Diancan
//
//  Created by 李炜 on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodCell.h"
#import "CategoryDailog.h"
#import "FoodInfoView.h"
@interface FoodInfoController : UIViewController<UIGestureRecognizerDelegate>
@property(nonatomic,retain)UIPanGestureRecognizer *gestureRecognizer;
@property(nonatomic,retain)NSMutableArray *listRecipe;
@property(nonatomic,retain)NSMutableArray *listFoodInfoView;
@property(nonatomic,retain)UIButton *categoryBtn;
@property(nonatomic,assign)CategoryDailog *categoryDailog;
@property(nonatomic,assign)FoodInfoView *currenFoodInfoView;
@property(nonatomic,assign)UIBarButtonItem *orderButtonItem;
-(void)setListRecipeData:(NSInteger)categoryID;
-(void)showFoodInfo:(NSInteger)index;
-(void)refreshData;
@end
