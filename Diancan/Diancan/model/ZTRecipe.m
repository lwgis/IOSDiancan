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
@synthesize rDescription;
@synthesize rID;
@synthesize rImageURL;
@synthesize rName;
@synthesize rPrice;
@synthesize  count;
@synthesize rImage=_rImage;
@synthesize rImageView;
-(void)getRecipeImage:(getRecipeImageBlock)getRecipeImageBlock{
    if (_rImage!=nil) {
        [rImageView setImage:_rImage];  
        getRecipeImageBlock(_rImage);
        return ;
    }
    NSString *imageURL = self.rImageURL;
    [ApplicationDelegate.restEngine getImage:imageURL OnCompletion:^(UIImage *image) {
        _rImage=image;
        [self.rImageView setImage:_rImage];
        getRecipeImageBlock(_rImage);
        //        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } onError:^(NSError *error) {
        NSLog(@"获取失败");
    }];


}
@end
