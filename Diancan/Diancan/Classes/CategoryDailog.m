//
//  CategoryDailog.m
//  Diancan
//
//  Created by 李炜 on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CategoryDailog.h"
#import "ZTCategory.h"
#import <QuartzCore/QuartzCore.h>
@implementation CategoryDailog

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *topImageView=[[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-7.5, 0, 15, 15)];
        [topImageView setImage:[UIImage imageNamed:@"cDialogTop.png"]];
        [self addSubview:topImageView];
        [topImageView release];
    }
    return self;
}
-(void)showDialog:(NSString *)cName{
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, [ApplicationDelegate.listCategory count]*30+15)];
    NSInteger i=15;
    for (ZTCategory *aCategory in ApplicationDelegate.listCategory) {
        UIButton *abutton=[UIButton buttonWithType:UIButtonTypeCustom];
        [abutton setFrame:CGRectMake(0, i, self.frame.size.width, 30)];
        [abutton setTitle:aCategory.cName forState:UIControlStateNormal];
        if ([aCategory.cName isEqualToString:cName]) {
            [abutton setBackgroundImage:[UIImage imageNamed:@"cDialogCheck.png"] forState:UIControlStateNormal];
//            [abutton setBackgroundColor:[UIColor orangeColor]];
        }
        else{
//            [abutton setBackgroundColor:[UIColor blackColor]];
            [abutton setBackgroundImage:[UIImage imageNamed:@"cDialogButtom.png"] forState:UIControlStateNormal];
            [abutton setBackgroundImage:[UIImage imageNamed:@"cDialogCheck.png"] forState:UIControlStateHighlighted];
        }
        [abutton setTag:(i-15)/30 ];
        [abutton addTarget:self.superview action:@selector(selectCategoryClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:abutton];
        i+=30;
    }
//    [self.layer setShadowRadius:16];
//    [self.layer setShadowColor:[[UIColor blackColor] CGColor]]; 
//    [self.layer setShadowOpacity:1];
    [self.layer setShadowOffset:CGSizeMake(5, 5)];

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
