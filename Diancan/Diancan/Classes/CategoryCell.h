//
//  CategoryCell.h
//  Diancan
//
//  Created by 李炜 on 12-4-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCell : UIView
@property(nonatomic,assign)CategoryCell *nextCategoryCell;
@property(nonatomic,assign)CategoryCell *preCategoryCell;
-(void)setText:(NSString *)cName;
@end
