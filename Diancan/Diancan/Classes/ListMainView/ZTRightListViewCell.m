//
//  ZTLeftListViewCell.m
//  Diancan
//
//  Created by 李炜 on 12-4-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZTRightListViewCell.h"
#import <QuartzCore/QuartzCore.h> 
#import "ZTLeftListView.h"
#import "FoodInfoController.h"
#import "ListMainViewCongtroller.h"
#import "ZTRightListView.h"
#define AMIMATOIN_TIME  0.2
@interface ZTRightListViewCell ()//(在@implementation上面)
- (void)recipeImageAnimation;//私有方法(对象实例方法)
@end
@implementation ZTRightListViewCell
{
    UIButton *recipeImageView;
    UILabel *recipeNameLable;
    UILabel *recipePriceLable;
    UIButton *addImage;
    UIButton *reMoveImage;
    UILabel *countLabel;
    UIImageView *checkOrderImageView;
    NSInteger _recipeCount;
}

@synthesize recipe,behindZTRightListViewCell,previousZTRightListViewCell,startPoint,buttomView,isExtend;
-(void)removeFromSuperview{
    [super removeFromSuperview];
}
-(void)dealloc{
    //    [recipeImageView setImage:nil forState:UIControlStateNormal];
    [recipeImageView.imageView.image release];
//        [recipeImageView removeFromSuperview];
//        [recipeImageView release];
    [recipeNameLable removeFromSuperview];
    [recipeNameLable release];
    [recipePriceLable removeFromSuperview];
    [recipePriceLable release];
    [addImage removeFromSuperview];
    [reMoveImage removeFromSuperview];
    [countLabel removeFromSuperview];
    [countLabel release];
    [buttomView removeFromSuperview];
    [buttomView release];
    [checkOrderImageView removeFromSuperview];
    [checkOrderImageView release];
    [recipe release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.multipleTouchEnabled=NO;
        isExtend=NO;
        _recipeCount=0;
        self.backgroundColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        UIImageView *cellImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height )];
        UIImage *image=[UIImage imageNamed:@"LeftViewCell.png"];
        [cellImageView setImage:image];
        [cellImageView setAlpha:1];
        checkOrderImageView=[[UIImageView alloc] initWithFrame:CGRectMake(190, 40, 40, 40)];
        image=[UIImage imageNamed:@"duigou.png"];
        [checkOrderImageView setImage:image];
        [cellImageView addSubview:checkOrderImageView];
        [self addSubview:cellImageView];
        [cellImageView release];    
        recipeNameLable=[[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 20)];
        recipeNameLable.backgroundColor=[UIColor clearColor];
        [self addSubview:recipeNameLable];
        recipePriceLable=[[UILabel alloc] initWithFrame:CGRectMake(80, 40, 50, 20)];
        recipePriceLable.backgroundColor=[UIColor clearColor];
        [recipePriceLable setTextColor:[UIColor redColor]];
        [self addSubview:recipePriceLable];
                UIImageView *backgroudImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 60)];
        image=[UIImage imageNamed:@"buttomView.png"];
        [backgroudImageView setImage:image];
        addImage=[UIButton buttonWithType:UIButtonTypeCustom];
        [addImage addTarget:self action:@selector(addrecipeClick) forControlEvents:UIControlEventTouchUpInside];
        addImage.backgroundColor=[UIColor clearColor];
        [addImage setFrame:CGRectMake(190, 18, 40, 40)];           
        image=[UIImage imageNamed:@"加号.png"];    
       [addImage setImage:image forState:UIControlStateNormal];
        countLabel=[[UILabel alloc] initWithFrame:CGRectMake(120, 18, 70, 40)];
        countLabel.backgroundColor=[UIColor clearColor];
        [countLabel setTextColor:[UIColor redColor]];
        [countLabel setTextAlignment:UITextAlignmentCenter];
        reMoveImage=[UIButton buttonWithType:UIButtonTypeCustom];
        [reMoveImage addTarget:self action:@selector(removerecipeClick) forControlEvents:UIControlEventTouchUpInside];
        [reMoveImage setFrame:CGRectMake(80, 18, 40, 40)];
        image=[UIImage imageNamed:@"减号.png"];    
        [reMoveImage setImage:image forState:UIControlStateNormal];
        buttomView=[[UIView alloc] initWithFrame:CGRectMake(0, 80, 240, 60)];
        buttomView.backgroundColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        [buttomView addSubview:backgroudImageView];
        [backgroudImageView release];
        [buttomView addSubview:addImage];    
        [buttomView addSubview:reMoveImage];
        [buttomView addSubview:countLabel];
        [self addSubview:buttomView];
        buttomView.hidden=YES;
        checkOrderImageView.hidden=YES;
    }
    return self;    
}
-(void)addrecipeClick{
    [ApplicationDelegate.order addRecipe:self.recipe];
    [self recipeImageAnimation];

    _recipeCount=[ApplicationDelegate.order getRecipeCount:self.recipe];
    }
