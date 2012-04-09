//
//  ZTOrder.m
//  Diancan
//
//  Created by 李炜 on 12-4-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZTOrder.h"

@implementation ZTOrder{
    NSMutableArray *recipes;
    NSInteger allRecipeCount;
}
@synthesize viewController;
-(void)order{
}
-(void)addRecipe:(ZTRecipe *)recipe{
    if (recipes==nil) {
        recipes=[[NSMutableArray alloc] init];
    }
    allRecipeCount++;
    [[viewController tabBarItem] setBadgeValue:[NSString stringWithFormat:@"%d",allRecipeCount]];
    for (NSMutableDictionary *aDic in recipes) {
       ZTRecipe *aRecipe=(ZTRecipe *) [aDic valueForKey:@"recipe"];
        if ([recipe.rID isEqual:aRecipe.rID]) {
            NSString *countString=(NSString *)[aDic valueForKey:@"count"];
            NSInteger count=[countString integerValue];
            count++;
            NSLog(@"diange%d",count);
            [aDic setValue:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
            return;
        }
    }
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setValue: recipe forKey:@"recipe"];
    [dic setValue:@"1" forKey:@"count"];
    [recipes addObject:dic];
    [dic release];
    NSLog(@"zonggong%d",[recipes count]);
}
-(void)removeRecipe:(ZTRecipe *)recipe{
    NSInteger allCount=allRecipeCount-1;
    if(allCount<=0){
        allRecipeCount=0;
        [[viewController tabBarItem] setBadgeValue:nil];
    }
    else{
        allRecipeCount--;
        [[viewController tabBarItem] setBadgeValue:[NSString stringWithFormat:@"%d",allRecipeCount]];
    }
    for (NSMutableDictionary *aDic in recipes) {
        ZTRecipe *aRecipe=(ZTRecipe *) [aDic valueForKey:@"recipe"];
        if ([recipe.rID isEqual:aRecipe.rID]) {
            NSString *countString=(NSString *)[aDic valueForKey:@"count"];
            NSInteger count=[countString integerValue];
            count--;
            NSLog(@"diange%d",count);
            [aDic setValue:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
            if (count==0) {
                [recipes removeObject:aDic];
            }
            return;
        }
    }
}
-(NSInteger)getRecipeCount:(ZTRecipe *)recipe{
    for (NSMutableDictionary *aDic in recipes) {
        ZTRecipe *aRecipe=(ZTRecipe *) [aDic valueForKey:@"recipe"];
        if ([recipe.rID isEqual:aRecipe.rID]) {
            NSString *countString=(NSString *)[aDic valueForKey:@"count"];
            NSInteger count=[countString integerValue];
            return count;
        }
    }
    return 0;
}
-(void)release{
    [recipes removeAllObjects];
    [recipes release];
}
@end
