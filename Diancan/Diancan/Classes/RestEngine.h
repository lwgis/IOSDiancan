//
//  RestEngine.h
//  testCoreData
//
//  Created by 赵飞 on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

#define REQUEST_HOST @"HTTP://192.168.1.105:8080"
#define ALL_CATEGORY_URL [NSString stringWithFormat:@"%@/ChihuoService/rest/categories/",REQUEST_HOST]
#define RECIPE_BY_CATEGORY_URL(__ID__) [NSString stringWithFormat:@"%@/ChihuoService/rest/categories/%i",REQUEST_HOST, __ID__]

#define ALL_DESKTYPES_URL [NSString stringWithFormat:@"%@/ChihuoService/rest/desktypes/",REQUEST_HOST]
#define DESK_BY_TYPE_URL(__ID__) [NSString stringWithFormat:@"%@/ChihuoService/rest/desktypes/%i",REQUEST_HOST, __ID__]
#define ALL_DESK_URL [NSString stringWithFormat:@"%@/ChihuoService/rest/desks/",REQUEST_HOST]

#define SUBMIT_ORDER_URL @"/ChihuoService/rest/orders/"

#define ORDER_DETAIL_URL(__ID__) [NSString stringWithFormat:@"%@/ChihuoService/rest/orders/%i",REQUEST_HOST, __ID__]

#define IMAGE_URL(__URL__) [NSString stringWithFormat:@"http://192.168.1.105:8080/ChihuoService/MenuImages/%@", __URL__]


        
@interface RestEngine : NSObject

+ (RestEngine *)sharedEngine;

typedef void (^ErrorBlock)(NSError *error);

//获取所有种类
- (void) getAllCategoriesOnCompletion:(void (^)(NSArray *list)) completeBlock onError:(ErrorBlock) errorBlock;

//获取某个种类下面的菜单
- (void) getRecipesByCategory:(NSInteger)cid OnCompletion:(void (^)(NSArray *list)) completeBlock onError:(ErrorBlock) errorBlock;


//获取桌子类型
- (void) getAllDeskTypesOnCompletion:(void (^)(NSArray *list)) completeBlock onError:(ErrorBlock) errorBlock;

//获取某个类型下面的桌子
- (void) getDesksByType:(NSInteger)tid OnCompletion:(void (^)(NSArray *list)) completeBlock onError:(ErrorBlock) errorBlock;

//获取所有桌子
- (void) getAllDesksOnCompletion:(void (^)(NSArray *list)) completeBlock onError:(ErrorBlock) errorBlock;

// 下载图片
- (void) getImage:(NSString*)url OnCompletion:(void (^)(UIImage *image)) completeBlock onError:(ErrorBlock) errorBlock;

//开台
- (void) submitOrder: (NSMutableDictionary*)order OnCompletion:(void (^)(NSDictionary *orderDetail)) completeBlock onError:(ErrorBlock) errorBlock;

//获取订单详情
- (void) getOrderDetail:(NSInteger)oid OnCompletion:(void (^)(NSDictionary *orderDetail)) completeBlock onError:(ErrorBlock) errorBlock;

//加减菜
- (void) addRecipe:(NSDictionary *)recipeCount ToOrder:(NSInteger)oid OnCompletion:(void (^)(NSDictionary *orderDetail)) completeBlock onError:(ErrorBlock) errorBlock;

@end
