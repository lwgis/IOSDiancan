//
//  SelectTitleView.m
//  Diancan
//
//  Created by 李炜 on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectTitleDialog.h"
#import "ZTDesk.h"
#import "ZTDeskType.h"
@implementation SelectTitleDialog

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *topImageView=[[UIImageView alloc] initWithFrame:CGRectMake(70, 0, 15, 15)];
        [topImageView setImage:[UIImage imageNamed:@"cDialogTop.png"]];
        [self addSubview:topImageView];
        [topImageView release];
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
-(void)showDialog:(NSArray *)deskList deskName:(NSString *)dName{
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, [deskList count]*30+15)];
        NSInteger i=15;
        for (ZTDeskType *aDeskType in deskList) {
            UIButton *abutton=[UIButton buttonWithType:UIButtonTypeCustom];
            [abutton setFrame:CGRectMake(0, i, self.frame.size.width, 30)];
            [abutton setTitle:aDeskType.tName forState:UIControlStateNormal];
            if ([aDeskType.tName isEqualToString:dName]) {
                [abutton setBackgroundImage:[UIImage imageNamed:@"cDialogCheck.png"] forState:UIControlStateNormal];
                //            [abutton setBackgroundColor:[UIColor orangeColor]];
            }
            else{
                //            [abutton setBackgroundColor:[UIColor blackColor]];
                [abutton setBackgroundImage:[UIImage imageNamed:@"cDialogButtom.png"] forState:UIControlStateNormal];
                [abutton setBackgroundImage:[UIImage imageNamed:@"cDialogCheck.png"] forState:UIControlStateHighlighted];
            }
            [abutton setTag:(i-15)/30 ];
            [abutton addTarget:self.superview action:@selector(selectDeskTypeClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:abutton];
            i+=30;
        }
        //    [self.layer setShadowRadius:16];
        //    [self.layer setShadowColor:[[UIColor blackColor] CGColor]]; 
        //    [self.layer setShadowOpacity:1];
        [self.layer setShadowOffset:CGSizeMake(5, 5)];        
}
@end
