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
#define AMIMATOIN_TIME  0.2
@implementation ZTRightListViewCell
{
    UIImageView *recipeImageView;
    UILabel *recipeNameLable;
    UILabel *recipePriceLable;
}
@synthesize recipe,behindZTRightListViewCell,previousZTRightListViewCell,startPoint,buttomView,isExtend;
-(void)removeFromSuperview{
    [recipeImageView removeFromSuperview];
    [recipeImageView release];
    [recipeNameLable removeFromSuperview];
    [recipeNameLable release];
    [recipePriceLable removeFromSuperview];
    [recipePriceLable release];
    [buttomView removeFromSuperview];
    [buttomView release];
    [super removeFromSuperview];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.multipleTouchEnabled=NO;
        isExtend=NO;
        self.backgroundColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        UIImageView *cellImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height )];
        UIImage *image=[UIImage imageNamed:@"LifeViewCell.png"];
        [cellImageView setImage:image];
        [cellImageView setAlpha:1];
        [self addSubview:cellImageView];
        [cellImageView release];
//        UIImageView *topImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 2)];
//         image=[UIImage imageNamed:@"top.png"];
//        [topImageView setImage:image];
//        [topImageView setAlpha:0.6];
//        [self addSubview:topImageView];
    
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
       UIImageView *addImage=[[UIImageView alloc] initWithFrame:CGRectMake(190, 18, 40, 40)];
       image=[UIImage imageNamed:@"加号.png"];    
       [addImage setImage:image];
        UIImageView *reMoveImage=[[UIImageView alloc] initWithFrame:CGRectMake(100, 18, 40, 40)];
        image=[UIImage imageNamed:@"减号.png"];    
        [reMoveImage setImage:image];
        buttomView=[[UIView alloc] initWithFrame:CGRectMake(0, 80, 240, 60)];
        buttomView.backgroundColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        [buttomView addSubview:backgroudImageView];
        [backgroudImageView release];
        [buttomView addSubview:addImage];    
        [addImage release];
        [buttomView addSubview:reMoveImage];
        [reMoveImage release];
        [self addSubview:buttomView];
        [self.buttomView setHidden:YES];
//        [topImageView release];
    }
    return self;
}
-(void)loadRecipe:(ZTRecipe *)aRecipe{
   
    self.recipe=aRecipe;
    [recipeNameLable setText:aRecipe.rName];
    NSString *price=[NSString stringWithFormat:@"￥%@",aRecipe.rPrice];
    [recipePriceLable setText:price];
    [aRecipe getRecipeImage:^(UIImage *image) {
         if(self){
             [recipeImageView removeFromSuperview];
             [recipeImageView.image release];
             [recipeImageView release];
             if(recipeImageView==nil){
                 recipeImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 70, 70)] ;
                 recipeImageView.layer.cornerRadius=5;
                 [recipeImageView setImage:image];
                 [self addSubview:recipeImageView];
             }
         }
    }];
    
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
        NSLog(@"%d%@",self.tag,isExtend?@"yes":@"no");
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
