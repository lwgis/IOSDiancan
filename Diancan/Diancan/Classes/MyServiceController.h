//
//  MyServiceController.h
//  Diancan
//
//  Created by 李炜 on 12-2-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyServiceController : UIViewController
- (IBAction)updateData:(id)sender;
- (IBAction)getRecipeByCategory:(id)sender;
- (IBAction)getImageByURL:(id)sender;
- (IBAction)getAllDesk:(id)sender;

- (IBAction)submitOrder:(id)sender;
- (IBAction)getOrderDetail:(id)sender;

@property (retain, nonatomic) IBOutlet UIImageView *myImageView;
@end
