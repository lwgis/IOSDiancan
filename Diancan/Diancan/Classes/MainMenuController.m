//
//  MainMenuController.m
//  Diancan
//
//  Created by 李炜 on 12-2-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainMenuController.h"
#import "FoodInfoController.h"
#import "FoodCell.h"
#import "ZTAppDelegate.h"
#import "CategoryView.h"
#import "ZTRecipe.h"
#import "FoodView.h"
#import "ZTCategory.h"
@interface MainMenuController ()
//@property(nonatomic,assign) NSMutableArray *listCategoryView;
@property  NSInteger  orientation;
@property CGFloat distance;  
@property CGPoint startTouchPosition;
@property(nonatomic,assign) CategoryView *currentCategoryView;
@property(nonatomic,assign) CategoryView *touchCategoryView;
@property(nonatomic,assign) UILabel *labelTopCategoryName;
@end
@implementation MainMenuController
@synthesize listCategoryView,isVerticalMoved,listCategory,indexPath;
@synthesize currentCategoryView,touchCategoryView,labelTopCategoryName,startTouchPosition,orientation,distance;
//显示指定索引的View
-(void)ShowCategoryView:(NSInteger)index{
    if([listCategoryView count]==0)return;
    CategoryView *aCategoryView=[listCategoryView objectAtIndex:index];
    [UIView beginAnimations:@"end" context:nil];
    [UIView setAnimationDuration:0.4*index];
    [UIView setAnimationDelegate:self];
    [aCategoryView setFrame:CGRectMake(0, 60, 320, 280)];
    [aCategoryView setAlpha:1.0];
     distance=-140;
    CategoryView *pView=aCategoryView.previousCategoryView;
    while (pView!=nil) {
        [pView setFrame:CGRectMake(0,60+distance , 320, 280)]; 
        [pView setStartMyPoint:CGPointMake(0, 60+distance)];
        pView=pView.previousCategoryView;
        distance-=140;
    }
    distance=140;
    CategoryView *beView=aCategoryView.behindCategoryView;
//    [beView setFrame:CGRectMake(0, 190, 320, 280)]; 
    while (beView!=nil) {
        [beView setFrame:CGRectMake(0, 200+distance, 320, 280)];
        [beView setStartMyPoint:CGPointMake(0, 200+distance)];
        beView=beView.behindCategoryView;
        distance+=140;
    }
    [UIView commitAnimations];
    currentCategoryView=(CategoryView *)[self.listCategoryView objectAtIndex:index];
    [currentCategoryView setTitleImage:YES];

    [currentCategoryView setCategoryInfo:currentCategoryView.category];

}
-(void)ShowCategoryViewFromSuper:(NSIndexPath *)index{
    if([listCategoryView count]==0)return;
    CategoryView *aCategoryView=[listCategoryView objectAtIndex:index.section];
    CGFloat allViewdistance=aCategoryView.frame.origin.y-60;
    for (CategoryView *cView in listCategoryView) {
        [cView setFrame:CGRectMake(cView.frame.origin.x, cView.frame.origin.y-allViewdistance
                                   , 320, 280)];
    }
    [UIView beginAnimations:@"end" context:nil];
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationDelegate:self];
    [aCategoryView setFrame:CGRectMake(0, 60, 320, 280)];
    [aCategoryView setAlpha:1.0];
    distance=-140;
    CategoryView *pView=aCategoryView.previousCategoryView;
    while (pView!=nil) {
        [pView setFrame:CGRectMake(0,60+distance , 320, 280)]; 
        [pView setStartMyPoint:CGPointMake(0, 60+distance)];
        pView=pView.previousCategoryView;
        distance-=140;
    }
    distance=140;
    CategoryView *beView=aCategoryView.behindCategoryView;
    //    [beView setFrame:CGRectMake(0, 190, 320, 280)]; 
    while (beView!=nil) {
        [beView setFrame:CGRectMake(0, 200+distance, 320, 280)];
        [beView setStartMyPoint:CGPointMake(0, 200+distance)];
        beView=beView.behindCategoryView;
        distance+=140;
    }
    [UIView commitAnimations];
    currentCategoryView=(CategoryView *)[self.listCategoryView objectAtIndex:index.section];
    [currentCategoryView setTitleImage:YES];
