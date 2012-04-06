//
//  LeftListView.m
//  Diancan
//
//  Created by 李炜 on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZTLeftListView.h"
#import <QuartzCore/QuartzCore.h> 
#import "ListMainView.h"
@implementation ZTLeftListView
@synthesize listCategory,ztRightListView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];

    }
    return self;
}
-(void)categoryBtnClick:(id)sender{
    for (UIButton *aButton in listButton) {
        aButton.backgroundColor=[UIColor colorWithRed:222 green:222 blue:222 alpha:1];
        [aButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [aButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    }
    UIButton *aButton=(UIButton *)sender;
    aButton.backgroundColor=[UIColor orangeColor];
    [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    ZTCategory *aCategory=(ZTCategory *)[self.listCategory objectAtIndex:aButton.tag];
    [self.ztRightListView removeFromSuperview];
    self.ztRightListView=[[[ZTRightListView alloc] initWithFrame:CGRectMake(80, 0, 240, 410)] autorelease];
    [self.superview addSubview:ztRightListView];
    [self.ztRightListView loadRecipeWithCategory:aCategory];
    ListMainView *listMainView=(ListMainView *)self.superview; 
    listMainView.ztLeftListView.userInteractionEnabled=NO;
}

-(void)loadCategory{
    [ApplicationDelegate.restEngine getAllCategoriesOnCompletion:^(NSArray *array) {
        self.listCategory=[[[NSArray alloc] initWithArray:array] autorelease];
        [self setContentSize:CGSizeMake(80, [self.listCategory count]*450+5)];
        listButton =[[NSMutableArray alloc] init];
        for (int i=0; i<[self.listCategory count]; i++) {
            UIButton *categoryButton=[UIButton buttonWithType:UIButtonTypeCustom];
            [categoryButton.titleLabel setFont:[UIFont fontWithName:categoryButton.titleLabel.font.fontName size:15]];
            [categoryButton setTag:i];
            [categoryButton setFrame:CGRectMake(5, 5+i*45, 70, 35)];
            categoryButton.layer.cornerRadius = 10;  
            categoryButton.layer.shadowOffset =  CGSizeMake(3, 5);  
            categoryButton.layer.shadowOpacity = 0.8;  
            categoryButton.layer.shadowColor =  [UIColor blackColor].CGColor;
                        ZTCategory *category=[self.listCategory objectAtIndex:i];
            categoryButton.backgroundColor=[UIColor colorWithRed:222 green:222 blue:222 alpha:1];
            [categoryButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [categoryButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
            [categoryButton setTitle:category.cName forState:UIControlStateNormal];
            [categoryButton addTarget:self action:@selector(categoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:categoryButton];
            [listButton addObject:categoryButton];
        }           
    
        [self categoryBtnClick:[self.subviews objectAtIndex:0]]; 
    } onError:^(NSError *error) {
        NSLog(@"保存数据到数据库出错：%@",error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新失败"                              
                                                        message:@"更新数据失败"
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }];

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
