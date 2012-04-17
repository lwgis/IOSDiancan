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
    NSLog(@"%d",[self.view.subviews count]);
    [self.navigationController setNavigationBarHidden:YES]; 
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 410)];
    orderView=scrollView;
    [self.view addSubview:scrollView];
    [scrollView release];
    [self.orderView setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
    
//    [self.orderView setContentSize:CGSizeMake(320, 960)];
//    for (NSInteger i=0; i<20; i++) {
//        FoodCell *foodCell=[[FoodCell alloc] initWithFrame:CGRectMake(10, i*80+10, 310, 80)];
//        [self.view addSubview:foodCell];
//        [foodCell release];
//    }
    
//    ((UITableView *)self.view).separatorStyle = NO;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    for (UIView *aView in orderView.subviews){
        if([aView isKindOfClass:[FoodCell class]]){
        [aView removeFromSuperview];
        [aView release];
        }
    }
    NSMutableArray *recipes=[ApplicationDelegate.order getRecipes];
    NSInteger i=0;
    for (NSMutableDictionary *aDic in recipes) {
        ZTRecipe *aRecipe=(ZTRecipe *) [aDic valueForKey:@"recipe"];
        NSString *countString=(NSString *)[aDic valueForKey:@"count"];
        NSInteger rCount=[countString integerValue];
        FoodCell *foodCell=[[FoodCell alloc] initWithFrame:CGRectMake(10, i*60+15, 310, 60)];
        [foodCell loadRecipeData:aRecipe count:rCount];
        if (i>0) {
            FoodCell *bFoodCell=(FoodCell *)[self.orderView.subviews objectAtIndex:i-1];
            [ bFoodCell setNextFoodCell:foodCell];
        }
        [self.orderView addSubview:foodCell];
        [foodCell release];
        i++;
    }
    [self.orderView setContentSize:CGSizeMake(320, i*60+15)];
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




@end
