//
//  TitleView.m
//  Diancan
//
//  Created by 李炜 on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView
@synthesize triangleImageView;
- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 20, 40)];
        [imageView setImage:[UIImage imageNamed:@"daosanjiao.png"]];
        [self setTriangleImageView:imageView];
        [self addSubview:imageView];
        [imageView release];
    }
    return self;
}
-(void)sizeToFit{
    [self.titleLabel sizeToFit];
    [self.triangleImageView setFrame:CGRectMake(self.titleLabel.frame.origin.x+self.titleLabel.frame.size.width, self.triangleImageView.frame.origin.y, 20, 40)];
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
