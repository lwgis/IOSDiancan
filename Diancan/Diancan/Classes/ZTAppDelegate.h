//
//  ZTAppDelegate.h
//  Diancan
//
//  Created by 李炜 on 12-2-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RestEngine.h"
#define ApplicationDelegate ((ZTAppDelegate *)[UIApplication sharedApplication].delegate)

@interface ZTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;
@property int foodCount;
//@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (retain,nonatomic)NSMutableArray *orderList;
@property (strong, nonatomic) RestEngine *restEngine;
-(void)saveContext;
//-(void)addFood:(Category *)aCategory;
//-(void)countPrice;
-(NSURL *)applicationDocumentsDirectory;

@end
