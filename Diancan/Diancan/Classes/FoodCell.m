//
//  FoodCell.m
//  Diancan
//
//  Created by 李炜 on 12-2-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FoodCell.h"
@interface FoodCell ()
@property(nonatomic,retain)UIImageView *recipeImageView;
@property(nonatomic,retain)UILabel *recipeNameLable;
@property(nonatomic,retain)UILabel *recipePriceLable;
@property(nonatomic,retain)UILabel *recipeCountLable;
@property(nonatomic,retain)UIButton *addRecipeButton;
@property(nonatomic,retain)UIButton *removeRecipeButton;
@end
@implementation FoodCell{
    NSInteger _recipeCount;
}
@synthesize nextFoodCell,recipeImageView,recipeNameLable,recipePriceLable,recipeCountLable,addRecipeButton,removeRecipeButton,recipe;
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"c.png"]];
        recipeImageView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        [self addSubview:recipeImageView];
        recipeNameLable=[[UILabel alloc] initWithFrame:CGRectMake(45, 0, 100, 30)];
        recipeNameLable.backgroundColor=[UIColor clearColor];
                [self addSubview:recipeNameLable];
        recipePriceLable=[[UILabel alloc] initWithFrame:CGRectMake(45, 25, 40, 20)];
        recipePriceLable.textColor=[UIColor redColor];
        [self addSubview:recipePriceLable];
        removeRecipeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [removeRecipeButton setFrame:CGRectMake(155, 20, 30, 30)];
        removeRecipeButton.backgroundColor=[UIColor clearColor];
        [removeRecipeButton setImage:[UIImage imageNamed:@"减号.png"] forState:UIControlStateNormal];
        [self addSubview:removeRecipeButton];
        recipeCountLable=[[UILabel alloc] initWithFrame:CGRectMake(190, 22, 65, 25)];
        recipeCountLable.textAlignment=UITextAlignmentCenter;
        recipeCountLable.textColor=[UIColor redColor];
        [self addSubview:recipeCountLable];
        addRecipeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [addRecipeButton setFrame:CGRectMake(255, 20, 30, 30)];
        addRecipeButton.backgroundColor=[UIColor clearColor];
        [addRecipeButton setImage:[UIImage imageNamed:@"加号.png"] forState:UIControlStateNormal];
        [self addSubview:addRecipeButton];
    }
    return self;
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

-(void)loadRecipeData:(ZTRecipe *)aRecipe count:(NSInteger)count{
    self.recipe=aRecipe;
    _recipeCount=count;
//     [aRecipe getRecipeImage:^(UIImage *image) {
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
