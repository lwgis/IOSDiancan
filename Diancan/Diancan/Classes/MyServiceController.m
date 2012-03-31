//
//  MyServiceController.m
//  Diancan
//
//  Created by 李炜 on 12-2-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyServiceController.h"

#import "ZTCategory.h"

#import "SDURLCache.h"

#import "UIImageView+AFNetworking.h"

@implementation MyServiceController
@synthesize myImageView;

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
}

- (void)viewDidUnload
{
    [self setMyImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)updateData:(id)sender 
{
    [ApplicationDelegate.restEngine getAllCategoriesOnCompletion:^(NSArray *array) {
        NSLog(@"所有种类获取成功");
    } onError:^(NSError *error) {
        NSLog(@"获取失败：%@",error);
    }];
}

- (IBAction)getRecipeByCategory:(id)sender 
{
    NSInteger cid = 45;
    [ApplicationDelegate.restEngine getRecipesByCategory:cid OnCompletion:^(NSArray *list) {
        NSLog(@"种类菜单获取成功");
    } onError:^(NSError *error) {
        NSLog(@"获取失败");
    }];
}

- (IBAction)getImageByURL:(id)sender 
{
//    NSString *imageURL = @"test1.jpg";
//    NSString *imageURL = @"test2.jpg";
    NSString *imageURL = @"test5.jpg";
//
////    NSString *imageURL = @"10e8efae-308b-4400-8612-0cff9d5679da.png";
//    [ApplicationDelegate.restEngine getImage:imageURL OnCompletion:^(UIImage *image) {
//        NSLog(@"图片获取成功");
//    } onError:^(NSError *error) {
//        NSLog(@"获取失败");
//    }];
    
    [myImageView setImageWithURL:[NSURL URLWithString:IMAGE_URL(imageURL)]];
}

- (IBAction)getAllDesk:(id)sender 
{
    [ApplicationDelegate.restEngine getAllDesksOnCompletion:^(NSArray *array) {
        NSLog(@"所有桌子获取成功");
    } onError:^(NSError *error) {
        NSLog(@"获取失败：%@",error);
    }];
}

- (IBAction)submitOrder:(id)sender 
{
    NSLog(@"提交订单");
    
    NSMutableArray *recipes = [NSMutableArray array];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"279" forKey:@"rid"];
    [dic setValue:@"1" forKey:@"count"];
    [recipes addObject:dic];
    
    dic = [NSMutableDictionary dictionary];
    [dic setValue:@"280" forKey:@"rid"];
    [dic setValue:@"2" forKey:@"count"];
    [recipes addObject:dic];
    
    dic = [NSMutableDictionary dictionary];
    [dic setValue:@"281" forKey:@"rid"];
    [dic setValue:@"1" forKey:@"count"];
    [recipes addObject:dic];
    
    NSMutableDictionary *body = [NSMutableDictionary dictionary]; 
    [body setValue:@"11" forKey:@"tid"];
    [body setValue:@"4" forKey:@"number"];
    [body setValue:recipes forKey:@"recipes"];
    
    [ApplicationDelegate.restEngine submitOrder:body OnCompletion:^(NSString *orderURL) {
        NSLog(@"提交订单成功:%@",orderURL);
    } onError:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

- (IBAction)getOrderDetail:(id)sender
{
    [ApplicationDelegate.restEngine getOrderDetail:2 OnCompletion:^(NSDictionary *orderURL) {
        NSLog(@"获取订单详情成功");
    } onError:^(NSError *error) {
        NSLog(@"获取失败：%@",error);
    }];
}

- (void)dealloc {
    [myImageView release];
    [super dealloc];
}
@end
