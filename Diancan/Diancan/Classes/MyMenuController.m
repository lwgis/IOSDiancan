//
//  MyMenuController.m
//  Diancan
//
//  Created by 李炜 on 12-2-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyMenuController.h"
#import "MyMenuView.h"
#import "FoodCell.h"
#import "RecipeImage.h"
#import "ZTCategory.h"
#import "Category+Search.h"
#import "Recipe+Search.h"

@implementation MyMenuController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
      self.navigationItem.leftBarButtonItem =   [self editButtonItem];
   
//    ((UITableView *)self.view).separatorStyle = NO;
    // Do any additional setup after loading the view from its nib.
}

 - (void)setEditing:(BOOL)editing animated:(BOOL)animated
 {
         [super setEditing:editing animated:animated];
     if (editing) {
         [self.editButtonItem setTitle:@"完成"];
     }
     else{
         [self.editButtonItem setTitle:@"编辑"];
     }
 }
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [((UITableView *)self.view) reloadData];
}
#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return [keys count];
    ZTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSLog(@"orderlistCount=%d",[appDelegate.orderList count]);
    return [appDelegate.orderList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    ZTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    Category *category=[appDelegate.orderList objectAtIndex:section] ;
    NSLog(@"inCount=%d",[category.orderList count]);

    return [category.orderList count];

    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath { 
    ZTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    Category *category=[appDelegate.orderList objectAtIndex:[indexPath section]];
    Recipe *recipe=[category.orderList objectAtIndex:[indexPath row]];
    NSInteger num=recipe.count;
    appDelegate.foodCount=appDelegate.foodCount-num;
//    NSString *badgeValue = [NSString stringWithFormat:@"%d",appDelegate.foodCount];  
    recipe.count=0;
//    [[[[appDelegate.rootController viewControllers] objectAtIndex: 1] tabBarItem] setBadgeValue:badgeValue];
    [category.orderList removeObject:recipe];
    NSLog(@"category.orderList=%d",[category.orderList count]);

    [appDelegate countPrice];
    if (editingStyle == UITableViewCellEditingStyleDelete) { 
        
        UITableView *tableView=(UITableView *)self.view;
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade]  ;
        if ([category.orderList count]==0) {
            [appDelegate.orderList removeObject:category];
        }

    }    
    else if (editingStyle == UITableViewCellEditingStyleInsert) { 
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view. 
    }    
    [self viewWillAppear:YES];

} 
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{ 
    return @"删除"; 
} 

//绑定单元格

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    Category *category=[appDelegate.orderList objectAtIndex:[indexPath section]];
    Recipe *recipe=[category.orderList objectAtIndex:[indexPath row]];
	NSString *SectionsTableIdentifier = [NSString stringWithFormat:@"Cell", [indexPath section], [indexPath row]];
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:
                      SectionsTableIdentifier];
    if (cell == nil) {
        cell = [[[FoodCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:SectionsTableIdentifier]  autorelease];  
    }
    cell.imageView.image=recipe.image.image;
    [cell.textLabel setText:recipe.rName];
    NSString *price=[NSString stringWithFormat:@"￥%@",recipe.rPrice];
    [cell.detailTextLabel setText:price];
    NSString *count=[NSString stringWithFormat:@"x %d",recipe.count];
    [cell setCountLabelText:count];
    return  cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {    
    ZTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    if ([appDelegate.orderList count]==0) {
        return nil;
    }
    NSLog(@"orderlistCount=%d",[appDelegate.orderList count]);
    Category *category=[appDelegate.orderList objectAtIndex: section];   
    return category.cName;
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    ZTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//    Category *category=[appDelegate.orderList objectAtIndex: section];
//    
//    return category.cName;
//}


@end
