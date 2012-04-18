//
//  ZTOrder.h
//  Diancan
//
//  Created by 李炜 on 12-4-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZTRecipe.h"
@interface ZTOrder : NSObject    
-(void)addRecipe:(ZTRecipe *)recipe;
-(void)removeRecipe:(ZTRecipe *)recipe;
-(NSInteger)getRecipeCount:(ZTRecipe *)recipe;
-(void)order;
-(void)release;
-(NSMutableArray *)getRecipes;
@property(retain,nonatomic)UIViewController *viewController;
-(NSArray *)getCategoryName;
-(CGFloat)getPrice;
@end