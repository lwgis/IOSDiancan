//
//  FoodInfoView.h
//  Diancan
//
//  Created by 李炜 on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodInfoView : UIView
@property(nonatomic,retain)UIImageView *foodImageView;
@property(nonatomic,retain)UILabel *foodNameLabel;
@property(nonatomic,retain)UILabel *foodPriceLable;
@property(nonatomic,retain)UILabel *foodNum;
@property(nonatomic,assign)UIImageView *markImageView;
@property BOOL isCheck;
-(void)loadRepiceImage:(ZTRecipe *)aRecipe;
-(void)markByImage:(BOOL)visiable Animation:(BOOL)animation;
@end
