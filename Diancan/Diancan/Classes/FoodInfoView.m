//
//  FoodInfoView.m
//  Diancan
//
//  Created by 李炜 on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FoodInfoView.h"
#import <QuartzCore/QuartzCore.h>
@implementation FoodInfoView
@synthesize foodImageView,foodNameLabel,foodPriceLable,foodNum,markImageView,isCheck;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        foodImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,320 , 320)];
        [self addSubview:foodImageView];
        foodPriceLable=[[UILabel alloc] initWithFrame:CGRectMake(240, 320, 80, 30)];
        [foodPriceLable setFont:[UIFont fontWithName:foodPriceLable.font.fontName size:20]];
        foodPriceLable.textAlignment=UITextAlignmentRight;
        foodPriceLable.textColor=[UIColor redColor];
        [self addSubview:foodPriceLable];
        foodNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 320, 240, 30)];
        [foodNameLabel setFont:[UIFont fontWithName:foodNameLabel.font.fontName size:20]];
        [self addSubview:foodNameLabel]; 
        foodNum=[[UILabel alloc] initWithFrame:CGRectMake(0, 350, 320, 15)];
        [foodNum setFont:[UIFont fontWithName:foodNameLabel.font.fontName size:15]];
        foodNum.textAlignment=UITextAlignmentCenter;
        [self addSubview:foodNum];
        [self setIsCheck:NO];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)markByImage:(BOOL)visiable Animation:(BOOL)animation{
    if (visiable) {
        if (self.markImageView==nil) {
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(110, -100, 100, 100)];
            [imageView setImage:[UIImage imageNamed:@"yidian.png"]];
            [self setMarkImageView:imageView];
            [self addSubview:imageView];
            [imageView release];
        }   
        if(animation){
            [UIView beginAnimations:@"markByImage" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.3];
            [self.markImageView setFrame:CGRectMake(110, 0, 100, 100)];
            [UIView commitAnimations];
        }
        else{
            [self.markImageView setFrame:CGRectMake(110, 0, 100, 100)];
        }
        [self setIsCheck:YES];
    }
    else{
        if (self.markImageView!=nil) {
            [self.markImageView removeFromSuperview];
            self.markImageView=nil;
        }
        [self setIsCheck:NO];
    }
}
-(void)loadRepiceImage:(ZTRecipe *)aRecipe{
    [aRecipe getRecipeImage:^(UIImage *image) {
        [self.foodImageView setImage:image];
    }];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
}
-(void)dealloc{
    [foodImageView.image release];
    foodImageView.image=nil;
    [foodImageView release];
    [foodNameLabel release];
    [foodPriceLable release];
    [foodNum release];
    [super dealloc];
}
@end
