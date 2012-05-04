//
//  SelectDeskController.h
//  Diancan
//
//  Created by 李炜 on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectDeskController : UIViewController<UITableViewDataSource, UITableViewDelegate>
-(void)refreshData;
@property(nonatomic,retain)NSArray * listDesk;
@property(nonatomic,assign)UITableView *deskTableView;
@end
