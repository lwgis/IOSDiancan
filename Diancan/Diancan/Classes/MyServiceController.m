//
//  MyServiceController.m
//  Diancan
//
//  Created by 李炜 on 12-2-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyServiceController.h"

#import "ZTCategory.h"
#import "ZTDesk.h"
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
    [[RestEngine sharedEngine] getAllCategoriesOnCompletion:^(NSArray *array) {
        NSLog(@"所有种类获取成功");
    } onError:^(NSError *error) {
        NSLog(@"获取失败：%@",error);
    }];
}

- (IBAction)getRecipeByCategory:(id)sender 
{
    NSInteger cid = 45;
    [[RestEngine sharedEngine] getRecipesByCategory:cid OnCompletion:^(NSArray *list) {
        NSLog(@"种类菜单获取成功");
//        NSLog(@"%@",list);
    } onError:^(NSError *error) {
        NSLog(@"获取失败");
    }];
}

- (IBAction)getImageByURL:(id)sender 
{
//    NSString *imageURL = @"test1.jpg";
//    NSString *imageURL = @"test2.jpg";
//    NSString *imageURL = @"test5.jpg";

    NSString *imageURL = @"10e8efae-308b-4400-8612-0cff9d5679da.jpg";
    [[RestEngine sharedEngine] getImage:imageURL OnCompletion:^(UIImage *image) {
        NSLog(@"图片获取成功");
    [myImageView setImage:image];

    } onError:^(NSError *error) {
        NSLog(@"获取失败");
    }];
    
//    [myImageView setImageWithURL:[NSURL URLWithString:IMAGE_URL(imageURL)]];
}

- (IBAction)getAllDesk:(id)sender 
{
    [[RestEngine sharedEngine] getAllDesksOnCompletion:^(NSArray *array) {
        NSLog(@"所有桌子获取成功");
    } onError:^(NSError *error) {
        NSLog(@"获取失败：%@",error);
    }];
}

- (NSMutableDictionary *)getTestOrder
{
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
    return body;
}

- (IBAction)submitOrder:(id)sender 
{
    NSLog(@"提交订单");
    
    NSMutableDictionary *body = [self getTestOrder];
    
    [[RestEngine sharedEngine] submitOrder:body OnCompletion:^(NSString *orderURL) {
        NSLog(@"提交订单成功:%@",orderURL);
    } onError:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
    
}

- (IBAction)getOrderDetail:(id)sender
{
    [[RestEngine sharedEngine] getOrderDetail:2 OnCompletion:^(NSDictionary *orderURL) {
        NSLog(@"获取订单详情成功");
    } onError:^(NSError *error) {
        NSLog(@"获取失败：%@",error);
    }];
}

- (void)dealloc {
    [myImageView release];
    [super dealloc];
}
- (IBAction)serializationTest:(id)sender 
{
    NSString *serializationFile = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tempOrder"];
    NSMutableDictionary *body = [self getTestOrder];
    [body writeToFile:serializationFile atomically:YES];
    NSLog(@"序列化成功：%@",body);
}

- (IBAction)unserializationTest:(id)sender 
{
    NSString *serializationFile = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tempOrder"];
    
    NSMutableDictionary *body = [NSDictionary dictionaryWithContentsOfFile:serializationFile];
    NSLog(@"反序列化成功：%@",body);
}

- (IBAction)archiveTest:(id)sender 
{
    ZTDesk *c = [[ZTDesk alloc] init];
    [c setDID:[NSNumber numberWithInteger:45]];
    [c setDName:@"1号桌子"];
    [c setDCapacity: [NSNumber numberWithInteger:5]];
    
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"desk.archive"];
    BOOL result = [NSKeyedArchiver archiveRootObject:c
                                              toFile:file];
    [c release];
    NSLog(@"archive成功：%@",result ? @"YES" : @"NO");
}

- (IBAction)unarchiveTest:(id)sender 
{
     NSString *file = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"desk.archive"];
    
    ZTDesk *c = (ZTDesk *)[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    NSLog(@"unarchive成功：%@",c);
}
@end
