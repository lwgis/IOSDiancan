//
//  FoodCell.h
//  Diancan
//
//  Created by 李炜 on 12-2-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTRecipe.h"
@interface FoodCell : UITableViewCell
{
@private UILabel *countLabel;
}
-(void)addFoodCount;
-(void) setCountLabelText:(NSString *)count;
@property int foodCount;
@property(nonatomic,retain) ZTRecipe *ztmenu;
@end
