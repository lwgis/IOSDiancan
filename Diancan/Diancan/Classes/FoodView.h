//
//  FoodView.h
//  Diancan
//
//  Created by 李炜 on 12-3-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTRecipe.h"
#import "RecipeImage.h"
#import "Recipe+Search.h"

@interface FoodView : UIView{
    UIImageView *foodImageView;
    UILabel *labelPrice;
    UILabel *labelFoodName;
    UILabel *labelFoodNum;
    UIActivityIndicatorView *activityIndcatorView;
}

@property CGPoint startPoint;
@property (nonatomic,retain) ZTRecipe *recipe;
-(void)setRecipeInfo:(ZTRecipe *)aRecipe;
- (void)SetFoodNum;



@end
