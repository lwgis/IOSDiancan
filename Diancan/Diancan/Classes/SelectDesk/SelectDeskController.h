//
//  SelectDeskController.h
//  Diancan
//
//  Created by 李炜 on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectTitleDialog.h"
@interface SelectDeskController : UIViewController<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate,UISearchBarDelegate>
-(void)refreshData:(NSInteger)tID;
@property(nonatomic,retain)NSMutableArray * listDesk;
@property(nonatomic,retain)NSMutableArray *listDeskBack;
@property(nonatomic,assign)UITableView *deskTableView;
@property(nonatomic,retain)NSArray *listDeskType;
@property(nonatomic,assign)SelectTitleDialog *selectTitleDialog;
@property(nonatomic,assign)UIScrollView *thumbnailsView; 
@property(nonatomic,assign)UIButton *deskTypeButton;
@property(nonatomic,assign)UISearchBar *deskSearchBar;
@end
