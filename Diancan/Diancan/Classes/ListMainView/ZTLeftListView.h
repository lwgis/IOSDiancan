//
//  LeftListView.h
//  Diancan
//
//  Created by 李炜 on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTCategory.h"
@interface ZTLeftListView : UIView
@property(nonatomic,retain) NSArray *listCategory;
-(void)loadCategory;
@end
