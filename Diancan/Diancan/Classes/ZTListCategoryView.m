//
//  ZTListCategoryView.m
//  Diancan
//
//  Created by 李炜 on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZTListCategoryView.h"
#import "CategoryView.h"
@implementation ZTListCategoryView
-(void)addObject:(id)anObject{
    [self addObject:anObject];
    if ([super count]>1) {
        CategoryView *preCategoryView=[self objectAtIndex:([self count]-1)];
        CategoryView *aCategoryView=(CategoryView *) anObject;
        preCategoryView.behindCategoryView=aCategoryView;
        aCategoryView.previousCategoryView=preCategoryView;
    }

}
-(void)insertObject:(id)anObject atIndex:(NSUInteger)index
{
    [super insertObject:anObject atIndex:index];
}
-(void)removeObjectAtIndex:(NSUInteger)index{
    [super removeObjectAtIndex:index];
}
-(void)removeLastObject{
    [super removeLastObject];
}
-(void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    [super replaceObjectAtIndex:index withObject:anObject];
}
-(NSUInteger)count{
    return [super count];
}
-(id)objectAtIndex:(NSUInteger)index
{
    return [super objectAtIndex:index];
}
@end
