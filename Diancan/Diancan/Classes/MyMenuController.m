//
//  MyMenuController.m
//  Diancan
//
//  Created by 李炜 on 12-2-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyMenuController.h"
#import "FoodCell.h"
#import "ZTCategory.h"
#import <QuartzCore/QuartzCore.h>
@interface MyMenuController ()
@property(nonatomic,assign)UIScrollView *orderView;
@end
@implementation MyMenuController
@synthesize orderView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    orderView=(UIScrollView *)self.view;
    [self.orderView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    [self.orderView setContentSize:CGSizeMake(320, 960)];
    for (NSInteger i=0; i<20; i++) {
        FoodCell *foodCell=[[FoodCell alloc] initWithFrame:CGRectMake(20, i*70+20, 200, 50)];
        [self.view addSubview:foodCell];
        [foodCell release];
    }
    
//    ((UITableView *)self.view).separatorStyle = NO;
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
    return (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}
-(void)viewWillAppear:(BOOL)animated{
}



@end
