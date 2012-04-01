//
//  Category.m
//  Diancan
//
//  Created by 李炜 on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZTCategory.h"

@implementation ZTCategory

@synthesize cID;
@synthesize cImageURL;
@synthesize cName;
@synthesize cDescription;
@synthesize cImage=_cImage;
-(void)getCategoryImage:(getCategoryImageBlock)getCategoryImageBlock{
    if (_cImage!=nil) {
        getCategoryImageBlock(_cImage);
        return ;
    }
    NSString *imageURL = self.cImageURL;
    [ApplicationDelegate.restEngine getImage:imageURL OnCompletion:^(UIImage *image) {
        _cImage=image;
        getCategoryImageBlock(_cImage);
        //        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } onError:^(NSError *error) {
        NSLog(@"获取失败");
    }];
    
    
}

@end
