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
#import "MainMenuController.h"
@interface FoodView ()
@property(nonatomic,assign)UIImageView *foodImageView;
@property(nonatomic,assign)UILabel *labelPrice;
@property(nonatomic,assign)UILabel *labelFoodName;
@property(nonatomic,assign)UILabel *labelFoodNum;
@property(nonatomic,assign)UIActivityIndicatorView *activityIndcatorView;
@property(nonatomic,assign)UILabel *labelCount;
@property(nonatomic,assign)UIImageView *countImageView;
@end
@implementation FoodView
@synthesize startPoint,recipe;
@synthesize foodImageView,labelPrice,labelFoodName,labelFoodNum,activityIndcatorView,labelCount,countImageView;
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
        UILabel *aLabel=[[UILabel alloc] initWithFrame:CGRectMake(45, 255, 230, 15)];
        aLabel.backgroundColor=[UIColor clearColor];
        [aLabel setFont:[UIFont fontWithName:aLabel.font.fontName size:12]];
        aLabel.textColor=[UIColor blackColor];
        aLabel.textAlignment=UITextAlignmentCenter;
        [self setLabelFoodNum:aLabel];
        [self addSubview:aLabel];
        [aLabel release];
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
        UIActivityIndicatorView *aiView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        aiView.color=[UIColor orangeColor];
        [aiView setFrame:CGRectMake(0, 0, 320, 275)];
        [self setActivityIndcatorView:aiView];
        [self addSubview:aiView];
        [aiView release];
        [activityIndcatorView startAnimating];
    }
    [aRecipe getRecipeImage:^(UIImage *image) {

    if (foodImageView==nil) {
        UIImageView *aImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 230)];
        [aImageView setImage:image];
        [self setFoodImageView:aImageView];
        [self addSubview:aImageView];
        [aImageView release];
    }
        if (labelCount==nil) {
            UIImage *image=[UIImage imageNamed:@"recipeCount.png"];
            UIImageView *anImageView=[[UIImageView alloc] initWithImage:image];
            [anImageView setFrame:CGRectMake(282, 0, 35, 35)];
            UILabel *aLabel=[[UILabel alloc] initWithFrame:CGRectMake(11, 4, 35, 35)];
            aLabel.backgroundColor=[UIColor clearColor];
            [aLabel setFont:[UIFont fontWithName:aLabel.font.fontName size:22]];
            aLabel.textAlignment=UITextAlignmentCenter;
            aLabel.textColor=[UIColor whiteColor];
            [self setLabelCount:aLabel];
            [anImageView addSubview:aLabel];
            [self setCountImageView:anImageView];
            [self insertSubview:anImageView aboveSubview:self.foodImageView];
            [aLabel release];
            [anImageView release];
            [self setFoodCount:[ApplicationDelegate.order getRecipeCount:self.recipe]];
        }

    if (labelPrice==nil) {
        UILabel *aLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 200, 0, 30)];
        aLabel.backgroundColor=[UIColor whiteColor];
        aLabel.layer.cornerRadius=10;
        [aLabel setAlpha:0.7];
        [aLabel setFont:[UIFont fontWithName:aLabel.font.fontName size:22]];
        aLabel.textAlignment=UITextAlignmentCenter;
        aLabel.textColor=[UIColor redColor];
        NSString *price=[NSString stringWithFormat:@"￥%@",aRecipe.rPrice];
        [aLabel setText:price];
        [aLabel sizeToFit];
        [self setLabelPrice:aLabel];
        [self addSubview:aLabel];
        [self insertSubview:aLabel atIndex:([self.subviews count]-1)];
        [aLabel release];
    }
        [activityIndcatorView stopAnimating];
        [self.superview insertSubview:self atIndex:0];
        [self setAlpha:0.1];
        [UIView beginAnimations:@"alpha" context:nil];
        [UIView setAnimationDuration:0.4];
        [self setAlpha:1];
        [UIView commitAnimations];
    UIButton *btnAddFood=[[UIButton alloc] initWithFrame:CGRectMake(275, 230, 45, 45)];
    UIImage *imageAdd=[UIImage imageNamed:@"加号.png"];
    [btnAddFood setImage: imageAdd forState:UIControlStateNormal];
    [btnAddFood  addTarget:self action:@selector(clickBtnAddFood) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnAddFood];
        [btnAddFood release];
        UIButton *btnRemoveFood=[[UIButton alloc] initWithFrame:CGRectMake(0, 230, 45, 45)];
        UIImage *imageRemove=[UIImage imageNamed:@"减号.png"];
        [btnRemoveFood setImage: imageRemove forState:UIControlStateNormal];
        [btnRemoveFood  addTarget:self action:@selector(clickBtnRemoveFood) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnRemoveFood];
        [btnRemoveFood release];
    if (labelFoodName==nil) {
        UILabel *aLabel=[[UILabel alloc] initWithFrame:CGRectMake(45, 230, 230, 25)];
        aLabel.backgroundColor=[UIColor clearColor];
        [aLabel setFont:[UIFont fontWithName:aLabel.font.fontName size:22]];
        aLabel.textColor=[UIColor blackColor];
        aLabel.textAlignment=UITextAlignmentCenter;
        [aLabel setText:recipe.rName];
        [self setLabelFoodName:aLabel];
        [self insertSubview:aLabel atIndex:([self.subviews count]-1)];
        [aLabel release];
    }
    [self SetFoodNum];
        UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setFrame:CGRectMake(0, 0, 35, 25)];
        [backBtn setAlpha:0.6];
        backBtn.backgroundColor=[UIColor clearColor];
        UIImage *anImage=[UIImage imageNamed:@"back"];
        [backBtn setImage:anImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
    }];
    
}
-(void)clickBtnRemoveFood{
    [ApplicationDelegate.order removeRecipe:self.recipe];
    [self setFoodCount:[ApplicationDelegate.order getRecipeCount:self.recipe]];
}
-(void)backClick{
      id controll=[self nextResponder];
      while (![controll isKindOfClass:[MainMenuController class]]) {
          controll=[controll nextResponder];
      }
      MainMenuController *mc=controll;
      [mc.navigationController popViewControllerAnimated:YES];

}
-(void)clickBtnAddFood
{
    
    //定义图片的位置和尺寸,位置:x=268.0f, y=115.0f ,尺寸:x=20.0f, y=20.0f
    [ApplicationDelegate.order addRecipe:self.recipe];
    UIImageView *subview = [[UIImageView alloc] initWithFrame:                            
                            CGRectMake(1110.0f, 100.0f, 30.0f, 30.0f)];   
    
    //设定图片名称,myPic.png已经存在，拖放添加图片文件到image项目文件夹中
   [subview setImage:self.recipe.rImage];    
    [subview setTag:10000];
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

    
}
-(void)dealloc{
    [recipe release];
    [super dealloc];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    int indexICareAbout = 1; 
//    NSString *badgeValue = [NSString stringWithFormat:@"%d",appDelegate.foodCount];  
//    [[[[appDelegate.rootController viewControllers] objectAtIndex: indexICareAbout] tabBarItem] setBadgeValue:badgeValue];
//    if([self.recipe order]!=nil)
//    [appDelegate addFood:self.recipe.category];
//    [appDelegate countPrice];
    
    if ([anim isKindOfClass:[CAKeyframeAnimation class]]&&[self.superview.superview.subviews count]>6) {
        [self setFoodCount:[ApplicationDelegate.order getRecipeCount:self.recipe]];
        UIImageView *aImageView=[self.superview.superview.subviews objectAtIndex:6];
        [aImageView removeFromSuperview];
    }

    NSLog(@"%d",[self.superview.superview.subviews count]);
}
-(void)setFoodCount:(NSInteger)foodCount{    
    NSString *count=[NSString stringWithFormat:@"%d",foodCount];
    if (foodCount==0) {
        count=nil;
        [self.countImageView setHidden:YES];
        [self.labelCount setText:count];
        return;
    }
    [self.countImageView setHidden:NO];
    if (foodCount>9) {
        [self.labelCount setFrame:CGRectMake(6, 4, 35, 35)];
    }
    [self.labelCount setText:count];
    [self.labelCount sizeToFit];
}
@end
