//
//  MainMenuController.h
//  Diancan
//
//  Created by 李炜 on 12-2-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FoodCell.h"
@interface MainMenuController :UITableViewController<UITableViewDataSource, UITableViewDelegate,NSFetchedResultsControllerDelegate>
@property (nonatomic, retain) NSDictionary *names;
@property (nonatomic, retain) NSArray *keys;
@property (nonatomic,retain) FoodCell *focusCell;
@property (nonatomic,retain) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
