//
//  MainMenuController.m
//  Diancan
//
//  Created by 李炜 on 12-2-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainMenuController.h"
#import "FoodInfoController.h"
#import "ChooseTableController.h"
#import "FoodCell.h"
#import "ZTMenu.h"
#import "ZTAppDelegate.h"
#import "ZTCategory.h"
@implementation MainMenuController
@synthesize names;
@synthesize keys;
@synthesize focusCell;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;
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
    // Do any additional setup after loading the view from its nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames"
                                                     ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]
                          initWithContentsOfFile:path];
    self.names = dict;
    [dict release];
	
    NSArray *array = [[names allKeys] sortedArrayUsingSelector:
                      @selector(compare:)];
    self.keys = array;
    [self.navigationController setNavigationBarHidden:YES]; 
    //创建一个右边按钮
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]  initWithTitle:@"桌号"   
//                                                                     style:UIBarButtonItemStyleDone   
//                                                                    target:self   
//                                                                    action:@selector(clickRightButton)];  
//    rightButton.style=UIBarButtonItemStyleBordered;
//    [self.navigationItem setRightBarButtonItem:rightButton];
//    [rightButton release];
    ZTAppDelegate *appDelegate=(ZTAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext=appDelegate.managedObjectContext;
    
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return [keys count];
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSString *key = [keys objectAtIndex:section];
//    NSArray *nameSection = [names objectForKey:key];
//    return [nameSection count];
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
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
    return @"下载"; 
} 

//绑定单元格

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
	
    NSString *key = [keys objectAtIndex:section];
    NSArray *nameSection = [names objectForKey:key];
	NSString *SectionsTableIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];
//    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:
							 SectionsTableIdentifier];
    if (cell == nil) {
        cell = [[FoodCell alloc]
				 initWithStyle:UITableViewCellStyleSubtitle
				 reuseIdentifier:SectionsTableIdentifier] ;
 
//        //使用xib加载cell
//        NSArray *nibTableCells = [[NSBundle mainBundle]  loadNibNamed:@"FoodCell" owner:self options:nil];
//        cell = [nibTableCells objectAtIndex:0];
    }
//	[cell setCountLabelText:row];
    
    cell.textLabel.text = [nameSection objectAtIndex:row];
    UIImage *image = [UIImage imageNamed:cell.textLabel.text];
    cell.imageView.image = image;
      [cell.detailTextLabel setText:@"￥5.00"];
    return cell;
     */
    
	NSString *SectionsTableIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:
                      SectionsTableIdentifier];
    if (cell == nil) {
        cell = [[FoodCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:SectionsTableIdentifier] ;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.tag = 1;
        label.lineBreakMode = UILineBreakModeWordWrap;
        label.highlightedTextColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.opaque = NO; // 选中Opaque表示视图后面的任何内容都不应该绘制
        label.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:label];
        [label release];
        
        //        //使用xib加载cell
        //        NSArray *nibTableCells = [[NSBundle mainBundle]  loadNibNamed:@"FoodCell" owner:self options:nil];
        //        cell = [nibTableCells objectAtIndex:0];
    }
    ZTMenu *ztmenu =(ZTMenu*)[self.fetchedResultsController objectAtIndexPath:indexPath];

    cell.textLabel.text = ztmenu.name;
    UIImage *image = [UIImage imageNamed:ztmenu.image];
    cell.imageView.image = image;
    NSString *price=[NSString stringWithFormat:@"￥%.2f",ztmenu.price];
    [cell.detailTextLabel setText:price];
    [cell setZtmenu:ztmenu];
    
    UILabel *label = (UILabel *)[cell viewWithTag:1];
