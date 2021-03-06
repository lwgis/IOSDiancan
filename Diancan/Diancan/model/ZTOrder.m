//
//  ZTOrder.m
//  Diancan
//
//  Created by 李炜 on 12-4-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZTOrder.h"
#import "RestEngine.h"
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
    
    [[RestEngine sharedEngine] submitOrder:body OnCompletion:^(NSDictionary *orderURL) {
        NSLog(@"提交订单成功:%@",orderURL);
    } onError:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}
-(void)addRecipe:(ZTRecipe *)recipe{
    if (recipes==nil) {
        recipes=[[NSMutableArray alloc] init];
    }
    NSLog(@"%d",ApplicationDelegate.deskID);
    NSMutableDictionary *body = [NSMutableDictionary dictionary]; 
    [body setValue:recipe.rID forKey:@"rid"];
    [body setValue:@"1" forKey:@"count"];    
    [[RestEngine sharedEngine] addRecipe:body ToOrder:ApplicationDelegate.deskID OnCompletion:^(NSDictionary *orderDetail) {
        NSLog(@"加减菜成功: %@", orderDetail);
    } onError:^(NSError *error) {
        NSLog(@"加减菜失败: %@", error);
    }];

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
    NSMutableDictionary *body = [NSMutableDictionary dictionary]; 
    [body setValue:recipe.rID forKey:@"rid"];
    [body setValue:@"-1" forKey:@"count"];    
    [[RestEngine sharedEngine] addRecipe:body ToOrder:ApplicationDelegate.deskID OnCompletion:^(NSDictionary *orderDetail) {
        NSLog(@"加减菜成功: %@", orderDetail);
    } onError:^(NSError *error) {
        NSLog(@"加减菜失败: %@", error);
    }];
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
-(CGFloat)getPrice{
    CGFloat price=0.0;
    for (NSMutableDictionary *aDic in recipes) {
        ZTRecipe *aRecipe=(ZTRecipe *) [aDic valueForKey:@"recipe"];
            NSString *countString=(NSString *)[aDic valueForKey:@"count"];
            NSInteger count=[countString integerValue];
        price=price+count*[aRecipe.rPrice floatValue];
    }
    return price;
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
    NSMutableArray *categorys=[[[NSMutableArray alloc] init] autorelease];
    for (NSMutableDictionary *aDic in recipes) {
        ZTRecipe *aRecipe=(ZTRecipe *) [aDic valueForKey:@"recipe"];
        if ([categorys containsObject:aRecipe.cName]==NO) {
            [categorys addObject:aRecipe.cName];
        }
    }
    return categorys;
}
@end
