//
//  FoodInfoController.h
//  Diancan
//
//  Created by 李炜 on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodCell.h"
@interface FoodInfoController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (retain,nonatomic) IBOutlet UIImageView *foodImage;
@property(retain ,nonatomic) FoodCell *foodcell;
@end