//    NSString *text;
//    text = [[self.fetchedResultsController sections] objectAtIndex:indexPath.row];
    CGRect cellFrame = [cell frame];
    cellFrame.origin = CGPointMake(0, 0);
    
    label.text = @"!!!!!!!!!";
    CGRect rect = CGRectInset(cellFrame, 2, 2);
    label.frame = rect;
    [label sizeToFit];
    if (label.frame.size.height > 46) {
        cellFrame.size.height = 50 + label.frame.size.height - 46;
    }
    else {
        cellFrame.size.height = 50;
    }
    [cell setFrame:cellFrame];
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height*4;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    NSUInteger row = [indexPath row];
//    NSString *rowValue = [self.keys objectAtIndex:row];
    
    FoodCell *cell =(FoodCell *) [tableView cellForRowAtIndexPath:indexPath];
    [self setFocusCell:cell];
    NSString *message = focusCell.textLabel.text ;
    
    UIBarButtonItem *backItem = [[[UIBarButtonItem alloc] initWithTitle:@"菜单" 
                                                                  style:UIBarButtonItemStyleBordered 
                                                                 target:nil 
                                                                 action:nil] autorelease];
    self.navigationItem.backBarButtonItem = backItem;
//    
   FoodInfoController *second = [[[FoodInfoController alloc] init] autorelease];
    
//    second.hidesBottomBarWhenPushed=YES;
//   ZTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
//    [focusCell addFoodCount];
    [second setFoodcell:focusCell];
    [self.navigationController pushViewController:second animated:NO];
    ZTMenu *ztmenu=cell.ztmenu;
    UIImage *image = [UIImage imageNamed:ztmenu.image];
    [second.foodImage setImage:image];
    [second.foodNameLabel setText:message];
    //设置导航栏内容
    [second.navigationItem setTitle:message];
//    [message release];
//    [cell release];
//    UILabel *pLabel=[[UILabel alloc] initWithFrame:CGRectMake(300, 10, 20, 20)];
//    [pLabel setText:@"1"];    
    
    
    
}
- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo name];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.fetchedResultsController sectionIndexTitles];
}

-(void)clickRightButton
{
    //滚动到指定单元格
//        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow: 0  inSection:0] 
//                              atScrollPosition:UITableViewScrollPositionBottom animated:YES];    
  
//    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
    ChooseTableController *pchooseController=[[[ChooseTableController alloc] init] autorelease];
    pchooseController.mainMenuController =self;
    pchooseController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentModalViewController:pchooseController animated:YES];
//    [self insertNewObject];
    self.navigationItem.title=pchooseController.tableName;
 
}
- (void)insertNewObject
{
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    ZTMenu *ztmenu = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
//    NSDate *now=[self getDate];
//    [newManagedObject  setValue:now forKey:@"timeStamp"];
    // Save the context.
    [ztmenu setFid:154];
    [ztmenu setCid:4];
    [ztmenu setName:@"凉拌荠菜"];
    [ztmenu setPrice:5.00f];
    [ztmenu setImage:@"876d802b-46de-4ab2-85d3-961896082887.png"];
//    ZTCategory *ztcategory=[NSEntityDescription insertNewObjectForEntityForName:@"ZTCategory" inManagedObjectContext:context];
//    [ztcategory setCid:4];
//    [ztcategory setCname:@"凉菜"];
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
//    ZTAppDelegate *appDelegate=(ZTAppDelegate *)[[UIApplication sharedApplication]delegate];
//    [appDelegate saveContext];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    
    // Set up the fetched results controller.
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ZTMenu" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"cid" ascending:YES] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"cid" cacheName:@"Master"] autorelease];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}    

//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
//       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
//      newIndexPath:(NSIndexPath *)newIndexPath
//{
//    UITableView *tableView = self.tableView;
//    
//    switch(type) {
//        case NSFetchedResultsChangeInsert:
//            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeDelete:
//            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeUpdate:
////            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
//            break;
//            
//        case NSFetchedResultsChangeMove:
//            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
//            break;
//    }
//}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
        NSLog(@"MainView");
    [self.nextResponder touchesBegan:touches withEvent:event];
}


@end
