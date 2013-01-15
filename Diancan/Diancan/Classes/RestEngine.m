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
#import "AFJSONUtilities.h"

#import "SDURLCache.h"

#import "ZTCategory.h"
#import "ZTRecipe.h"
#import "ZTDesk.h"
#import "ZTDeskType.h"


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
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest* request = [[[NSMutableURLRequest alloc] initWithURL:url]
                                    autorelease];
    
    NSString *post = nil;
    post = [[NSString alloc] initWithFormat:@"name=%@&password=%@",@"u1",@"111111"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:@"http://192.168.10.220:18080/data/1.jsp"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
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

- (void)getAllDeskTypesOnCompletion:(void (^)(NSArray *))completeBlock onError:(ErrorBlock)errorBlock
{
    NSURL *url = [NSURL URLWithString:ALL_DESKTYPES_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSMutableArray *array = [NSMutableArray array];   
        
        for (NSDictionary *dic in JSON) {
            ZTDeskType *c = [[ZTDeskType alloc] init];
            [c setTID:[NSNumber numberWithInteger:[[dic objectForKey:@"id"] integerValue]]];
            [c setTName:[dic objectForKey:@"name"]];
            [c setTDescription:[dic objectForKey:@"description"]];
            [array addObject:c];
            [c release];
        }
        completeBlock(array); 
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        errorBlock(error);
    }];
    
    [operation start];
}

- (void)getDesksByType:(NSInteger)tid OnCompletion:(void (^)(NSArray *))completeBlock onError:(ErrorBlock)errorBlock
{
    NSURL *url = [NSURL URLWithString:DESK_BY_TYPE_URL(tid)];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSMutableArray *array = [NSMutableArray array];   
        
        for (NSDictionary *dic in JSON) {
            ZTDesk *c = [[ZTDesk alloc] init];            
            [c setDID:[NSNumber numberWithInteger:[[dic objectForKey:@"id"] integerValue]]];
            [c setDName:[dic objectForKey:@"name"]];
            [c setDCapacity: [NSNumber numberWithInteger:[[dic objectForKey:@"capacity"] integerValue]]];
            [c setDStatus:[NSNumber numberWithInteger:[[dic objectForKey:@"status"] integerValue]]];
            
            [array addObject:c];
            [c release];
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
        NSMutableArray *array = [NSMutableArray array];   
        
        for (NSDictionary *dic in JSON) {
            ZTDesk *c = [[ZTDesk alloc] init];            
            [c setDID:[NSNumber numberWithInteger:[[dic objectForKey:@"id"] integerValue]]];
            [c setDName:[dic objectForKey:@"name"]];
            [c setDCapacity: [NSNumber numberWithInteger:[[dic objectForKey:@"capacity"] integerValue]]];
            [c setDStatus:[NSNumber numberWithInteger:[[dic objectForKey:@"status"] integerValue]]];

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

- (void) submitOrder:(NSMutableDictionary *)order OnCompletion :(void (^)(NSDictionary *orderDetail))completeBlock onError:(ErrorBlock)errorBlock{    
    NSURL *url = [NSURL URLWithString:REQUEST_HOST];
    AFHTTPClient *httpClient = [[[AFHTTPClient alloc] initWithBaseURL:url] autorelease];
    
//    NSMutableArray *recipes = [NSMutableArray array];
//    NSArray *array = [order valueForKey:@"recipes"];
//    for (NSDictionary *d in array) {
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        ZTRecipe *r = [d valueForKey:@"recipe"];
//        [dic setValue:r.rID forKey:@"rid"];
//        [dic setValue:[d valueForKey:@"count"] forKey:@"count"];
//        [recipes addObject:dic];
//    }
//    
//    NSMutableDictionary *body = [NSMutableDictionary dictionary]; 
//    [body setValue:[order valueForKey:@"tid"] forKey:@"tid"];
//    [body setValue:[order valueForKey:@"number"] forKey:@"number"];
//    [body setValue:recipes forKey:@"recipes"];
    
    
    httpClient.parameterEncoding = AFJSONParameterEncoding;

    [httpClient postPath:SUBMIT_ORDER_URL parameters:order
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSInteger statusCode = operation.response.statusCode;
                     assert(statusCode == 201);
                     
                     NSError *error;
                     NSDictionary *orderDetail = AFJSONDecode(operation.responseData, &error);

//                     NSString *orderURL =[NSString stringWithFormat:@"%@", [operation.response.allHeaderFields objectForKey:@"Location"]];
                     completeBlock(orderDetail);
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     errorBlock(error);
                 }];
}

- (void) getOrderDetail:(NSInteger)oid OnCompletion:(void (^)(NSDictionary *orderURL)) completeBlock onError:(ErrorBlock) errorBlock
{
    NSURL *url = [NSURL URLWithString:ORDER_DETAIL_URL(oid)];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        completeBlock(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        errorBlock(error);
    }];
    
    [operation start];
}

- (void) addRecipe:(NSDictionary *)recipeCount ToOrder:(NSInteger)oid OnCompletion:(void (^)(NSDictionary *))completeBlock onError:(ErrorBlock)errorBlock
{
    NSURL *url = [NSURL URLWithString:REQUEST_HOST];
    AFHTTPClient *httpClient = [[[AFHTTPClient alloc] initWithBaseURL:url] autorelease];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    [httpClient postPath:ORDER_DETAIL_URL(oid) parameters:recipeCount
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSInteger statusCode = operation.response.statusCode;
                     assert(statusCode == 200);
                     NSError *error;
                     NSDictionary *body = AFJSONDecode(operation.responseData, &error);
                     completeBlock(body);
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     errorBlock(error);
                 }];
}

@end