-(void)removerecipeClick{
    if (_recipeCount==0)return;
    [ApplicationDelegate.order removeRecipe:self.recipe];
    _recipeCount=[ApplicationDelegate.order getRecipeCount:self.recipe];
    if (_recipeCount<=0) {
        [countLabel setText:nil];
        checkOrderImageView.hidden=YES;
        return;
    }
    [countLabel setText:[NSString stringWithFormat:@"%d 份",_recipeCount]];
}
-(void)loadRecipe:(ZTRecipe *)aRecipe{
   
    self.recipe=aRecipe;
    [recipeNameLable setText:aRecipe.rName];
    NSString *price=[NSString stringWithFormat:@"￥%@",aRecipe.rPrice];
    [recipePriceLable setText:price];
    [aRecipe getRecipeImage:^(UIImage *image) {
         if(self){
             [recipeImageView removeFromSuperview];
             [recipeImageView release];
             if(recipeImageView==nil){
//                 recipeImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 70, 70)] ;
//                 recipeImageView.layer.cornerRadius=5;
//                 [recipeImageView setImage:image];
                 recipeImageView=[UIButton buttonWithType:UIButtonTypeCustom];
                 [recipeImageView setFrame:CGRectMake(10, 5, 70, 70)] ;
                 [recipeImageView addTarget:self action:@selector(recipeImageClick) forControlEvents:UIControlEventTouchUpInside];
                 recipeImageView.layer.cornerRadius=5;
                 [recipeImageView setImage:image forState:UIControlStateNormal];
                 [self addSubview:recipeImageView];
             }
         }
    }];
    
}
-(void)recipeImageClick{
    FoodInfoController *foodInfoController=[[FoodInfoController alloc] initWithNibName:@"FoodInfoController" bundle:nil];
    id controll=[self nextResponder];
    while (![controll isKindOfClass:[ListMainViewCongtroller class]]) {
        controll=[controll nextResponder];
    }
    ListMainViewCongtroller *lc=controll;
//    NSInteger categoryIndex=((ZTRightListView *)self.superview).categoryIndex ;
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.tag inSection:categoryIndex];
//    [mainMenuController setIndexPath:indexPath];
    ZTRightListView *superRightListView=(ZTRightListView *) self.superview;
    
    [foodInfoController setListRecipeData:superRightListView.categoryID];
    [foodInfoController showFoodInfo:self.tag];
    [lc.navigationController pushViewController:foodInfoController animated:YES];
    NSLog(@"%d",[lc.tabBarController.viewControllers count]);
    [foodInfoController release];

}
- (void)setEnableTouch:(BOOL)enableTouch {
    ZTRightListViewCell *pView=self.previousZTRightListViewCell;
    ZTRightListViewCell *bView=self.behindZTRightListViewCell;
    while (pView!=nil) {
        pView.userInteractionEnabled=enableTouch;
        pView=pView.previousZTRightListViewCell;
    }
    while (bView!=nil) {
        bView.userInteractionEnabled=enableTouch;
        bView=bView.behindZTRightListViewCell;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *touch=[touches anyObject];    
    self.startPoint=self.frame.origin;
    [self setEnableTouch:NO];
}
- (void)moveAlone:(CGFloat) offset {
    if(!isExtend){
        self.buttomView.hidden=NO;
        [UIView beginAnimations:@"extend" context:nil];
        [UIView setAnimationDuration:AMIMATOIN_TIME];
        [UIView setAnimationDelegate:self];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width, self.frame.size.height+buttomView.frame.size.height)];
        ZTRightListViewCell *bZTRightListViewCell=self.behindZTRightListViewCell;
        while (bZTRightListViewCell!=nil) {
            [bZTRightListViewCell setFrame:CGRectMake(bZTRightListViewCell.frame.origin.x, bZTRightListViewCell.frame.origin.y+buttomView.frame.size.height,bZTRightListViewCell.frame.size.width, bZTRightListViewCell.frame.size.height)];
            bZTRightListViewCell=bZTRightListViewCell.behindZTRightListViewCell;
        }
        ZTRightListView *ztRightListView =(ZTRightListView *)self.superview;
        [ztRightListView setContentSize:CGSizeMake(ztRightListView.contentSize.width, ztRightListView.contentSize.height+buttomView.frame.size.height)];
        [ztRightListView setContentOffset:CGPointMake(ztRightListView.contentOffset.x, ztRightListView.contentOffset.y+offset)];
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:@"extend" context:nil];
        [UIView setAnimationDuration:AMIMATOIN_TIME];
        [UIView setAnimationDelegate:self];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width, self.frame.size.height-buttomView.frame.size.height)];
        ZTRightListViewCell *bZTRightListViewCell=self.behindZTRightListViewCell;
        while (bZTRightListViewCell!=nil) {
            [bZTRightListViewCell setFrame:CGRectMake(bZTRightListViewCell.frame.origin.x, bZTRightListViewCell.frame.origin.y-buttomView.frame.size.height,bZTRightListViewCell.frame.size.width, bZTRightListViewCell.frame.size.height)];
            bZTRightListViewCell=bZTRightListViewCell.behindZTRightListViewCell;
        }
        ZTRightListView *ztRightListView =(ZTRightListView *)self.superview;
        [ztRightListView setContentSize:CGSizeMake(ztRightListView.contentSize.width, ztRightListView.contentSize.height-buttomView.frame.size.height)];
        [ztRightListView setContentOffset:CGPointMake(ztRightListView.contentOffset.x, ztRightListView.contentOffset.y+offset)];
        [UIView commitAnimations];        
    }
    isExtend=!isExtend;

}
//获取已经展开的单元格
-(NSInteger)getExtendView{
    ZTRightListViewCell *pView=self.previousZTRightListViewCell;
    ZTRightListViewCell *bView=self.behindZTRightListViewCell;
    while (pView!=nil) {
        if (pView.isExtend) {
            return pView.tag;
        }
        pView=pView.previousZTRightListViewCell;
    }
    while (bView!=nil) {
        if (bView.isExtend) {
            return bView.tag;
        }
        bView=bView.behindZTRightListViewCell;
    }
    return self.tag;
}
-(void)moveToUp:(CGFloat)offset{
    self.buttomView.hidden=NO;
    isExtend=!isExtend;
    [UIView beginAnimations:@"extend" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:AMIMATOIN_TIME];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y-buttomView.frame.size.height,self.frame.size.width, self.frame.size.height+buttomView.frame.size.height)];
    ZTRightListViewCell *pView=self.previousZTRightListViewCell;
    while (pView!=nil) {
        if (pView.isExtend) {
            [pView setFrame:CGRectMake(pView.frame.origin.x, pView.frame.origin.y,pView.frame.size.width, pView.frame.size.height-buttomView.frame.size.height)];
            pView.isExtend=NO;
            ZTRightListView *ztRightListView =(ZTRightListView *)self.superview;
            if(offset<0)
                [ztRightListView setContentOffset:CGPointMake(ztRightListView.contentOffset.x, ztRightListView.contentOffset.y+offset-buttomView.frame.size.height)];
            if(offset>0&&(offset-buttomView.frame.size.height)>0)
                [ztRightListView setContentOffset:CGPointMake(ztRightListView.contentOffset.x, ztRightListView.contentOffset.y+offset-buttomView.frame.size.height)];
            [UIView commitAnimations];
            currentView= pView;
            return;
        }
        [pView setFrame:CGRectMake(pView.frame.origin.x, pView.frame.origin.y-buttomView.frame.size.height,pView.frame.size.width, pView.frame.size.height)];
        pView=pView.previousZTRightListViewCell;
    }
}
-(void)moveToDown:(CGFloat)offset{
    self.buttomView.hidden=NO;
    isExtend=!isExtend;
    [UIView beginAnimations:@"extend" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:AMIMATOIN_TIME];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width, self.frame.size.height+buttomView.frame.size.height)];
    ZTRightListViewCell *bView=self.behindZTRightListViewCell;
    while (bView!=nil) {
        if (bView.isExtend) {
            [bView setFrame:CGRectMake(bView.frame.origin.x, bView.frame.origin.y+buttomView.frame.size.height,bView.frame.size.width, bView.frame.size.height-buttomView.frame.size.height)];
            bView.isExtend=NO;
            ZTRightListView *ztRightListView =(ZTRightListView *)self.superview;
            [ztRightListView setContentOffset:CGPointMake(ztRightListView.contentOffset.x, ztRightListView.contentOffset.y+offset)];
            [UIView commitAnimations];
            currentView= bView;
            return;        }
        [bView setFrame:CGRectMake(bView.frame.origin.x, bView.frame.origin.y+buttomView.frame.size.height,bView.frame.size.width, bView.frame.size.height)];
        bView=bView.behindZTRightListViewCell;
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self];
    if (self.startPoint.y==self.frame.origin.y&&currentTouchPosition.y<80) {
        //计算上下单元格正确显示所需的偏移量
        self.userInteractionEnabled=NO;
        ZTRightListView *ztRightListView =(ZTRightListView *)self.superview;
        CGFloat offset=0;
        if (self.frame.origin.y<ztRightListView.contentOffset.y) {
            offset=self.frame.origin.y-ztRightListView.contentOffset.y;
        }
        if (self.frame.origin.y>=ztRightListView.contentOffset.y+330-buttomView.frame.size.height) {
            offset=(self.frame.origin.y-ztRightListView.contentOffset.y-330+buttomView.frame.size.height);
        }
        NSInteger extendIndex=[self getExtendView ];
        if(extendIndex==self.tag){
        [self moveAlone:offset];
        }
        if (extendIndex<self.tag) {
            [self moveToUp:offset];
        }
        if (extendIndex>self.tag) {
            [self moveToDown:offset];
        }
    }
    else{
        [self setEnableTouch:YES];
    }
    
    startPoint=self.frame.origin;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        if (!isExtend){
            self.buttomView.hidden=YES;
        }
        if (currentView!=nil&&!currentView.isExtend) {
            currentView.buttomView.hidden=YES;
        }
        self.userInteractionEnabled=YES;
        [self setEnableTouch:YES];
        currentView=nil;
    }
    if ([anim isKindOfClass:[CAKeyframeAnimation class]]&&[self.subviews count]>5) {
        UIImageView *aImageView=[self.subviews objectAtIndex:5];
        [aImageView removeFromSuperview];
         [countLabel setText:[NSString stringWithFormat:@"%d 份",_recipeCount]];
        if(_recipeCount==0){
            checkOrderImageView.hidden=YES;
            [countLabel setText:nil];
        }
        else{
            checkOrderImageView.hidden=NO;
        }
    }
}
-(void)setRecipeCount:(NSInteger)count{
    if (count==0) {
        [countLabel setText:nil];
        checkOrderImageView.hidden=YES;
        _recipeCount=count;
        return;
    }
    _recipeCount=count;
    [countLabel setText:[NSString stringWithFormat:@"%d 份",_recipeCount]];
    checkOrderImageView.hidden=NO;
}
-(void)recipeImageAnimation
{
//    //定义图片的位置和尺寸,位置:x=268.0f, y=115.0f ,尺寸:x=20.0f, y=20.0f
//    
    UIImageView *recipeAnimation= [[UIImageView alloc] initWithFrame:                            
                            CGRectMake(-100, -100, 30.0f, 30.0f)];   
         [recipeAnimation setImage:self.recipe.rImage];     
    [self addSubview:recipeAnimation];
    CGMutablePathRef thePath =  CGPathCreateMutable();
    CGPathMoveToPoint(thePath, NULL, 25, 60);
    CGPathAddLineToPoint(thePath, NULL, 40, 30);
    CGPathAddLineToPoint(thePath, NULL, 80, 20);
    CGPathAddLineToPoint(thePath, NULL, 100, 15);
    CGPathAddLineToPoint(thePath, NULL, 120, 20);
    CGPathAddLineToPoint(thePath, NULL, 145, 45);
    CGPathAddLineToPoint(thePath, NULL, 160, 100);
    CAKeyframeAnimation *theAnimation =[CAKeyframeAnimation animationWithKeyPath:@"position"];
    theAnimation.path=thePath;
    theAnimation.duration=0.4;
    theAnimation.repeatCount = 1; // 无线循环
    theAnimation.autoreverses=NO;
    theAnimation.cumulative=YES;
    theAnimation.delegate=self;
    [recipeAnimation.layer addAnimation:theAnimation forKey:@"animateLayer"]; // 添加动画。
    CFRelease(thePath);
    [recipeAnimation release];
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
