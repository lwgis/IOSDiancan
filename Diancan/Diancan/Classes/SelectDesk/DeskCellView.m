//
//  DeskCellView.m
//  Diancan
//
//  Created by 李炜 on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DeskCellView.h"

@implementation DeskCellView
@synthesize deskVolume,deskNameLable;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setBackgroundColor:[UIColor whiteColor]];
        UILabel *labelDeskName=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 20)];
        [labelDeskName setTextAlignment:UITextAlignmentCenter];
        [labelDeskName setFont:[UIFont fontWithName:labelDeskName.font.fontName size:13]];
        [labelDeskName setBackgroundColor:[UIColor clearColor]];
        [self setDeskNameLable:labelDeskName];
        [self addSubview:labelDeskName];
        [labelDeskName release];
        UILabel *labelDeskVolume=[[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-25, frame.size.width, 20)];
        [labelDeskVolume setTextColor:[UIColor orangeColor]];
        [labelDeskVolume setFont:[UIFont fontWithName:labelDeskVolume.font.fontName size:13]];
        [labelDeskVolume setBackgroundColor:[UIColor clearColor]];
        [labelDeskVolume setTextAlignment:UITextAlignmentCenter];
        [self setDeskVolume:labelDeskVolume];
        [self addSubview:labelDeskVolume];
        [labelDeskVolume release];
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
