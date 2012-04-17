//
//  FoodCell.h
//  Diancan
//
//  Created by 李炜 on 12-2-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTRecipe.h"
@interface FoodCell : UIView
@property(nonatomic,assign)FoodCell *nextFoodCell;
@property(nonatomic,assign)ZTRecipe *recipe;
-(void)loadRecipeData:(ZTRecipe *)aRecipe count:(NSInteger)count;
@end
