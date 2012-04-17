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
#import "AFNetworkActivityIndicatorManager.h"

#import "SDURLCache.h"

#import "ZTCategory.h"
#import "ZTRecipe.h"
#import "ZTDesk.h"

@implementation RestEngine

+ (RestEngine *)sharedEngine
{
    static RestEngine *engine = nil;
    if(!engine){
        engine = [[super allocWithZone:nil] init];
    }
    return engine;
}

//+ (id)allocWithZone:(NSZone *)zone
//{
//    return [self sharedEngine];
//}

- (id)init
{
    self = [super init];
    if(self){
        //自定义缓存
        SDURLCache *urlCache = [[SDURLCache alloc] initWithMemoryCapacity:1024*1024*5   // 1MB mem cache
                                                             diskCapacity:1024*1024*80 // 5MB disk cache
                                                                 diskPath:[SDURLCache defaultCachePath]];
        [NSURLCache setSharedURLCache:urlCache];
        [urlCache release];
        
        //显示菊花
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
}


- (void)getAllCategoriesOnCompletion:(void (^)(NSArray *list))completeBlock onError:(ErrorBlock)errorBlock
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

- (void)getRecipesByCategory:(NSInteger)cid OnCompletion:(void (^)(NSArray *list))completeBlock onError:(ErrorBlock)errorBlock
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
            [recipe setCName:[dic objectForKey:@"cname"]];
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

- (void)getAllDesksOnCompletion:(void (^)(NSArray *list))completeBlock onError:(ErrorBlock)errorBlock
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

- (void) getImage:(NSString *)urlStr OnCompletion:(void (^)(UIImage *image))completeBlock onError:(ErrorBlock)errorBlock
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
        completeBlock(image);
    }];
    
    [operation start];
}

- (void) submitOrder:(NSMutableDictionary *)order OnCompletion :(void (^)(NSString *orderURL))completeBlock onError:(ErrorBlock)errorBlock{    
    NSURL *url = [NSURL URLWithString:REQUEST_HOST];
    AFHTTPClient *httpClient = [[[AFHTTPClient alloc] initWithBaseURL:url] autorelease];
    
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

- (void) getOrderDetail:(NSInteger)oid OnCompletion:(void (^)(NSDictionary *orderURL)) completeBlock onError:(ErrorBlock) errorBlock
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
