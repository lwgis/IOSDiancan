//
//  FoodCell.m
//  Diancan
//
//  Created by 李炜 on 12-2-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FoodCell.h"
#import <QuartzCore/QuartzCore.h>
@interface FoodCell ()
@property(nonatomic,retain)UIImageView *recipeImageView;
@property(nonatomic,retain)UILabel *recipeNameLable;
@property(nonatomic,retain)UILabel *recipePriceLable;
@property(nonatomic,retain)UILabel *recipeCountLable;
@property(nonatomic,retain)UIButton *addrecipeButton;
@property(nonatomic,retain)UIButton *removerecipeButton;
@end
@implementation FoodCell{
    NSInteger _recipeCount;
}
@synthesize nextFoodCell,recipeImageView,recipeNameLable,recipePriceLable,recipeCountLable,addrecipeButton,removerecipeButton,recipe;
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UIImageView *backImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [backImage setImage:[UIImage imageNamed:@"c.png"]];
        [self addSubview:backImage];
        [backImage release];
        recipeImageView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        [self addSubview:recipeImageView];
        recipeNameLable=[[UILabel alloc] initWithFrame:CGRectMake(45, 0, 100, 30)];
        recipeNameLable.backgroundColor=[UIColor clearColor];
                [self addSubview:recipeNameLable];
        recipePriceLable=[[UILabel alloc] initWithFrame:CGRectMake(45, 25, 40, 20)];
        recipePriceLable.textColor=[UIColor redColor];
        [self addSubview:recipePriceLable];
        removerecipeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [removerecipeButton addTarget:self action:@selector(removerecipeClick) forControlEvents:UIControlEventTouchUpInside];
        [removerecipeButton setFrame:CGRectMake(170, 20, 30, 30)];
        removerecipeButton.backgroundColor=[UIColor clearColor];
        [removerecipeButton setImage:[UIImage imageNamed:@"remove.png"] forState:UIControlStateNormal];
        [self addSubview:removerecipeButton];
        recipeCountLable=[[UILabel alloc] initWithFrame:CGRectMake(205, 22, 50, 25)];
        recipeCountLable.textAlignment=UITextAlignmentCenter;
        recipeCountLable.textColor=[UIColor redColor];
        [self addSubview:recipeCountLable];
        addrecipeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [addrecipeButton addTarget:self action:@selector(addrecipeClick) forControlEvents:UIControlEventTouchUpInside];
        addrecipeButton.layer.cornerRadius=0.5;
        [addrecipeButton setFrame:CGRectMake(255, 20, 30, 30)];
        addrecipeButton.backgroundColor=[UIColor clearColor];
        [addrecipeButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        [self addSubview:addrecipeButton];
    }
    return self;
}
-(void)addrecipeClick{
    [ApplicationDelegate.order addRecipe:self.recipe];
    _recipeCount=[ApplicationDelegate.order getRecipeCount:self.recipe];
    [self.recipeCountLable setText:[NSString stringWithFormat:@"%d份",_recipeCount]];
}
-(void)removerecipeClick{
    if (_recipeCount==0)return;
    [ApplicationDelegate.order removeRecipe:self.recipe];
    _recipeCount=[ApplicationDelegate.order getRecipeCount:self.recipe];
    if (_recipeCount<=0) {
        [self.recipeCountLable setText:nil];
        [UIView beginAnimations:@"moveUp" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        FoodCell *aNextFoodCell=self.nextFoodCell;
        while (aNextFoodCell!=nil) {
            [aNextFoodCell setFrame:CGRectMake(aNextFoodCell.frame.origin.x, aNextFoodCell.frame.origin.y-aNextFoodCell.frame.size.height, aNextFoodCell.frame.size.width, aNextFoodCell.frame.size.height)];
            aNextFoodCell=aNextFoodCell.nextFoodCell;
        }
        [UIView commitAnimations];   
        return;
    }
    [self.recipeCountLable setText:[NSString stringWithFormat:@"%d 份",_recipeCount]];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)dealloc{
    [recipeImageView release];
    [recipeNameLable release];
    [recipePriceLable release];
    [recipeCountLable release];
}

#pragma mark - View lifecycle
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self removeFromSuperview];
    [self release];
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

-(void)loadRecipeData:(ZTRecipe *)aRecipe count:(NSInteger)count{
    self.recipe=aRecipe;
    _recipeCount=count;
    self.userInteractionEnabled=YES;
//     [arecipe getrecipeImage:^(UIImage *image) {
//         [self.recipeImageView setImage:image];
//     }];
    [self.recipeImageView setImage:aRecipe.rImage];
    [self.recipeNameLable setText:aRecipe.rName];
    [self.recipeNameLable sizeToFit];
    [self.recipePriceLable setText:[NSString stringWithFormat:@"￥%.2f" ,[aRecipe.rPrice floatValue]]];
    [self.recipePriceLable sizeToFit];
    [self.recipeCountLable setText:[NSString stringWithFormat:@"%d份",_recipeCount]];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
