//
//  FoodView.m
//  Diancan
//
//  Created by 李炜 on 12-3-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FoodView.h"
#import <QuartzCore/QuartzCore.h>
#import "CategoryView.h"

@implementation FoodView
@synthesize startPoint,recipe;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setStartPoint:self.frame.origin];
    }
        return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nextResponder touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nextResponder touchesMoved:touches withEvent:event];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nextResponder touchesEnded:touches withEvent:event];
}
- (void)SetFoodNum
{
    if (labelFoodNum==nil) {
        labelFoodNum=[[[UILabel alloc] initWithFrame:CGRectMake(45, 255, 230, 15)] autorelease];
        labelFoodNum.backgroundColor=[UIColor clearColor];
        [labelFoodNum setFont:[UIFont fontWithName:labelFoodNum.font.fontName size:12]];
        labelFoodNum.textColor=[UIColor blackColor];
        labelFoodNum.textAlignment=UITextAlignmentCenter;
        [self addSubview:labelFoodNum];
    }
    CategoryView *aCategoryView=(CategoryView*)self.superview;
    NSString *foodNum=[NSString stringWithFormat:@"%d/%d",self.tag+1,[aCategoryView.listFoodView count]];
    [labelFoodNum setText:foodNum];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)setRecipeInfo:(ZTRecipe *)aRecipe;
{
    [self setRecipe:aRecipe];
    if (activityIndcatorView==nil) {
        activityIndcatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndcatorView.color=[UIColor orangeColor];
        [activityIndcatorView setFrame:CGRectMake(0, 0, 320, 275)];
        [self addSubview:activityIndcatorView];
        [activityIndcatorView startAnimating];
    }
    [aRecipe getRecipeImage:^(UIImage *image) {

    if (foodImageView==nil) {
        foodImageView=[[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 230)] autorelease];
    }

    if (labelPrice==nil) {
        labelPrice=[[[UILabel alloc] initWithFrame:CGRectMake(240, 235, 80, 30)] autorelease];
        labelPrice.backgroundColor=[UIColor clearColor];
        [labelPrice setFont:[UIFont fontWithName:labelPrice.font.fontName size:22]];
        labelPrice.textAlignment=UITextAlignmentRight;
        labelPrice.textColor=[UIColor redColor];
        NSString *price=[NSString stringWithFormat:@"￥%@",aRecipe.rPrice];
        [labelPrice setText:price];
    }
    [aRecipe setRImageView:foodImageView];
        [activityIndcatorView stopAnimating];
        [foodImageView setImage:image];
        [self.superview insertSubview:self atIndex:0];
        [self setAlpha:0.1];
        [UIView beginAnimations:@"alpha" context:nil];
        [UIView setAnimationDuration:0.4];
        [self setAlpha:1];
        [UIView commitAnimations];


    

    [self addSubview:foodImageView];
    [self addSubview:labelPrice];
    UIButton *btnAddFood=[[[UIButton alloc] initWithFrame:CGRectMake(0, 230, 45, 45)] autorelease];
    UIImage *imageAdd=[UIImage imageNamed:@"加号.png"];
    [btnAddFood setImage: imageAdd forState:UIControlStateNormal];
    [btnAddFood  addTarget:self action:@selector(clickBtnAddFood) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnAddFood];
    if (labelFoodName==nil) {
        labelFoodName=[[[UILabel alloc] initWithFrame:CGRectMake(45, 230, 230, 25)] autorelease];
        labelFoodName.backgroundColor=[UIColor clearColor];
        [labelFoodName setFont:[UIFont fontWithName:labelFoodName.font.fontName size:22]];
        labelFoodName.textColor=[UIColor blackColor];
        labelFoodName.textAlignment=UITextAlignmentCenter;
        [labelFoodName setText:recipe.rName];
//        [self addSubview:labelFoodName];
        [self insertSubview:labelFoodName atIndex:([self.subviews count]-1)];
    }
    [self SetFoodNum];
    }];
    
}
-(void)clickBtnAddFood
{
    
    //定义图片的位置和尺寸,位置:x=268.0f, y=115.0f ,尺寸:x=20.0f, y=20.0f
    
    UIImageView *subview = [[UIImageView alloc] initWithFrame:                            
                            CGRectMake(1110.0f, 100.0f, 30.0f, 30.0f)];   
    
    //设定图片名称,myPic.png已经存在，拖放添加图片文件到image项目文件夹中
   [subview setImage:self.recipe.rImage];    
    //    //启用动画移动
    //    [UIImageView beginAnimations:nil context:NULL];    
    //    //移动时间2秒
    //    [UIImageView setAnimationDuration:2];    
    //    //图片持续移动
    //    [UIImageView setAnimationBeginsFromCurrentState:YES];   
    //    //重新定义图片的位置和尺寸,位置
    //    subview.frame = CGRectMake(80.0, 300.0,50.0, 50.0);    
    //    subview.animationRepeatCount=1;
    //    //完成动画移动
    //    [UIImageView commitAnimations];  
    //    //在 View 中加入图片 subview 
    
    [self.superview.superview addSubview:subview];
    CGMutablePathRef thePath =  CGPathCreateMutable();
    //   CGRect bound1 = CGRectMake(110.0f, 100.0f, 30.0f, 30.0f);
    //    CGRect bounds = CGRectMake(210.0f, 150.0f, 30.0f, 30.0f);
    CGPathMoveToPoint(thePath, NULL, 0, 200);
    CGPathAddLineToPoint(thePath, NULL, 40, 140);
    CGPathAddLineToPoint(thePath, NULL, 80, 140);
    CGPathAddLineToPoint(thePath, NULL, 120, 200);
    CGPathAddLineToPoint(thePath, NULL, 160, 420);
    //	CGPathAddQuadCurveToPoint(thePath, NULL, 10, 450, 310, 450);
    //	CGPathAddQuadCurveToPoint(thePath, NULL, 310, 10, 10, 10);
    //    CGPathAddLineToPoint(thePath, NULL, 110.0f, 100.0f);
    //    CGPathAddLineToPoint(thePath, NULL, 210.0f, 150.0f);
    CAKeyframeAnimation *theAnimation =[CAKeyframeAnimation animationWithKeyPath:@"position"];
    theAnimation.path=thePath;
    theAnimation.duration=0.4;
    theAnimation.repeatCount = 1; // 无线循环
    theAnimation.autoreverses=NO;
    theAnimation.cumulative=YES;
    theAnimation.delegate=self;
    [subview.layer addAnimation:theAnimation forKey:@"animateLayer"]; // 添加动画。
    CFRelease(thePath);
    [subview release];
    self.recipe.count++;
    //    [NSThread sleepForTimeInterval:1];   
    
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    ZTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.foodCount++;
//    int indexICareAbout = 1; 
//    NSString *badgeValue = [NSString stringWithFormat:@"%d",appDelegate.foodCount];  
//    [[[[appDelegate.rootController viewControllers] objectAtIndex: indexICareAbout] tabBarItem] setBadgeValue:badgeValue];
//    if([self.recipe order]!=nil)
//    [appDelegate addFood:self.recipe.category];
//    [appDelegate countPrice];
    
}
@end
