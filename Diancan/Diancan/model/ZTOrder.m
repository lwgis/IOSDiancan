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
    NSMutableDictionary *body = [NSMutableDictionary dictionary]; 
    [body setValue:@"11" forKey:@"tid"];
    [body setValue:@"4" forKey:@"number"];
    [body setValue:recipes forKey:@"recipes"];
    
    [[RestEngine sharedEngine] submitOrder:body OnCompletion:^(NSString *orderURL) {
        NSLog(@"提交订单成功:%@",orderURL);
    } onError:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
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
            [aDic setValue:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
            return;
        }
    }
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setValue: recipe forKey:@"recipe"];
    [dic setValue:@"1" forKey:@"count"];
    [recipes addObject:dic];
    [dic release];
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
-(NSMutableArray *)getRecipes{
    return recipes;
}
-(NSArray *)getCategoryName{
    if (recipes==nil||[recipes count]==0) {
        return nil;
    }
    NSMutableArray *categorys=[[NSMutableArray alloc] init];
    for (ZTRecipe *recipe in recipes) {
//        if(![categorys containsObject:recipe.cName]){
//            [categorys addObject:recipe.cName];
//        }
        NSLog(@"%@",recipe.cName);
    }
    return categorys;
}
@end
