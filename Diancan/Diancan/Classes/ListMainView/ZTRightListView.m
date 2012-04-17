//
//  ZTRightListView.m
//  Diancan
//
//  Created by 李炜 on 12-4-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZTRightListView.h"
#import "ZTRightListViewCell.h"
#import "ListMainView.h"
@implementation ZTRightListView{
}
@synthesize categoryIndex;
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.delegate=self;
        self.backgroundColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        [self setMultipleTouchEnabled:NO];
//        [self setCanCancelContentTouches:YES];
//        [self setDelaysContentTouches:NO];
    }
    return  self;
}
-(void)loadRecipeWithCategory:(ZTCategory *)category{
    [self setShowsVerticalScrollIndicator:NO];
    for(ZTRightListViewCell *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    
    [[RestEngine sharedEngine] getRecipesByCategory:(NSInteger)[category.cID floatValue]  OnCompletion:^(NSArray *list) {
        for (NSInteger i=0; i<[list count]; i++) {
            ZTRightListViewCell *ztRightListView=[[ZTRightListViewCell alloc] initWithFrame:CGRectMake(0, i*80, 240, 80)];
            ztRightListView.tag=i;
            ZTRecipe *aRecipe=(ZTRecipe *)[list objectAtIndex:i];
            [ztRightListView loadRecipe:aRecipe];
            NSInteger count=[ApplicationDelegate.order getRecipeCount:aRecipe];  
            [ztRightListView setRecipeCount:count];        
            if ([self.subviews count]>0) {
                ZTRightListViewCell *preZTRightListViewCell=(ZTRightListViewCell *)[self.subviews objectAtIndex:(i-1)];
                preZTRightListViewCell.behindZTRightListViewCell=ztRightListView;
                ztRightListView.previousZTRightListViewCell=preZTRightListViewCell;
            }
            [self addSubview:ztRightListView];
            [ztRightListView release];
        }
        [self setContentSize:CGSizeMake(220, [list count]*80)];
        [self setContentOffset:CGPointMake(0, 0)];
        ListMainView *listMainView=(ListMainView *)self.superview; 
        listMainView.ztLeftListView.userInteractionEnabled=YES;
    } onError:^(NSError *error) {
        
    } ];    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    for(ZTRightListViewCell *subview in [self subviews]) {
        [subview setUserInteractionEnabled:YES];
    }

}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate) {
        for(ZTRightListViewCell *subview in [self subviews]) {
            [subview setUserInteractionEnabled:YES];
        }
    }
}

-(BOOL)touchesShouldCancelInContentView:(UIView *)view{
    if ([view isKindOfClass: [UIButton class]]) {
        return NO;
    }
    return YES;
}

@end
