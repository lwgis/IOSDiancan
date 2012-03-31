//
//  MyMenuView.m
//  Diancan
//
//  Created by 李炜 on 12-3-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyMenuView.h"
#import "FoodCell.h"
#import "RecipeImage.h"
@implementation MyMenuView
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if(self!=nil){
        
    }
    return  self;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return [keys count];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    NSString *key = [keys objectAtIndex:section];
    //    NSArray *nameSection = [names objectForKey:key];
    //    return [nameSection count];
    ZTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    return [appDelegate.orderList count];

}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath { 
    
    if (editingStyle == UITableViewCellEditingStyleDelete) { 
        //        [keys removeObjectAtIndex:indexPath.row]; 
        // Delete the row from the data source. 
        
        //        [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade]; 
        
        NSString *SectionsTableIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];
        FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:
                          SectionsTableIdentifier];
        [cell setFoodCount:0];
        [cell setCountLabelText:@""];
    }    
    else if (editingStyle == UITableViewCellEditingStyleInsert) { 
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view. 
    }    
} 
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{ 
    return @"删除"; 
} 

//绑定单元格

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;

    Recipe *recipe=[appDelegate.orderList objectAtIndex:[indexPath row]];
	NSString *SectionsTableIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:
                      SectionsTableIdentifier];
    if (cell == nil) {
        cell = [[FoodCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:SectionsTableIdentifier] ;  
    }
//    cell.image=recipe.image.image;
        //        //使用xib加载cell
        //        NSArray *nibTableCells = [[NSBundle mainBundle]  loadNibNamed:@"FoodCell" owner:self options:nil];
        //        cell = [nibTableCells objectAtIndex:0];
//    }
//    ZTMenu *ztmenu =(ZTMenu*)[self.fetchedResultsController objectAtIndexPath:indexPath];
//    
//    cell.textLabel.text = ztmenu.name;
//    UIImage *image = [UIImage imageNamed:ztmenu.image];
//    cell.imageView.image = image;
//    NSString *price=[NSString stringWithFormat:@"￥%.2f",ztmenu.price];
//    [cell.detailTextLabel setText:price];
//    [cell setZtmenu:ztmenu];
//    
//    UILabel *label = (UILabel *)[cell viewWithTag:1];
//    //    NSString *text;
//    //    text = [[self.fetchedResultsController sections] objectAtIndex:indexPath.row];
//    CGRect cellFrame = [cell frame];
//    cellFrame.origin = CGPointMake(0, 0);
//    
//    label.text = @"!!!!!!!!!";
//    CGRect rect = CGRectInset(cellFrame, 2, 2);
//    label.frame = rect;
//    [label sizeToFit];
//    if (label.frame.size.height > 46) {
//        cellFrame.size.height = 50 + label.frame.size.height - 46;
//    }
//    else {
//        cellFrame.size.height = 50;
//    }
//    [cell setFrame:cellFrame];
//    
//    
//    return cell;
    return  cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
//    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
//    return [sectionInfo name];
    return  nil;
}


@end
