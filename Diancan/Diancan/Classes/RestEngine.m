//
//  RestEngine.m
//  testCoreData
//
//  Created by 赵飞 on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RestEngine.h"

#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "AFImageRequestOperation.h"

#import "ZTCategory.h"
#import "ZTRecipe.h"
#import "ZTDesk.h"

@implementation RestEngine

- (void) dealloc
{
    [super dealloc];
}

- (void)getAllCategoriesOnCompletion:(AllCategoriesCompletionBlock)completeBlock onError:(ErrorBlock)errorBlock
{       
    NSURL *url = [NSURL URLWithString:ALL_CATEGORY_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        NSLog(@"所有种类:%@",JSON);
        NSMutableArray *array = [NSMutableArray array];   

        for (NSDictionary *dic in JSON) {
            ZTCategory *c = [[ZTCategory alloc] init];
            [c setCID:[NSNumber numberWithInteger:[[dic objectForKey:@"id"] integerValue]]];
            [c setCName:[dic objectForKey:@"name"]];
            [c setCDescription:[dic objectForKey:@"description"]];
            [c setCImageURL:[dic objectForKey:@"image"]];
            [array addObject:c];
            [c release];
        }
        completeBlock(array); 
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        errorBlock(error);
    }];
    
    [operation start];
}

- (void)getRecipesByCategory:(NSInteger)cid OnCompletion:(AllRecipesCompletionBlock)completeBlock onError:(ErrorBlock)errorBlock
{
    NSURL *url = [NSURL URLWithString:RECIPE_BY_CATEGORY_URL(cid)];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        NSLog(@"种类菜单:%@",JSON);
        NSMutableArray *array = [NSMutableArray array];   
        for (NSDictionary *dic in JSON) {
            ZTRecipe *recipe = [[ZTRecipe alloc] init];
            [recipe setRID:[NSNumber numberWithInteger:[[dic objectForKey:@"id"] integerValue]]];
            [recipe setRName:[dic objectForKey:@"name"]];
            [recipe setRPrice:[NSNumber numberWithDouble:[[dic objectForKey:@"price"] doubleValue]]];
            [recipe setRImageURL:[dic objectForKey:@"image"]];
            [recipe setCID:[NSNumber numberWithInteger:[[dic objectForKey:@"cid"] integerValue]]];
            [recipe setRDescription:[dic objectForKey:@"description"]];
            [array addObject:recipe];
            [recipe release];
        }
        completeBlock(array);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        errorBlock(error);
    }];
    
    [operation start];
}

- (void)getAllDesksOnCompletion:(AllCategoriesCompletionBlock)completeBlock onError:(ErrorBlock)errorBlock
{
    NSURL *url = [NSURL URLWithString:ALL_DESK_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        NSLog(@"所有桌子:%@",JSON);
        NSMutableArray *array = [NSMutableArray array];   
        
        for (NSDictionary *dic in JSON) {
            ZTDesk *c = [[ZTDesk alloc] init];            
            [c setDID:[NSNumber numberWithInteger:[[dic objectForKey:@"id"] integerValue]]];
            [c setDName:[dic objectForKey:@"name"]];
            [c setDCapacity: [NSNumber numberWithInteger:[[dic objectForKey:@"capacity"] integerValue]]];
            [array addObject:c];
            [c release];
        }
        completeBlock(array); 
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        errorBlock(error);
    }];
    
    [operation start];
}

- (void) getImage:(NSString *)urlStr OnCompletion:(ImageDownloadResponseBlock)completeBlock onError:(ErrorBlock)errorBlock
{
    NSURL *url = [NSURL URLWithString:IMAGE_URL(urlStr)];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    
//    AFImageRequestOperation *ooo = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:^UIImage *(UIImage *) {
//        
//    } cacheName:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//        
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        
//    }];
    
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image) {
//        NSLog(@"获取图片成功");
        completeBlock(image);
    }];
    
    [operation start];
}

- (void) submitOrder:(NSMutableDictionary *)order OnCompletion :(SubmitOrderResponseBlock)completeBlock onError:(ErrorBlock)errorBlock{    
    NSURL *url = [NSURL URLWithString:REQUEST_HOST];
    AFHTTPClient *httpClient = [[[AFHTTPClient alloc] initWithBaseURL:url] autorelease];
    
//    NSLog(@"%@",order);
    
    NSMutableArray *recipes = [NSMutableArray array];
    NSArray *array = [order valueForKey:@"recipes"];
    for (NSDictionary *d in array) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        ZTRecipe *r = [d valueForKey:@"recipe"];
        [dic setValue:r.rID forKey:@"rid"];
        [dic setValue:[d valueForKey:@"count"] forKey:@"count"];
        [recipes addObject:dic];
    }
    
    NSMutableDictionary *body = [NSMutableDictionary dictionary]; 
    [body setValue:[order valueForKey:@"tid"] forKey:@"tid"];
    [body setValue:[order valueForKey:@"number"] forKey:@"number"];
    [body setValue:recipes forKey:@"recipes"];
    
//    NSLog(@"%@",body);
    
    httpClient.parameterEncoding = AFJSONParameterEncoding;

    [httpClient postPath:SUBMIT_ORDER_URL parameters:body
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSInteger statusCode = operation.response.statusCode;
                     assert(statusCode == 201);
                     NSString *orderURL =[NSString stringWithFormat:@"%@", [operation.response.allHeaderFields objectForKey:@"Location"]];
                     completeBlock(orderURL);
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     errorBlock(error);
                 }];
}

- (void) getOrderDetail:(NSInteger)oid OnCompletion:(OrderDetailCompletionBlock) completeBlock onError:(ErrorBlock) errorBlock
{
    NSURL *url = [NSURL URLWithString:ORDER_DETAIL_URL(oid)];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"订单详情:%@",JSON);
        completeBlock(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        errorBlock(error);
    }];
    
    [operation start];
}

@end
