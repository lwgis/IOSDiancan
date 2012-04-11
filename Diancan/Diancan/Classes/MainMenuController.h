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
#import "CategoryView.h"
#import "ZTUIView.h"
@interface MainMenuController :UIViewController<NSFetchedResultsControllerDelegate>
{
 
}
@property  BOOL isVerticalMoved;
@property(nonatomic,retain) NSArray *listCategory;
@property(nonatomic,retain)  NSMutableArray *listCategoryView;
@property(nonatomic,retain)NSIndexPath *indexPath;
-(void)ShowCategoryViewFromSuper:(NSIndexPath *)index;
@end
