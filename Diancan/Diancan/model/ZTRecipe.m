//
//  Recipe.m
//  Diancan
//
//  Created by 李炜 on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZTRecipe.h"

@implementation ZTRecipe

@synthesize cID;
@synthesize cName;
@synthesize rDescription;
@synthesize rID;
@synthesize rImageURL;
@synthesize rName;
@synthesize rPrice;
@synthesize rImage;
-(void)getRecipeImage:(getRecipeImageBlock)getRecipeImageBlock{
//    if (self.rImage!=nil) {
//        getRecipeImageBlock(self.rImage);
//        return ;
//    }
    rImage=nil;
    NSString *imageURL = self.rImageURL;
    [[RestEngine sharedEngine] getImage:imageURL OnCompletion:^(UIImage *image) {
        [self setRImage:image];
//        _rImage=image;
        getRecipeImageBlock(self.rImage);
        //        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } onError:^(NSError *error) {
        NSLog(@"获取失败");
    }];


}

@end
