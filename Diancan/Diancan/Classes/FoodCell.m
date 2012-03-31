//
//  FoodCell.m
//  Diancan
//
//  Created by 李炜 on 12-2-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FoodCell.h"

@implementation FoodCell
@synthesize foodCount,ztmenu;


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
   self=  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     countLabel=[[UILabel alloc] initWithFrame:CGRectMake(280, 20.0f, 40, 20)];
    countLabel.textColor=[UIColor colorWithRed:255 green:0 blue:0 alpha:1.0f];
    countLabel.backgroundColor=[UIColor clearColor];
    UIFont *font=  [UIFont  boldSystemFontOfSize:17.0f];  
    [countLabel setFont:font];
    [self addSubview:countLabel];
    [self setFoodCount:0];
    self.backgroundColor=[UIColor whiteColor];
    return  self;
    
}
-(void) setCountLabelText:(NSString *)count
{
    NSString *sCount=count;//[NSString stringWithFormat:@"%d",count];
    [countLabel setText:sCount];
//    [sCount release];

}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    
    // Release any cached data, images, etc that aren't in use.
}
#pragma mark - View lifecycle
-(void)addFoodCount
{
    int count=foodCount+1;
    [self setFoodCount:count];
    NSString *string=[NSString stringWithFormat:@"×%d",count];
    [ countLabel setText:string];
//    [countLabel  setText:self.text];
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    NSLog(@"myview");
    [self.nextResponder touchesBegan:touches withEvent:event];
}


@end
