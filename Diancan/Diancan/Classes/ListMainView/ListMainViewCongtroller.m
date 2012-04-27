//
//  ListMainViewCongtroller.m
//  Diancan
//
//  Created by 李炜 on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ListMainViewCongtroller.h"
#import "ListMainView.h"
#import "ZTLeftListView.h"
#import "ZTRightListView.h"
#import "ZTRightListViewCell.h"
@implementation ListMainViewCongtroller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:YES]; 

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    ListMainView *listMainView=(ListMainView *)self.view;
    ZTLeftListView *ztLview=listMainView.ztLeftListView;
    if(ztLview==nil)return;
    ZTRightListView *ztRview=ztLview.ztRightListView;
    if(ztRview==nil)return;
    for (UIView *view in ztRview.subviews) {
        if ([view isKindOfClass:[ZTRightListViewCell class]]) {
            ZTRightListViewCell *ztCell=(ZTRightListViewCell *)view;
            NSInteger count=[ApplicationDelegate.order getRecipeCount:ztCell.recipe];  
            [ztCell setRecipeCount:count];  
        }
    }
}
@end
