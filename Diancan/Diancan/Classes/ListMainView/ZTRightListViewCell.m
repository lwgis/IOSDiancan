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
@implementation ZTRightListViewCell
{
    UIImageView *recipeImageView;
    UILabel *recipeNameLable;
    UILabel *recipePriceLable;
    
}
@synthesize recipe,behindZTRightListViewCell,previousZTRightListViewCell,startPoint,buttomView,isExtend;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        isExtend=NO;
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
        UIImageView *addImage=[[UIImageView alloc] initWithFrame:CGRectMake(160, 0, 40, 40)];
        image=[UIImage imageNamed:@"加号.png"];
        [addImage setImage:image];
        buttomView=[[UIView alloc] initWithFrame:CGRectMake(0, 80, 240, 40)];
        buttomView.backgroundColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        [buttomView addSubview:addImage];
        [self addSubview:buttomView];
        [self.buttomView setHidden:YES];
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
- (void)moveAlone:(CGFloat) offset {
    if(!isExtend){
        self.buttomView.hidden=NO;
        [UIView beginAnimations:@"extend" context:nil];
        [UIView setAnimationDuration:0.2];
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
        [UIView setAnimationDuration:0.2];
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
    [UIView beginAnimations:@"extend" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.2];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y-buttomView.frame.size.height,self.frame.size.width, self.frame.size.height+buttomView.frame.size.height)];
    ZTRightListViewCell *pView=self.previousZTRightListViewCell;
    while (pView!=nil) {
        if (pView.isExtend) {
            [pView setFrame:CGRectMake(pView.frame.origin.x, pView.frame.origin.y,pView.frame.size.width, pView.frame.size.height-buttomView.frame.size.height)];
            pView.isExtend=NO;
            ZTRightListView *ztRightListView =(ZTRightListView *)self.superview;
            if(offset!=0)
            [ztRightListView setContentOffset:CGPointMake(ztRightListView.contentOffset.x, ztRightListView.contentOffset.y+offset-buttomView.frame.size.height)];
            [UIView commitAnimations];
            currentView= pView.buttomView;
            return;
        }
        [pView setFrame:CGRectMake(pView.frame.origin.x, pView.frame.origin.y-buttomView.frame.size.height,pView.frame.size.width, pView.frame.size.height)];
        pView=pView.previousZTRightListViewCell;
    }
}
-(void)moveToDown:(CGFloat)offset{
    self.buttomView.hidden=NO;
    [UIView beginAnimations:@"extend" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.2];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width, self.frame.size.height+buttomView.frame.size.height)];
    ZTRightListViewCell *bView=self.behindZTRightListViewCell;
    while (bView!=nil) {
        if (bView.isExtend) {
            [bView setFrame:CGRectMake(bView.frame.origin.x, bView.frame.origin.y+buttomView.frame.size.height,bView.frame.size.width, bView.frame.size.height-buttomView.frame.size.height)];
            bView.isExtend=NO;
            ZTRightListView *ztRightListView =(ZTRightListView *)self.superview;
            [ztRightListView setContentOffset:CGPointMake(ztRightListView.contentOffset.x, ztRightListView.contentOffset.y+offset)];
            [UIView commitAnimations];
            currentView= bView.buttomView;
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
        NSLog(@"%f",ztRightListView.contentOffset.y+310-self.frame.origin.y);
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
    
    startPoint=self.frame.origin;
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (isExtend){
        self.buttomView.hidden=YES;
    }
    isExtend=!isExtend;
    currentView.hidden=YES;
    self.userInteractionEnabled=YES;
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
