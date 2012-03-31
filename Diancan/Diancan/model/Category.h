//
//  Category.h
//  Diancan
//
//  Created by 李炜 on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CategoryImage, Recipe;

@interface Category : NSManagedObject
@property(nonatomic,retain)NSMutableArray *orderList;

@property (nonatomic, retain) NSString * cDescription;
@property (nonatomic, retain) NSNumber * cID;
@property (nonatomic, retain) NSString * cImageURL;
@property (nonatomic, retain) NSString * cName;
@property (nonatomic, retain) CategoryImage *image;
@property (nonatomic, retain) NSSet *recipeList;
@end

@interface Category (CoreDataGeneratedAccessors)

- (void)addRecipeListObject:(Recipe *)value;
- (void)removeRecipeListObject:(Recipe *)value;
- (void)addRecipeList:(NSSet *)values;
- (void)removeRecipeList:(NSSet *)values;

@end
