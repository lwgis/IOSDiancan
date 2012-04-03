//
//  LeftListView.h
//  Diancan
//
//  Created by 李炜 on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTCategory.h"
#import "ZTRightListView.h"
@interface ZTLeftListView : UIScrollView
{
    NSMutableArray *listButton;
}
@property(nonatomic,retain) NSArray *listCategory;
@property(nonatomic,retain)ZTRightListView *ztRightListView;
-(void)loadCategory;
@end
