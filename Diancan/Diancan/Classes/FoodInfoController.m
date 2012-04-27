//
//  FoodInfoController.m
//  Diancan
//
//  Created by 李炜 on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FoodInfoController.h"
#import <QuartzCore/QuartzCore.h>
#import "FoodInfoView.h"
#import "ZTCategory.h"
#import "TitleView.h"
@implementation FoodInfoController
{
    BOOL isChanged;
    NSInteger showIndex;
}
@synthesize gestureRecognizer,listRecipe,listFoodInfoView,categoryBtn,categoryDailog,currenFoodInfoView,orderButtonItem;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        gestureRecognizer=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
        gestureRecognizer.delegate = self;
        gestureRecognizer.maximumNumberOfTouches = 1;
        gestureRecognizer.minimumNumberOfTouches = 1;
        [self.view addGestureRecognizer:gestureRecognizer];
    }
    return self;
}
-(void)showFoodInfo:(NSInteger)index{
    showIndex=index;
}

- (void)panned:(UIPanGestureRecognizer *)recognizer
{
    switch (recognizer.state) {
        case UIGestureRecognizerStatePossible:
            isChanged=NO;
            break;
            //        case UIGestureRecognizerStateRecognized: // for discrete recognizers
            //            break;
        case UIGestureRecognizerStateFailed: // cannot recognize for multi touch sequence
            break;
        case UIGestureRecognizerStateBegan: {
            // allow controlled flip only when touch begins within the pan region
           
     
        }
            break;
        case UIGestureRecognizerStateChanged:{            
            float value = [recognizer translationInView:self.view].y;
            if (value<-10&&!isChanged) {
                [UIView beginAnimations:@"animationID" context:nil];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDuration:0.7f];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationRepeatAutoreverses:NO];
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
                if([self.view.subviews count]>0){
                FoodInfoView *currentView=[self.view.subviews objectAtIndex:[self.view.subviews count]-1];
                    if(self.view.subviews.count>1)
                    self.currenFoodInfoView=[self.view.subviews objectAtIndex:[self.view.subviews count]-2];
                [currentView removeFromSuperview];
                }
                [UIView commitAnimations];
                isChanged=YES;
                if (self.categoryDailog!=nil) {
                    [self.categoryDailog  removeFromSuperview];
                    self.categoryDailog=nil;
                }
            }
            if (value>10&&!isChanged&&[self.view.subviews count]!=[self.listFoodInfoView count]) {
                [UIView beginAnimations:@"animationID" context:nil];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDuration:0.7f];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationRepeatAutoreverses:NO];
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
                FoodInfoView *currentView=[self.listFoodInfoView objectAtIndex:[self.view.subviews count]];
                self.currenFoodInfoView=currentView;
                [self.view addSubview:currentView];
                [UIView commitAnimations];
                isChanged=YES;
                if (self.categoryDailog!=nil) {
                    [self.categoryDailog  removeFromSuperview];
                    self.categoryDailog=nil;
                }
            }
        }break;
        case UIGestureRecognizerStateCancelled: // cancellation touch
            break;
        case UIGestureRecognizerStateEnded: {
            isChanged=NO;
        }
            break;
        default:
            break;
    }
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
    // Do any additional setup after loading the view from its nib.
    //创建一个右边按钮
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]  initWithTitle:@"点"   
                                                                     style:UIBarButtonItemStyleBordered   
                                                                    target:self   
                                                                    action:@selector(rightButtonClick)];  
    [self setOrderButtonItem:rightButton];
    [self.navigationItem setRightBarButtonItem:rightButton];    
    [rightButton release];
    TitleView *aTitleView=[[TitleView alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    [self setCategoryBtn:aTitleView];
    [self.categoryBtn addTarget:self action:@selector(categoryBtnClick) forControlEvents:UIControlEventTouchUpInside];

//    categoryBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    categoryBtn.backgroundColor=[UIColor redColor];
//    [categoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [categoryBtn addTarget:self action:@selector(categoryBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [categoryBtn setFrame:CGRectMake(0, 0, 150, 40)];
//    [categoryBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.navigationItem setTitleView:aTitleView];
    [aTitleView release];
    self.listFoodInfoView=[[NSMutableArray alloc] init];
    listRecipe=[[NSMutableArray alloc] init];
}
-(void)rightButtonClick{
    if (self.currenFoodInfoView.isCheck) {
        return;
    }
    UIImageView *animationImageView= [[UIImageView alloc] initWithFrame:                            
                            CGRectMake(1110.0f, 100.0f, 50.0f, 50.0f)];      
    [animationImageView setImage:self.currenFoodInfoView.foodImageView.image];        
    [self.view addSubview:animationImageView];
    CGMutablePathRef thePath =  CGPathCreateMutable();
    CGPathMoveToPoint(thePath, NULL, 0, 200);
    CGPathAddLineToPoint(thePath, NULL, 40, 140);
    CGPathAddLineToPoint(thePath, NULL, 80, 140);
    CGPathAddLineToPoint(thePath, NULL, 120, 200);
    CGPathAddLineToPoint(thePath, NULL, 160, 420);
    CAKeyframeAnimation *theAnimation =[CAKeyframeAnimation animationWithKeyPath:@"position"];
    theAnimation.path=thePath;
    theAnimation.duration=0.4;
    theAnimation.repeatCount = 1; // 无线循环
    theAnimation.autoreverses=NO;
    theAnimation.cumulative=YES;
    theAnimation.delegate=self;
    [animationImageView.layer addAnimation:theAnimation forKey:@"animateLayer"]; // 添加动画。
    CFRelease(thePath);    
    [animationImageView release];
    
}
-(void)categoryBtnClick{
    if (self.categoryDailog==nil) {
       CategoryDailog *aCd=[[CategoryDailog alloc] initWithFrame:CGRectMake(50, -300, 220, 200)];
        [aCd showDialog:self.categoryBtn.titleLabel.text];
//        [aCd setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:aCd];
        [self setCategoryDailog:aCd];
        [aCd release];
    }
    [UIView beginAnimations:@"dialog" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5f];
    [self.categoryDailog setFrame:CGRectMake(50, 0, 220, 200)];
    [UIView commitAnimations];
}
-(void)selectCategoryClick:(UIButton *)sender{
    [self.listRecipe removeAllObjects];
    [listRecipe release];
    for (UIView *aView in listFoodInfoView) {
        [aView removeFromSuperview];
    }
    [self.listFoodInfoView removeAllObjects];
    [listFoodInfoView release];
    ZTCategory *aCategory=[ApplicationDelegate.listCategory objectAtIndex:sender.tag];
    [self setListRecipeData:[aCategory.cID integerValue]];
    showIndex=0;
}
-(void)setListRecipeData:(NSInteger)categoryID{ 
    [self.orderButtonItem setEnabled:NO];
    [[RestEngine sharedEngine] getRecipesByCategory:categoryID OnCompletion:^(NSArray *list) {
        listRecipe=[[NSMutableArray alloc] init];
        listFoodInfoView=[[NSMutableArray alloc] init];
        NSInteger i=0;
        for (ZTRecipe *recipe in list) {
            FoodInfoView *foodInfoView=[[FoodInfoView alloc] initWithFrame:CGRectMake(0, 0, 320, 390)];
            [foodInfoView setTag:list.count-i-1];
            [foodInfoView loadRepiceImage:recipe];
            [foodInfoView.foodNameLabel setText:recipe.rName];
            NSString *price=[NSString stringWithFormat:@"￥%.2f",[recipe.rPrice floatValue]];
            [foodInfoView.foodPriceLable setText:price];
            NSString *num=[NSString stringWithFormat:@"%d/%d",i+1,[list count]];
            [foodInfoView.foodNum setText:num];
            [listFoodInfoView insertObject:foodInfoView atIndex:0];
            [self.view insertSubview:foodInfoView atIndex:0];
            [self.listRecipe insertObject:recipe atIndex:0];
            [foodInfoView release];  
            i++;
        }
        NSInteger index=[self.view.subviews count]-showIndex;
        if (self.listFoodInfoView.count!=self.view.subviews.count) {
            index-=1;
        }
        while([self.view.subviews count]>index) {
            FoodInfoView *currentView=[self.view.subviews objectAtIndex:[self.view.subviews count]-1];
            [currentView removeFromSuperview];    
        }
        self.currenFoodInfoView=[self.listFoodInfoView objectAtIndex:index-1];
        if ([list count]>0) {
            ZTRecipe *aRecipe =[list objectAtIndex:0];
            NSString *categoryName=[NSString stringWithFormat:@"%@",aRecipe.cName];
            [categoryBtn setTitle:categoryName forState:UIControlStateNormal];
        }
        [self.categoryDailog removeFromSuperview];
        self.categoryDailog=nil;
        [self refreshData];
        [self.orderButtonItem setEnabled:YES];
        [self.categoryBtn sizeToFit];
    } onError:^(NSError *error) {
    }];

//    [self setListRecipe:(NSMutableArray *)aListRecipe];
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

- (void)dealloc {
    [listRecipe removeAllObjects];
    [listRecipe release];
    for (UIView *aView in listFoodInfoView) {
        [aView removeFromSuperview];
    }
    [listFoodInfoView removeAllObjects];
    [listFoodInfoView release];
    [categoryBtn removeFromSuperview];
    [super dealloc];
}
-(void)refreshData{
    for (NSInteger i=0;i<self.listRecipe.count; i++) {
        ZTRecipe *aRecipe=[self.listRecipe objectAtIndex:i];
        if ([ApplicationDelegate.order getRecipeCount:aRecipe]>0) {
            FoodInfoView *aFoodInfoView=[self.listFoodInfoView objectAtIndex:i];
            [aFoodInfoView markByImage:YES Animation:NO];
            [aFoodInfoView setIsCheck:YES];
        }
        else{
            FoodInfoView *aFoodInfoView=[self.listFoodInfoView objectAtIndex:i];
            [aFoodInfoView markByImage:NO Animation:NO];
            [aFoodInfoView setIsCheck:NO];
        }
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self refreshData];
}
   -(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{    
    NSLog(@"%@",anim.description);
    if ([self.view.subviews count]==0) {
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:0.7f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    FoodInfoView *currentView=[self.listFoodInfoView objectAtIndex:0];
    [self.view addSubview:currentView];
    [UIView commitAnimations];
    }
    if (categoryDailog!=nil&&categoryDailog.frame.origin.y<0) {
        [self.categoryDailog removeFromSuperview];
        self.categoryDailog = nil;
    }
    if ([anim isKindOfClass:[CAKeyframeAnimation class]]) {
        [self.currenFoodInfoView markByImage:YES Animation:YES];
        ZTRecipe *aRecipe=[listRecipe objectAtIndex:self.currenFoodInfoView.tag];
        [ApplicationDelegate.order addRecipe:aRecipe];
        UIView *aView=[self.view.subviews objectAtIndex:self.view.subviews.count -1];
        if ([aView isKindOfClass:[UIImageView class]]) {
            [aView removeFromSuperview];
        }

//        for (UIView *aView in self.view.subviews) {
//            if ([aView isKindOfClass:[UIImageView class]]) {
//                [aView removeFromSuperview];
//            }
//        }
    }
    [self.orderButtonItem setEnabled:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.categoryDailog!=nil&&categoryDailog.frame.origin.y>=0){
        [UIView beginAnimations:@"dialog" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5f];
        [self.categoryDailog setFrame:CGRectMake(50, -300, 220, 200)];
        [UIView commitAnimations];      
    }
}

@end
