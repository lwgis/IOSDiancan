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
#import "CategoryCell.h"
#import "SelectDeskController.h"
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
//    [self.navigationController setNavigationBarHidden:YES]; 
 
   UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 360)];
   orderView=scrollView;
   [self.view addSubview:scrollView];
   [scrollView release];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"桌号" style:UIBarButtonItemStylePlain
                                                                      target:self action:@selector(onLeftButton)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    [leftButtonItem release];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain
                                                                       target:nil action:nil];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    [rightButtonItem release];
}
-(void)onLeftButton{
    SelectDeskController *selectDeskController=[[SelectDeskController alloc] init];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];  
    temporaryBarButtonItem.title = @"主界面";  
    temporaryBarButtonItem.target = self;  
    temporaryBarButtonItem.action = @selector(back);  
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;  
    [temporaryBarButtonItem release];  
    selectDeskController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:selectDeskController animated:YES];
    [selectDeskController release];
}

-(void)getPrice{
    CGFloat price=[ApplicationDelegate.order getPrice];
    [self.navigationItem setTitle:[NSString stringWithFormat:@"总计：%.2f",price]];
}

-(void)viewWillAppear:(BOOL)animated{
    if (ApplicationDelegate.deskName!=nil) {
        NSLog(@"%@",ApplicationDelegate.deskName);
        [self.navigationItem.leftBarButtonItem setTitle:ApplicationDelegate.deskName];
        [self.navigationItem.leftBarButtonItem setEnabled:NO];
    }
    else
    {
        [self.navigationItem.leftBarButtonItem setTitle:@"桌号"];
        [self.navigationItem.leftBarButtonItem setEnabled:YES];
    }
    [self getPrice];
    for (UIView *aView in ((UIView *)[self.view.subviews objectAtIndex:0]).subviews){
        NSLog(@"%@",[aView class]);
            [aView removeFromSuperview];
    }
    NSMutableArray *recipes=[ApplicationDelegate.order getRecipes];
    NSArray *categorys=[ApplicationDelegate.order getCategoryName];
    CGFloat heigt=0;
    for (NSInteger j=0; j<[categorys count]; j++) {
        NSString *cName = [categorys objectAtIndex:j];
        CategoryCell *aCategoryCell=[[CategoryCell alloc] initWithFrame:CGRectMake(0, heigt, 320,60)];
        NSInteger i=0;
        for (NSMutableDictionary *aDic in recipes) {
            ZTRecipe *aRecipe=(ZTRecipe *) [aDic valueForKey:@"recipe"];
            NSString *countString=(NSString *)[aDic valueForKey:@"count"];
            NSInteger rCount=[countString integerValue];
            if([aRecipe.cName isEqual:cName]){
                      FoodCell *foodCell=[[FoodCell alloc] initWithFrame:CGRectMake(10, i*60+30, 310, 60)];
            [foodCell setTag:i];
            [foodCell loadRecipeData:aRecipe count:rCount];
            if (i>0) {
                FoodCell *bFoodCell=(FoodCell *)[aCategoryCell.subviews objectAtIndex:i];
                [ bFoodCell setNextFoodCell:foodCell];
                [foodCell setPreFoodCell:bFoodCell];      
            }
                [aCategoryCell addSubview:foodCell];
            [foodCell release];
                i++;
            [aCategoryCell setFrame:CGRectMake(0, heigt, 320,i*60+30)];

            }
        }
        heigt=heigt+30+i*60;
        if (j>0) {
            CategoryCell *bCategory=(CategoryCell *)[self.orderView.subviews objectAtIndex:j-1];
            [bCategory setNextCategoryCell:aCategoryCell];
            [aCategoryCell setPreCategoryCell:bCategory];
        }
        [aCategoryCell setText:cName];
        [self.orderView addSubview:aCategoryCell];
        [aCategoryCell release];
    }
    [self.orderView setContentSize:CGSizeMake(320,heigt)];
}
-(void)viewDidAppear:(BOOL)animated{
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
