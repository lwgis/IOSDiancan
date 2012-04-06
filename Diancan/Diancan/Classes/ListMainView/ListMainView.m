//
//  ListMainView.m
//  Diancan
//
//  Created by 李炜 on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ListMainView.h"
@implementation ListMainView
@synthesize ztRightListView,ztLeftListView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
                                   
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        ztLeftListView=[[ZTLeftListView alloc] initWithFrame:CGRectMake(0, 0, 80, 420)];
        [ztLeftListView loadCategory];
        [self addSubview:ztLeftListView];
        ztRightListView=[[[ZTRightListView alloc] initWithFrame:CGRectMake(80, 0, 240, 410)] autorelease];
        [self addSubview:ztRightListView];
        [ztLeftListView setZtRightListView:ztRightListView];
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

@end
