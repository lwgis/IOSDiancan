//
//  CategoryView.m
//  Diancan
//
//  Created by 李炜 on 12-3-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CategoryView.h"
#import "MainMenuController.h"
#import "Category+Search.h"
@interface CategoryView ()
@property(nonatomic,assign) UIImageView *imageView;
@property(nonatomic,assign) CategoryView *curentView;
@end
@implementation CategoryView
@synthesize listFoodView,previousCategoryView,behindCategoryView,isVerticalMoved,isHorizontalMoved,category;
@synthesize startMyPoint,currentFoodView,labelTopCategoryName,categoryImageView;
@synthesize imageView,curentView;
-(void)setTitleImage:(BOOL)isTop{
    UIImage *image=nil;
    if (isTop) {
        image=[UIImage imageNamed:@"top"];
        [imageView setAlpha:0.6];
    } else {
        image=[UIImage imageNamed:@"bottom"];
        [imageView setAlpha:2];
    }
    [imageView setImage:image];
}
-(void)setAllUserInteractionEnabled:(BOOL)userInteractionEnabled{
    CategoryView *pView=self.previousCategoryView;
    while (pView!=nil) {
        [pView setUserInteractionEnabled:userInteractionEnabled];
        pView=pView.previousCategoryView;
    }
    CategoryView *beView=self.behindCategoryView;
    while (beView!=nil) {
        [beView setUserInteractionEnabled:userInteractionEnabled];
        beView=beView.behindCategoryView;
    }
    [self.superview setUserInteractionEnabled:userInteractionEnabled];
}
-(void)ShowFoodView:(NSInteger)index Animation:(BOOL)isAnimation{
    if([listFoodView count]==0){
        showIndex=index;
        return;
    }    
    if(isAnimation){
    [UIView beginAnimations:@"end" context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelegate:self];
    CGFloat distance=-(index*320);
    for (FoodView *caView in listFoodView) {
        [caView setFrame:CGRectMake(distance, caView.frame.origin.y, 320, 275)];
        distance+=320;
        }
    [UIView commitAnimations];
    currentFoodView=(FoodView *)[self.listFoodView objectAtIndex:index];
    }
    else{
        CGFloat distance=-(index*320);
        for (FoodView *caView in listFoodView) {
            [caView setFrame:CGRectMake(distance, caView.frame.origin.y, 320, 275)];
            distance+=320;
        }
        [currentFoodView setAlpha:0.1];
        [UIView beginAnimations:@"end" context:nil];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationDelegate:self];
        [currentFoodView setAlpha:1];
        [UIView commitAnimations];
        currentFoodView=(FoodView *)[self.listFoodView objectAtIndex:index];
    }
}
-(void)loadData:(NSArray *)recipeArray{
    NSMutableArray *nsAarry=[[NSMutableArray alloc] init];
    [self setListFoodView:nsAarry];
    [nsAarry release];
    NSInteger i=0;
    NSInteger tag=0;

    for (ZTRecipe *recipe in recipeArray) {
        
        FoodView *foodView=[[FoodView alloc] initWithFrame:CGRectMake(i, 5, 320, 275)];
        [foodView setTag:tag];
        [foodView setRecipeInfo:recipe];
        [self.listFoodView addObject:foodView];
        [self addSubview:foodView];
        i+=320;
        tag++;
        [foodView release];
    }
}
//通过category加载菜单

-(void)loadDataByCategory:(ZTCategory *)aCategory{
    NSLog(@"%d",(NSInteger)[aCategory.cID floatValue] );
    [ApplicationDelegate.restEngine getRecipesByCategory:(NSInteger)[aCategory.cID floatValue]  OnCompletion:^(NSArray *array){        
        [self loadData:array ];
        currentFoodView=[listFoodView objectAtIndex:showIndex];
        [self ShowFoodView:showIndex Animation:NO];
    }onError:^(NSError *error){} ];

}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];  
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *aImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
        [aImageView setAlpha:0.6];
        [self setImageView:aImageView];
        [self addSubview:aImageView];
        [aImageView release];
        [self setTitleImage:NO];
        [self setStartMyPoint:self.frame.origin];
        isVerticalMoved=NO;
        isHorizontalMoved=NO;
        categoryImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 320, 275)] ;
        [self addSubview:categoryImageView];
        UILabel *aLabel=[[UILabel alloc] initWithFrame:CGRectMake(120, 5, 80, 20)];
        aLabel.textAlignment = UITextAlignmentCenter;
        aLabel.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        aLabel.textColor=[UIColor whiteColor];
        [self setLabelTopCategoryName:aLabel];
        [self addSubview:aLabel];
        [aLabel release];
       