//    if(currentCategoryView.previousCategoryView!=nil)
//        [currentCategoryView.previousCategoryView setCategoryInfo:currentCategoryView.previousCategoryView.category];
//    if(currentCategoryView.behindCategoryView!=nil)
//        [currentCategoryView.behindCategoryView setCategoryInfo:currentCategoryView.behindCategoryView.category];
    
    [currentCategoryView setCategoryInfo:currentCategoryView.category];
    [aCategoryView ShowFoodView:index.row Animation:YES];
    if(currentCategoryView.categoryImageView.superview!=nil){
        [currentCategoryView.categoryImageView setHidden:YES];
    }
}

-(void)setTopLabel{
    if (currentCategoryView.previousCategoryView!=nil) {
        [labelTopCategoryName setAlpha:1.0];
        [labelTopCategoryName setText:currentCategoryView.previousCategoryView.category.cName];
    }
    else{
        [labelTopCategoryName setAlpha:0];
    }

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        orientation=0;
    }
        return self;
}

- (void)didReceiveMemoryWarning{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
#pragma mark - View lifecycle

- (void)loadFoodData {
    NSMutableArray *nuArray=[[NSMutableArray alloc] init];
     [self setListCategoryView:nuArray];
    [nuArray release];
    NSInteger i=0;
    for (ZTCategory *ztCategory in self.listCategory) {
        CategoryView *categoryView=[[CategoryView alloc] 
                                    initWithFrame:CGRectMake(0, 140*i-60, 320, 280)] ;
        categoryView.backgroundColor=[UIColor whiteColor];
        [categoryView setCategory:ztCategory];
        [categoryView.labelTopCategoryName setText:ztCategory.cName];
        [ztCategory getCategoryImage:^(UIImage *image){
            if(currentCategoryView.categoryImageView!=nil)
            [categoryView.categoryImageView setImage:image];
            [self setTopLabel];
        } ];
        [categoryView setAlpha:0.4];
        [categoryView setTag:i];
        if (i>0) {
            CategoryView *pView=(CategoryView *)[self.listCategoryView objectAtIndex:(i-1)];
            [pView setBehindCategoryView:categoryView];
            [categoryView setPreviousCategoryView:pView];
        }     
        [self.view addSubview:categoryView];
        [self.listCategoryView addObject:categoryView];
        [categoryView release];
        i++;
    }

//    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0];
    orientation=0;
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:4];
//    [self ShowCategoryViewFromSuper:indexPath];
    UILabel *aLabel=[[UILabel alloc] initWithFrame:CGRectMake(120, 0, 80, 20)];
    aLabel.textAlignment = UITextAlignmentCenter;
    aLabel.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    aLabel.textColor=[UIColor whiteColor];
    [self setLabelTopCategoryName:aLabel];
    [self.view addSubview:aLabel];
    [aLabel release];
    [self setTopLabel];
}

