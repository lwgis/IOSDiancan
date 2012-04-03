//
//  ZTLeftListViewCell.m
//  Diancan
//
//  Created by 李炜 on 12-4-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZTRightListViewCell.h"
#import <QuartzCore/QuartzCore.h> 

@implementation ZTRightListViewCell
{
    UIImageView *recipeImageView;
    UILabel *recipeNameLable;
    UILabel *recipePriceLable;
    
}
@synthesize recipe,behindZTRightListViewCell,previousZTRightListViewCell,startPoint;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        UIImageView *topImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 2)];
        UIImage *image=[UIImage imageNamed:@"top.png"];
        [topImageView setImage:image];
        [topImageView setAlpha:0.6];
        [self addSubview:topImageView];
        recipeImageView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 70)];
        recipeImageView.layer.cornerRadius=5;
        [self addSubview:recipeImageView];
        recipeNameLable=[[UILabel alloc] initWithFrame:CGRectMake(75, 10, 200, 20)];
        recipeNameLable.backgroundColor=[UIColor clearColor];
        [self addSubview:recipeNameLable];
        recipePriceLable=[[UILabel alloc] initWithFrame:CGRectMake(75, 40, 50, 20)];
        recipePriceLable.backgroundColor=[UIColor clearColor];
        [recipePriceLable setTextColor:[UIColor redColor]];
        [self addSubview:recipePriceLable];
        UIImageView *addImage=[[UIImageView alloc] initWithFrame:CGRectMake(80, 80, 20, 20)];
        image=[UIImage imageNamed:@"加号.png"];
        [addImage setImage:image];
        [self addSubview:addImage];
        [topImageView release];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame recipe:(ZTRecipe *)aRecipe
{
    id view=[self initWithFrame:frame];
    self.recipe=aRecipe;
    [recipeNameLable setText:aRecipe.rName];
    NSString *price=[NSString stringWithFormat:@"￥%@",aRecipe.rPrice];
    [recipePriceLable setText:price];
    [aRecipe getRecipeImage:^(UIImage *image) {
        [recipeImageView setImage:image];
    }];
    return view;
}
-(void)loadRecipe:(ZTRecipe *)aRecipe{
    self.recipe=aRecipe;
    [recipeNameLable setText:aRecipe.rName];
    NSString *price=[NSString stringWithFormat:@"￥%@",aRecipe.rPrice];
    [recipePriceLable setText:price];
    [aRecipe getRecipeImage:^(UIImage *image) {
        if(recipeImageView!=nil)
        [recipeImageView setImage:image];
    }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.startPoint=self.frame.origin;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.startPoint.y==self.frame.origin.y) {
        NSLog(@"%@",self.recipe.rName);
    }
    startPoint=self.frame.origin;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