//        [self setUserInteractionEnabled:NO];
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    for (id fvid in self.listFoodView) {
//        FoodView * foodView=(FoodView *)fvid;
//        [foodView setStartPoint:foodView.frame.origin];
//    }
    if(self.nextResponder!=nil)
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
-(void)setAlpha:(CGFloat)alpha{
    for (FoodView *foodView in self.listFoodView) {
        [foodView setAlpha:alpha];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
//横向滑动
-(void)horizontalMoveView:(CGFloat)distance{
    isHorizontalMoved=YES;
    for (id fvid in self.listFoodView) {
        FoodView * foodView=(FoodView *)fvid;
        [foodView setFrame:CGRectMake(foodView.startPoint.x+distance, foodView.frame.origin.y
                                      , foodView.frame.size.width, foodView.frame.size.height)];
        [foodView setUserInteractionEnabled:NO];
    }
//    [self setFrame:CGRectMake(startPoint.x+distance, self.frame.origin.y
//                                                , self.frame.size.width, self.frame.size.height)];
}
-(BOOL)isFirstrorLast:(CGFloat)distance{
    for (id fvid in self.listFoodView) {
        FoodView * foodView=(FoodView *)fvid;
        if (foodView.startPoint.x<0&&distance>0) {
            return NO;
        }    
        if (foodView.startPoint.x+fabs(distance)>320&&distance<0) {
            return NO;
        }
        
    }
        return YES;
}
//横向移动到下一个View
-(void)horizontalMoveNext:(CGFloat)distance{
    [UIView beginAnimations:@"end" context:nil];
    [UIView setAnimationDelegate:self];
//    [self setAllUserInteractionEnabled:NO];
    NSInteger tag=currentFoodView.tag;
    if (fabsf(distance)<70||[self isFirstrorLast:distance]) {
        [UIView setAnimationDuration:(fabsf(distance/320))*0.7];
        distance=0;
    } else {
        [UIView setAnimationDuration:(1-fabsf(distance/320))*0.7];
        tag=distance>0?tag-1:tag+1;
        distance=distance>0?320:-320;
    }
    for (id fvid in self.listFoodView) {
        FoodView * foodView=(FoodView *)fvid;
        [foodView setFrame:CGRectMake(foodView.startPoint.x+distance, foodView.frame.origin.y
                                      , foodView.frame.size.width, foodView.frame.size.height)];
        [foodView setStartPoint:foodView.frame.origin];
    }
    [UIView commitAnimations];    
    for (FoodView *caView in listFoodView) {
        if (caView.tag==tag) {
            currentFoodView=caView;
        }    
    }
    
}
//垂直移动
-(CategoryView *)verticalMoverView:(CGFloat)distance{
    [self setFrame:CGRectMake(startMyPoint.x,startMyPoint.y+distance, self.frame.size.width, self.frame.size.height)];

    //处理前后View
    CategoryView *pView=self.previousCategoryView;
    while (pView!=nil) {
        [pView setFrame:CGRectMake(pView.startMyPoint.x,pView.startMyPoint.y+distance*0.5, pView.frame.size.width, pView.frame.size.height)];
        pView=pView.previousCategoryView;
    }
    CategoryView *beView=self.behindCategoryView;
    while (beView!=nil) {
        if (distance>0) {
            [beView setFrame:CGRectMake(beView.startMyPoint.x,beView.startMyPoint.y+distance*0.5, beView.frame.size.width, beView.frame.size.height)];
        } else {
            [beView setFrame:CGRectMake(beView.startMyPoint.x,beView.startMyPoint.y+distance*2, beView.frame.size.width, beView.frame.size.height)];
            
        }
        beView=beView.behindCategoryView;
    }
    if(fabs(distance)>70)
    return  [self verticalMoverNext:distance];
    return self;
}
//垂直移动到下一个
-(CategoryView *)verticalMoverNext:(CGFloat)distance{
    isVerticalMoved=YES;
   curentView=self;
//   [self.superview setUserInteractionEnabled:NO];
    CGFloat y=distance;    
      [UIView beginAnimations:@"end" context:nil];
      [UIView setAnimationDuration:0.6];
      [UIView setAnimationDelegate:self];
//    [self setAllUserInteractionEnabled:NO];
    if ((y>-70&&y<70)||(y<-70&&self.behindCategoryView==nil)||(y>70&&self.previousCategoryView==nil)) {
        [self setFrame:CGRectMake(self.startMyPoint.x, self.startMyPoint.y, self.frame.size.width, 280)];    
        CategoryView *pView=self.previousCategoryView;
        while (pView!=nil) {
            [pView setFrame:CGRectMake(pView.startMyPoint.x, pView.startMyPoint.y, self.frame.size.width, 280)]; 
            pView=pView.previousCategoryView;
        }
        CategoryView *beView=self.behindCategoryView;
        while (beView!=nil) {
            [beView setFrame:CGRectMake(beView.startMyPoint.x, beView.startMyPoint.y, self.frame.size.width, 280)]; 
            beView=beView.behindCategoryView;
        }
        [self setAlpha:1.0];        
    }
    else{  
        CategoryView *beView=self.behindCategoryView;            
        CategoryView *pView=self.previousCategoryView;
        CGFloat step=280;
        if (y<0) {
            step=-280;
            [self setFrame:CGRectMake(0, 
                                                     self.startMyPoint.y+step/2, self.frame.size.width, 280)];
            [beView setFrame:CGRectMake(beView.startMyPoint.x, beView.startMyPoint.y+step, self.frame.size.width, 280)]; 
            [beView setTitleImage:YES];
            [beView setStartMyPoint:CGPointMake(beView.startMyPoint.x, beView.startMyPoint.y+step)];
            if(beView!=nil){
            beView=beView.behindCategoryView;
            curentView= self.behindCategoryView;
            }
        }
        else{
            [self setFrame:CGRectMake(0,
                                                     self.startMyPoint.y+step, self.frame.size.width, 280)];
            [pView setFrame:CGRectMake(pView.startMyPoint.x, pView.startMyPoint.y+step/2, self.frame.size.width, 280)]; 
            [pView setStartMyPoint:CGPointMake(pView.startMyPoint.x, pView.startMyPoint.y+step/2)];
            if(pView!=nil){
            pView=pView.previousCategoryView;
            curentView=self.previousCategoryView;
            }
        }        
        while (pView!=nil) {
            [pView setFrame:CGRectMake(pView.startMyPoint.x, pView.startMyPoint.y+step/2, self.frame.size.width, 280)]; 
            [pView setTitleImage:YES];
            [pView setStartMyPoint:CGPointMake(pView.startMyPoint.x, pView.startMyPoint.y+step/2)];
            pView=pView.previousCategoryView;
        }          
        while (beView!=nil) {
            [beView setFrame:CGRectMake(beView.startMyPoint.x, beView.startMyPoint.y+step/2, self.frame.size.width, 280)]; 
            [beView setStartMyPoint:CGPointMake(beView.startMyPoint.x, beView.startMyPoint.y+step/2)];
            beView=beView.behindCategoryView;
        }
        //设置上下View透明度
        if (y>0) {
            [self.previousCategoryView setAlpha:1.0];
        }
        else {
            [self.behindCategoryView setAlpha:1.0];
        }
        [self setAlpha:0.4];
        self.isVerticalMoved=NO;
    }        
    [self setStartMyPoint:self.frame.origin];
    [curentView setIsVerticalMoved:YES];
    [UIView commitAnimations];
    [curentView.categoryImageView setHidden:YES];
    return  curentView;
}
-(void)animationDidStart:(CAAnimation *)anim{
    self.userInteractionEnabled=NO;
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if(flag){
        id nextResponder = [self nextResponder]; 
        if (!([nextResponder isKindOfClass:[UIViewController class]])) { 
            nextResponder=[nextResponder nextResponder];
        }     
        MainMenuController *aMainMenuController=(MainMenuController *)nextResponder;
        for (CategoryView *aCategoryView in aMainMenuController.listCategoryView) {
            [aCategoryView setUserInteractionEnabled:YES];
        } 
        aMainMenuController.isVerticalMoved=YES;
//        [self.superview setUserInteractionEnabled:YES];
        self.isVerticalMoved=NO;
        self.isHorizontalMoved=NO;
        [curentView setIsVerticalMoved:NO];
        for (id fvid in self.listFoodView) {
            FoodView * foodView=(FoodView *)fvid;
            [foodView setUserInteractionEnabled:YES];
        }

    }
}
//设置菜单信息
-(void)setCategoryInfo:(ZTCategory *)aCategory{
    if (aCategory==nil) {
        NSLog(@"设置菜单失败");
        return;
    }
    if ([self.listFoodView count]>0) {
        return;
    }
    [self loadDataByCategory:aCategory];

    [self insertSubview:labelTopCategoryName atIndex:([self.subviews count]-1)];
//    [self insertSubview:labelBottomCategoryName atIndex:([self.subviews count]-1)];
    if(aCategory!=nil)
    [self setCategory:aCategory];
}
-(void)dealloc{
    [listFoodView release];
    [categoryImageView release];
    [labelTopCategoryName release];
    [super dealloc];
}
@end
