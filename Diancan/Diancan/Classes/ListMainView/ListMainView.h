//
//  ListMainView.h
//  Diancan
//
//  Created by 李炜 on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTLeftListView.h"
#import "ZTRightListView.h"
@interface ListMainView : UIView
@property(nonatomic,retain)ZTLeftListView *ztLeftListView;
@property(nonatomic,retain)ZTRightListView *ztRightListView;
@end
