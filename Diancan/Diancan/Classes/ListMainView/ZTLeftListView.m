//
//  LeftListView.m
//  Diancan
//
//  Created by 李炜 on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZTLeftListView.h"

@implementation ZTLeftListView
@synthesize listCategory;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)loadCategory{
    [ApplicationDelegate.restEngine getAllCategoriesOnCompletion:^(NSArray *array) {
        self.listCategory=[[[NSArray alloc] initWithArray:array] autorelease];
        for (int i=0; i<[self.listCategory count]; i++) {
            UIButton *categoryButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 5+i*10, 30, 10)];
        }
            
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
