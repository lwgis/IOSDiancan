//
//  FoodInfoController.m
//  Diancan
//
//  Created by 李炜 on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FoodInfoController.h"
#import <QuartzCore/QuartzCore.h>
#import "FoodCell.h"
#import "ZTAppDelegate.h"
@implementation FoodInfoController
@synthesize foodNameLabel;
@synthesize foodImage;
@synthesize foodcell;
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
    // Do any additional setup after loading the view from its nib.
    //创建一个右边按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]  initWithTitle:@"点"   
                                                                     style:UIBarButtonItemStyleBordered   
                                                                    target:self   
                                                                    action:@selector(clickRightButton)];  
    [self.navigationItem setRightBarButtonItem:rightButton];
    [rightButton release];
//    foodCount=0;
    
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
    [foodNameLabel release];
    [super dealloc];
}

-(void)clickRightButton
{
    
    //定义图片的位置和尺寸,位置:x=268.0f, y=115.0f ,尺寸:x=20.0f, y=20.0f
    
    UIImageView *subview = [[UIImageView alloc] initWithFrame:                            
                            CGRectMake(1110.0f, 100.0f, 30.0f, 30.0f)];   
    
    //设定图片名称,myPic.png已经存在，拖放添加图片文件到image项目文件夹中
//    [subview setImage:foodcell.ztmenu.image.];    
//    //启用动画移动
//    [UIImageView beginAnimations:nil context:NULL];    
//    //移动时间2秒
//    [UIImageView setAnimationDuration:2];    
//    //图片持续移动
//    [UIImageView setAnimationBeginsFromCurrentState:YES];   
//    //重新定义图片的位置和尺寸,位置
//    subview.frame = CGRectMake(80.0, 300.0,50.0, 50.0);    
//    subview.animationRepeatCount=1;
//    //完成动画移动
//    [UIImageView commitAnimations];  
//    //在 View 中加入图片 subview 
    
    [self.view addSubview:subview];
    CGMutablePathRef thePath =  CGPathCreateMutable();
//   CGRect bound1 = CGRectMake(110.0f, 100.0f, 30.0f, 30.0f);
//    CGRect bounds = CGRectMake(210.0f, 150.0f, 30.0f, 30.0f);
    CGPathMoveToPoint(thePath, NULL, 0, 200);
    CGPathAddLineToPoint(thePath, NULL, 40, 140);
    CGPathAddLineToPoint(thePath, NULL, 80, 140);
    CGPathAddLineToPoint(thePath, NULL, 120, 200);
    CGPathAddLineToPoint(thePath, NULL, 160, 420);
//	CGPathAddQuadCurveToPoint(thePath, NULL, 10, 450, 310, 450);
//	CGPathAddQuadCurveToPoint(thePath, NULL, 310, 10, 10, 10);
//    CGPathAddLineToPoint(thePath, NULL, 110.0f, 100.0f);
//    CGPathAddLineToPoint(thePath, NULL, 210.0f, 150.0f);
    CAKeyframeAnimation *theAnimation =[CAKeyframeAnimation animationWithKeyPath:@"position"];
    theAnimation.path=thePath;
    theAnimation.duration=0.4;
    theAnimation.repeatCount = 1; // 无线循环
    theAnimation.autoreverses=NO;
    theAnimation.cumulative=YES;
    theAnimation.delegate=self;
    [subview.layer addAnimation:theAnimation forKey:@"animateLayer"]; // 添加动画。
    CFRelease(thePath);
    [foodcell addFoodCount];
    [subview release];
//    [NSThread sleepForTimeInterval:1];
       

    
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    ZTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    int indexICareAbout = 1; 
    NSString *badgeValue = [NSString stringWithFormat:@"%d",appDelegate.foodCount];  
    [[[[[self tabBarController] viewControllers] objectAtIndex: indexICareAbout] tabBarItem] setBadgeValue:badgeValue];
    
}


@end