- (void)viewDidLoad{  
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:YES]; 
   [[RestEngine sharedEngine] getAllCategoriesOnCompletion:^(NSArray *array) {
       [self setListCategory:array];
       if([self.listCategoryView count]==0){
       [self loadFoodData];
        [self ShowCategoryViewFromSuper:indexPath];
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
- (void)viewDidUnload{
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
        [super viewDidUnload];

}
-(void)dealloc{
//   for (CategoryView *ac in listCategoryView) {
//       [ac removeFromSuperview];
//       [ac release];
//   }
//    [listCategoryView removeAllObjects];
    [listCategoryView release];    
    [listCategory release];
    [indexPath release];
    [super dealloc];

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//判断手势方向
- (void)judgeOrientation:(CGPoint)currentTouchPosition{
    if (fabsf(startTouchPosition.x - currentTouchPosition.x) >=fabsf(startTouchPosition.y - currentTouchPosition.y) )
    {
        // It appears to be a swipe.
        if (startTouchPosition.x < currentTouchPosition.x)
        {
            orientation=2;
        }
        else{
            orientation=4;
        }
    }
    else
    {
        if (startTouchPosition.y< currentTouchPosition.y){
            orientation=3;
        }
        else{
            orientation=1;
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    if([allTouches count]>1)return;
    isVerticalMoved=NO;
//    UITouch *touch = [touches anyObject];
    startTouchPosition = [touch locationInView:self.view];
//    [currentCategoryView setIsVerticalMoved:YES];
    for (id fvid in currentCategoryView.listFoodView) {
        FoodView * foodView=(FoodView *)fvid;
        [foodView setStartPoint:foodView.frame.origin];
    }
    NSLog(@"%d",[allTouches count]);
    for (CategoryView *aCategoryView in listCategoryView) {
        [aCategoryView setStartMyPoint:aCategoryView.frame.origin];
    }    
    
    [currentCategoryView setStartMyPoint:currentCategoryView.frame.origin];
    touchCategoryView=(CategoryView *)[touch view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [touches anyObject];
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    if([allTouches count]>1)return;
    CGPoint currentTouchPosition = [touch locationInView:self.view];
    if (orientation==0) {
        [self judgeOrientation:currentTouchPosition];
        return;
    }
//    CategoryView *aCategoryView =currentCategoryView;//(CategoryView *)[self.view.subviews objectAtIndex:0];
    if (orientation==2||orientation==4) {
        //横向滑动
        [self touchesCancelled:touches withEvent:event];
                 distance=currentTouchPosition.x-startTouchPosition.x;
        [currentCategoryView horizontalMoveView:distance];
    }
    else{
         distance=currentTouchPosition.y-startTouchPosition.y;
        if((!currentCategoryView.isVerticalMoved)&&!isVerticalMoved){
            for (CategoryView *aCategoryView in listCategoryView) {
                [aCategoryView setUserInteractionEnabled:NO];
            }  
        currentCategoryView= [currentCategoryView verticalMoverView:distance];
            }
        [self setTopLabel];
    }        

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"orientation=%d",orientation);
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint currentTouchPosition = [touch locationInView:self.view];
    if ((orientation==2||orientation==4)||currentCategoryView.isHorizontalMoved) {
         distance=currentTouchPosition.x-startTouchPosition.x;
    [currentCategoryView horizontalMoveNext:distance];
        currentCategoryView.isHorizontalMoved=NO;
    }
     distance=currentTouchPosition.y-startTouchPosition.y;
    NSLog(@"%@",isVerticalMoved?@"yes":@"no");
    if ((orientation==1||orientation==3)&&!isVerticalMoved&&!currentCategoryView.isVerticalMoved) {
        currentCategoryView= [currentCategoryView verticalMoverNext:distance];
        [currentCategoryView setTitleImage:YES];
        if([allTouches count]>1)return;
    }
    NSLog(@"endIndex=%d",currentCategoryView.tag);
    orientation=0;
    [self setTopLabel];
    if(currentCategoryView!=nil){
        [self ShowCategoryView:currentCategoryView.tag];
        [currentCategoryView ShowFoodView:currentCategoryView.currentFoodView.tag Animation:YES];
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)viewWillDisappear:(BOOL)animated{
    if ((orientation==2||orientation==4)||currentCategoryView.isHorizontalMoved) {
        [currentCategoryView horizontalMoveNext:distance];
        currentCategoryView.isHorizontalMoved=NO;
    }
    if ((orientation==1||orientation==3)&&!isVerticalMoved&&!currentCategoryView.isVerticalMoved) {
        currentCategoryView= [currentCategoryView verticalMoverNext:distance];
        [currentCategoryView setTitleImage:YES];
    }  
    orientation=0;
    if(currentCategoryView!=nil){
        [self ShowCategoryView:currentCategoryView.tag];
        [currentCategoryView ShowFoodView:currentCategoryView.currentFoodView.tag Animation:YES] ;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    if(currentCategoryView!=nil){
        [self ShowCategoryView:currentCategoryView.tag];
        [currentCategoryView ShowFoodView:currentCategoryView.currentFoodView.tag Animation:YES];
    }
}
-(void)animationDidStart:(CAAnimation *)anim{
    [super animationDidStart:anim];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if(flag)
    {
        isVerticalMoved=NO;
    [self.view setUserInteractionEnabled:YES];
    }

}
-(void)viewDidAppear:(BOOL)animated{

    
}
@end

