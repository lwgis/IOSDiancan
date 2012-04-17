//
//  ZTAppDelegate.h
//  Diancan
//
//  Created by 李炜 on 12-2-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ZTOrder.h"
#define ApplicationDelegate ((ZTAppDelegate *)[UIApplication sharedApplication].delegate)

@interface ZTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;
@property int foodCount;
@property (retain,nonatomic)NSMutableArray *orderList;
@property (retain,nonatomic)ZTOrder *order;

//-(void)addFood:(Category *)aCategory;
//-(void)countPrice;
-(NSURL *)applicationDocumentsDirectory;

@end
