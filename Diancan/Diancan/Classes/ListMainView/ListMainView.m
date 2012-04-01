//
//  ListMainView.m
//  Diancan
//
//  Created by 李炜 on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ListMainView.h"
@implementation ListMainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        ZTLeftListView *ztLeftListView=[[ZTLeftListView alloc] initWithFrame:CGRectMake(0, 60, 40, 350)];
        [self addSubview:ztLeftListView];
        [ztLeftListView release];
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
