//
//  ZTAppDelegate.m
//  Diancan
//
//  Created by 李炜 on 12-2-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZTAppDelegate.h"

@implementation ZTAppDelegate


@synthesize window = _window;
@synthesize rootController;
@synthesize foodCount;
@synthesize orderList=_orderList;
@synthesize order;
@synthesize listCategory;
@synthesize deskID,deskName;
- (void)dealloc
{
    [_window release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
//    // Override point for customization after application launch.
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    foodCount=0;
    [self.window addSubview:rootController.view];
    [self.window makeKeyAndVisible]; 
    
  
    order=[[ZTOrder alloc] init];
    order.viewController=[[rootController viewControllers] objectAtIndex:1];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
//    [self saveContext];
}


/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

//-(void)addFood:(Category *)aCategory{
//    if (self.orderList==nil) {
//        self.orderList=[[[NSMutableArray alloc] init] autorelease];        
//    }
//    for (Category *category in self.orderList) {
//        if (aCategory==category) {
//            return;
//        }
//    }
//    [self.orderList addObject:aCategory];
//    NSLog(@"orderList=%d",[self.orderList count]);    
//}

//-(void)countPrice{
//    int indexICareAbout = 1; 
//    CGFloat count=0;
//    for (Category *category in self.orderList) {
//        for (Recipe *recipe in category.recipeList) {
//            count=count+[recipe.rPrice floatValue]*(CGFloat)(recipe.count);
//        }
//    }
//    NSString *badgeValue = [NSString stringWithFormat:@"(%d)￥%.0f",self.foodCount,count];  
//    [[[[self.rootController viewControllers] objectAtIndex: indexICareAbout] tabBarItem] setBadgeValue:badgeValue];
//    if (self.foodCount==0) {
//        [[[[self.rootController viewControllers] objectAtIndex: 1] tabBarItem] setBadgeValue:nil];
//        
//    }
//}

//-(NSMutableArray *)orderList{
//    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"cID" ascending:YES] autorelease];
//    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
//    [_orderList sortUsingDescriptors:sortDescriptors];
//
//                    return _orderList;
//}
@end
