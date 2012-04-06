//
//  Recipe.h
//  Diancan
//
//  Created by 李炜 on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTRecipe : NSObject
typedef void(^getRecipeImageBlock)(UIImage *image);
@property (nonatomic, retain) NSNumber * cID;
@property (nonatomic, retain) NSString * rDescription;
@property (nonatomic, retain) NSNumber * rID;
@property (nonatomic, retain) NSString * rImageURL;
@property (nonatomic, retain) NSString * rName;
@property (nonatomic, retain) NSNumber * rPrice;
@property NSInteger count;
@property (nonatomic,retain)UIImage *rImage;
-(void)getRecipeImage:(getRecipeImageBlock) getRecipeImageBlock;
@end
