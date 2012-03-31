//
//  Category.h
//  Diancan
//
//  Created by 李炜 on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTCategory : NSObject
typedef void(^getCategoryImageBlock)(UIImage *image);
@property (nonatomic, retain) NSNumber * cID;
@property (nonatomic, retain) NSString * cImageURL;
@property (nonatomic, retain) NSString * cName;
@property (nonatomic, retain) NSString * cDescription;

@end


