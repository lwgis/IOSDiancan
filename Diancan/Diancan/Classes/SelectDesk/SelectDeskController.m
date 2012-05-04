//
//  SelectDeskController.m
//  Diancan
//
//  Created by 李炜 on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectDeskController.h"
#import "ZTDesk.h"
@implementation SelectDeskController
@synthesize listDesk,deskTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIView *titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 40)];
        UIButton *btnDesk=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnDesk setFrame:CGRectMake(0, 0, 120, 40)];
        [btnDesk setTitle:@"大厅∇" forState:UIControlStateNormal];
        [titleView addSubview:btnDesk];
        UIButton *btnThumbnails=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnThumbnails setImage:[UIImage imageNamed:@"liebiao.png"] forState:UIControlStateNormal];
        [btnThumbnails setImage:[UIImage imageNamed:@"suoluetu.png"] forState:UIControlStateSelected];
        [btnThumbnails addTarget:self action:@selector(btnThumbnailsClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnThumbnails setFrame:CGRectMake(140, 0, 40, 40)];
        [titleView addSubview:btnThumbnails];
        [self.navigationItem setTitleView:titleView];
        [titleView release];
        UIButton *refreshBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0, 40, 40)];
        [refreshBtn setTitle:[super navigationController].title forState:UIControlEventTouchUpInside];
        [refreshBtn setImage:[UIImage imageNamed:@"refreshDesk.png"] forState:UIControlStateNormal];
        [refreshBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *refreshBarBtn = [[UIBarButtonItem alloc] initWithCustomView:refreshBtn];
        self.navigationItem.rightBarButtonItem=refreshBarBtn;
        [refreshBtn release];
        [refreshBarBtn release];   
        UITableView *aTableView=[[UITableView alloc] initWithFrame:CGRectMake(0 ,0, self.view.frame.size.width, self.view.frame.size.height)];
        [aTableView setDelegate:self];
        [aTableView setDataSource:self];
        [self setDeskTableView:aTableView];
        [self.view addSubview:aTableView];
        [aTableView release];
    }
    return self;
}
-(void)rightButtonClick{
    [self refreshData];
}
-(void)btnThumbnailsClick:(UIButton *)sender{
    [sender setSelected:!sender.selected];    
}
-(void)back{  
    [self.navigationController popViewControllerAnimated:YES];  
}  

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)refreshData{
    [[RestEngine sharedEngine] getAllDesksOnCompletion:^(NSArray *array) {
        [self setListDesk:array];
        [self.deskTableView reloadData];
    } onError:^(NSError *error) {
        NSLog(@"获取失败：%@",error);
    }];
}
#pragma tabelView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.listDesk.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    ZTDesk *aDesk=(ZTDesk *)[listDesk objectAtIndex:row];
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
							 SectionsTableIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleDefault
				 reuseIdentifier:SectionsTableIdentifier] autorelease];
    }
	
    cell.textLabel.text = aDesk.dName;
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView
//titleForHeaderInSection:(NSInteger)section {
//    NSString *key = [keys objectAtIndex:section];
//    return key;
//}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return keys;
//}
#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"%@",self.navigationItem.backBarButtonItem.title);

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

@end
