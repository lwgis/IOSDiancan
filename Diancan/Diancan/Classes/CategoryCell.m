//
//  CategoryCell.m
//  Diancan
//
//  Created by 李炜 on 12-4-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell
@synthesize nextCategoryCell,preCategoryCell;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 80, 30)];
        [imageView setImage:[UIImage imageNamed:@"categoryname.png"]];
        [self addSubview:imageView];        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 30)];
        [label setBackgroundColor:[UIColor clearColor]];
        label.textAlignment=UITextAlignmentCenter;
        label.textColor=[UIColor whiteColor];
        [imageView addSubview:label];
        [label release];
        [imageView release];

    }
    return self;
}
-(void)setText:(NSString *)cName{
    UIImageView *imageView=[self.subviews objectAtIndex:0];
    UILabel *label=[imageView.subviews objectAtIndex:0];
    [label setText:cName];
    [label sizeToFit];
    [imageView setFrame:CGRectMake(10, 0,label.frame.size.width+20,30)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)addrecipeClick{
    
}
@end
