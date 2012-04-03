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
@implementation ZTRightListView
-(void)loadRecipeWithCategory:(ZTCategory *)category{
    [self setShowsVerticalScrollIndicator:NO];
    for(ZTRightListViewCell *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    [ApplicationDelegate.restEngine getRecipesByCategory:(NSInteger)[category.cID floatValue]  OnCompletion:^(NSArray *list) {
        for (NSInteger i=0; i<[list count]; i++) {
            ZTRightListViewCell *ztRightListView=[[ZTRightListViewCell alloc] initWithFrame:CGRectMake(0, i*80, 240, 80)];
            ztRightListView.tag=i;
            [ztRightListView loadRecipe:(ZTRecipe *)[list objectAtIndex:i]];
            if ([self.subviews count]>0) {
                ZTRightListViewCell *preZTRightListViewCell=(ZTRightListViewCell *)[self.subviews objectAtIndex:(i-1)];
                preZTRightListViewCell.behindZTRightListViewCell=ztRightListView;
                ztRightListView.previousZTRightListViewCell=preZTRightListViewCell;
            }
            [self addSubview:ztRightListView];
            [ztRightListView release];
            ListMainView *listMainView=(ListMainView *)self.superview; 
            listMainView.ztLeftListView.userInteractionEnabled=YES; 
        }
        [self setContentSize:CGSizeMake(220, [list count]*80)];
        [self setContentOffset:CGPointMake(0, 0)];
    } onError:^(NSError *error) {
        
    } ];
    
}

@end
