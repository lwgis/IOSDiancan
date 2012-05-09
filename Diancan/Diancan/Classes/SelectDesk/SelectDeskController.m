//
//  SelectDeskController.m
//  Diancan
//
//  Created by 李炜 on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectDeskController.h"
#import "ZTDesk.h"
#import "ZTDeskType.h"
#import <QuartzCore/QuartzCore.h>
#import "DeskCellView.h"
@implementation SelectDeskController{
    NSInteger currentDeskTypeID;
    NSInteger currentDeskID;
}
@synthesize listDesk,deskTableView,listDeskType,selectTitleDialog,deskTypeButton,thumbnailsView,deskSearchBar,listDeskBack;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIView *titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 40)];
        UIButton *btnDesk=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnDesk addTarget:self action:@selector(btnDeskClick) forControlEvents:UIControlEventTouchUpInside];
        [btnDesk setFrame:CGRectMake(0, 0, 120, 40)];
        [self setDeskTypeButton:btnDesk];
        [titleView addSubview:btnDesk];
        UIButton *btnThumbnails=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnThumbnails setImage:[UIImage imageNamed:@"liebiao.png"] forState:UIControlStateNormal];
        [btnThumbnails setImage:[UIImage imageNamed:@"suoluetu.png"] forState:UIControlStateSelected];
        [btnThumbnails addTarget:self action:@selector(btnThumbnailsClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnThumbnails setFrame:CGRectMake(140, 0, 40, 40)];
        [titleView addSubview:btnThumbnails];
        [self.navigationItem setTitleView:titleView];
        [titleView release];
        UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [refreshBtn setFrame:CGRectMake(0.0, 0, 40, 40)];
        [refreshBtn setTitle:[super navigationController].title forState:UIControlEventTouchUpInside];
        [refreshBtn setImage:[UIImage imageNamed:@"refreshDesk.png"] forState:UIControlStateNormal];
        [refreshBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *refreshBarBtn = [[UIBarButtonItem alloc] initWithCustomView:refreshBtn];
        self.navigationItem.rightBarButtonItem=refreshBarBtn;
        [refreshBarBtn release];   
        //缩略图
        UIScrollView *aView=[[UIScrollView alloc] initWithFrame:CGRectMake(0 ,0, 320, 420)];
        aView.backgroundColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        self.thumbnailsView=aView;
        [self.view addSubview:aView];
        [aView release];
        //列表
        UITableView *aTableView=[[UITableView alloc] initWithFrame:CGRectMake(0 ,0, 320, 420)];
        [aTableView setDelegate:self];
        [aTableView setDataSource:self];
        [aTableView setAllowsSelection:YES];
        UISearchBar  *aSearchBar=[[UISearchBar  alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
        aSearchBar.tintColor=[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f];
        aSearchBar.autocorrectionType=UITextAutocorrectionTypeNo;
        aSearchBar.autocapitalizationType=UITextAutocapitalizationTypeNone;
        aSearchBar.keyboardType=UIKeyboardTypeDefault;
        aSearchBar.hidden=NO;
        aSearchBar.delegate=self;
        aSearchBar.placeholder=[NSString stringWithCString:"请输入桌号或者包厢名称"  encoding: NSUTF8StringEncoding];
        [self setDeskSearchBar:aSearchBar];
        [self setDeskTableView:aTableView];
        self.deskTableView.tableHeaderView=deskSearchBar;        
        [deskSearchBar release];
        [self.view addSubview:aTableView];
        [aTableView release];
        [[RestEngine sharedEngine] getAllDeskTypesOnCompletion:^(NSArray *list) {
            [self setListDeskType:list];
            ZTDeskType *aDt= (ZTDeskType *)[list objectAtIndex:0];
            [btnDesk setTitle:[NSString stringWithFormat:@"%@∇",aDt.tName] forState:UIControlStateNormal];
            currentDeskTypeID=[aDt.tID integerValue];
//            [[RestEngine sharedEngine] getDesksByType:[aDt.tID integerValue] OnCompletion:^(NSArray *list) {
//                self.listDesk=[[NSMutableArray alloc] init];
//                for (ZTDesk *desk in list) {
//                    if ([desk.dStatus integerValue]!=1) {
//                        [self.listDesk addObject:desk];
//                    }
//                }
//                [self.deskTableView reloadData];
//            } onError:^(NSError *error) {
//    
//            }];
            [self refreshData:currentDeskTypeID];
        } onError:^(NSError *error) {
            
        }];
    }
    return self;
}
-(void)btnDeskClick{
    if (self.selectTitleDialog==nil) {
        SelectTitleDialog *aSd=[[SelectTitleDialog alloc] initWithFrame:CGRectMake(50, -200, 220, 200)];
        NSString *deskTypeName=self.deskTypeButton.titleLabel.text;
        deskTypeName=[deskTypeName substringToIndex:deskTypeName.length-1];
        [aSd showDialog:self.listDeskType deskName:deskTypeName];
        //        [aCd setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:aSd];
        [self setSelectTitleDialog:aSd];
        [aSd release];
    }
    [UIView beginAnimations:@"dialog" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.4f];
    [self.selectTitleDialog setFrame:CGRectMake(50, 0, 220, 200)];
    [UIView commitAnimations];
    self.deskTableView.userInteractionEnabled=NO;
}
-(void)rightButtonClick{
    [self refreshData:currentDeskTypeID];
}
-(void)btnThumbnailsClick:(UIButton *)sender{
    [sender setSelected:!sender.selected];    
    [self.deskSearchBar resignFirstResponder];
    if (!sender.selected) {
        [UIView beginAnimations:@"animationID" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.7f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [self.view insertSubview:self.thumbnailsView atIndex:0];
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:@"animationID" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.7f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [self.view insertSubview:self.deskTableView atIndex:0];
        [UIView commitAnimations];
    }
    
}
-(void)back{  
    [self.navigationController popViewControllerAnimated:YES];  
}  
-(void)selectDeskTypeClick:(UIButton *)sender{
    ZTDeskType *aDeskType=(ZTDeskType *)[self.listDeskType objectAtIndex:sender.tag];
    [self.deskTypeButton setTitle:[NSString stringWithFormat:@"%@∇",aDeskType.tName] forState:UIControlStateNormal];
    currentDeskTypeID=[aDeskType.tID integerValue];
    [self refreshData:[aDeskType.tID integerValue]]; 
    self.deskTableView.userInteractionEnabled=YES;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)refreshData:(NSInteger)tID{
     [[RestEngine sharedEngine] getDesksByType:tID OnCompletion:^(NSArray *list){
        if (!self.listDesk) {
            [self.listDesk removeAllObjects];
            [self.listDeskBack removeAllObjects];
            [listDesk release];
            [listDeskBack release];
            [self  setListDesk:nil];
            [self setListDeskBack:nil];
        }
        self.listDesk=[[NSMutableArray alloc] init];
        self.listDeskBack=[[NSMutableArray alloc] init];
        for (ZTDesk *desk in list) {
            if ([desk.dStatus integerValue]!=1) {
                [self.listDesk addObject:desk];
                [self.listDeskBack addObject:desk];
            }
        }
         for (UIView *aView in self.thumbnailsView.subviews) {
             [aView removeFromSuperview];
         }
         for (NSInteger i=0; i<self.listDesk.count; i++) {
             ZTDesk *desk=(ZTDesk *)[self.listDesk objectAtIndex:i];
             DeskCellView *deskCellview=[[DeskCellView alloc] initWithFrame:CGRectMake((i%3)*100+20, ((NSInteger)i/3)*100+10, 80, 80)];
//             [deskCellview.layer setCornerRadius:10];
//             deskCellview.layer.shadowOffset =  CGSizeMake(3, 5);  
//             deskCellview.layer.shadowOpacity = 0.8;  
//             deskCellview.layer.shadowColor =  [UIColor blackColor].CGColor;
             [deskCellview setImage:[UIImage imageNamed:@"LargeMyTable.png"] forState:UIControlStateNormal];
             [deskCellview setTag:i];
             [deskCellview addTarget:self action:@selector(deskCellviewClick:) forControlEvents:UIControlEventTouchUpInside];
             [deskCellview.deskNameLable setText:desk.dName];
             [deskCellview.deskVolume setText:[NSString stringWithFormat:@"%d 人", [desk.dCapacity integerValue]]];
             [self.thumbnailsView addSubview:deskCellview];
             [deskCellview release];
         }
         NSInteger heigh=self.listDesk.count/3*100+20;
         if (self.listDesk.count%3>0) {
             heigh+=100;
         }
         [self.thumbnailsView setContentSize:CGSizeMake(320,heigh)];
         [self.deskSearchBar setText:nil];
        [self.deskTableView reloadData];
         [self.selectTitleDialog removeFromSuperview];
         self.selectTitleDialog=nil;
    } onError:^(NSError *error) {
        NSLog(@"获取失败：%@",error);
    }];
}
-(void)deskCellviewClick:(DeskCellView *)sender{
    ZTDesk *aDesk=(ZTDesk *)[self.listDesk objectAtIndex:sender.tag];
    currentDeskID=[aDesk.dID integerValue];
    UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"就餐人数" 
                                                     message:@"\n\n" 
                                                    delegate:self 
                                           cancelButtonTitle:@"取消" 
                                           otherButtonTitles:@"确定", nil];    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(27.0, 60.0, 230.0, 25.0)]; 
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField setPlaceholder:@"几位"];
    textField.keyboardType=UIKeyboardTypeNumberPad;
    [prompt addSubview:textField];
    [textField becomeFirstResponder];
    [textField release];    
    [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 0.0)];  //可以调整弹出框在屏幕上的位置    
    [prompt show];    
    [prompt release];
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
				 initWithStyle:UITableViewCellStyleSubtitle
				 reuseIdentifier:SectionsTableIdentifier] autorelease];
    }
	cell.selectionStyle=UITableViewCellSelectionStyleGray;  
    cell.textLabel.text = aDesk.dName;
    if ([aDesk.dCapacity intValue]>4) {
        [cell.imageView setImage:[UIImage imageNamed:@"LargeMyTableList.png"]];
    }
    else{
        [cell.imageView setImage:[UIImage imageNamed:@"SmallMyTable.png"]];
    }
    [cell.detailTextLabel setTextColor:[UIColor orangeColor]];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"                                                       %d 人", [aDesk.dCapacity integerValue]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZTDesk *aDesk=(ZTDesk *)[self.listDesk objectAtIndex:indexPath.row];
    currentDeskID=[aDesk.dID integerValue];
    UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"就餐人数" 
                                                     message:@"\n\n" 
                                                    delegate:self 
                                           cancelButtonTitle:@"取消" 
                                           otherButtonTitles:@"确定", nil];    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(27.0, 60.0, 230.0, 25.0)]; 
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField setPlaceholder:@"几位"];
    textField.keyboardType=UIKeyboardTypeNumberPad;
    [prompt addSubview:textField];
    [textField becomeFirstResponder];
    [textField release];    
    [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 0.0)];  //可以调整弹出框在屏幕上的位置    
    [prompt show];    
    [prompt release];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        for (NSInteger i=0; i<alertView.subviews.count; i++) {
            UIView *aView=[alertView.subviews objectAtIndex:i];
            if ([aView isKindOfClass:[UITextField class]]) {
                NSLog(@"%d",i);
                NSMutableDictionary *body = [NSMutableDictionary dictionary]; 
                [body setValue:[NSString stringWithFormat:@"%d",currentDeskID] forKey:@"tid"];
                UITextField *textField=(UITextField *)aView;
                if (textField.text.length==0) {
                    return;
                }
                [body setValue:textField.text forKey:@"number"];
                [[RestEngine sharedEngine] submitOrder:body OnCompletion:^(NSDictionary *orderDetail) {
                    NSLog(@"开台成功:%@",orderDetail);
                    ApplicationDelegate.deskID=[[orderDetail objectForKey:@"id"] integerValue];
                    NSDictionary *deskDictionary=(NSDictionary *)[orderDetail objectForKey:@"desk"];
                    ApplicationDelegate.deskName=(NSString *)[deskDictionary objectForKey:@"name"]; 
                    NSLog(@"%@",ApplicationDelegate.deskName);
                    [self.navigationController popToRootViewControllerAnimated:NO];
                } onError:^(NSError *error) {
                    NSLog(@"开台失败:%@",[error localizedFailureReason]);
                }];
            }
        }
    }
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.deskSearchBar resignFirstResponder];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSInteger i=0;
    for (UIView *aView in self.thumbnailsView.subviews) {
        [aView removeFromSuperview];
    }
    [self.listDesk removeAllObjects];
    for (ZTDesk *desk in self.listDeskBack) {
      NSRange range=[desk.dName rangeOfString:searchText];
        if (range.length>0||searchText.length==0) {
            [self.listDesk addObject:desk];
            DeskCellView *deskCellview=[[DeskCellView alloc] initWithFrame:CGRectMake((i%3)*100+20, ((NSInteger)i/3)*100+10, 80, 80)];
            [deskCellview setImage:[UIImage imageNamed:@"LargeMyTable.png"] forState:UIControlStateNormal];
            [deskCellview setTag:i];
            [deskCellview addTarget:self action:@selector(deskCellviewClick:) forControlEvents:UIControlEventTouchUpInside];
            [deskCellview.deskNameLable setText:desk.dName];
            [deskCellview.deskVolume setText:[NSString stringWithFormat:@"%d 人", [desk.dCapacity integerValue]]];
            [self.thumbnailsView addSubview:deskCellview];
            [deskCellview release];
            i++;
        }
    }
    NSInteger heigh=self.listDesk.count/3*100+20;
    if (self.listDesk.count%3>0) {
        heigh+=100;
    }
    [self.thumbnailsView setContentSize:CGSizeMake(320,heigh)];
    [self.deskTableView reloadData];
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // hide tabbar;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.deskSearchBar resignFirstResponder];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.selectTitleDialog!=nil&&selectTitleDialog.frame.origin.y>=0){
        [UIView beginAnimations:@"dialog" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5f];
        [self.selectTitleDialog setFrame:CGRectMake(50, -300, 220, 200)];
        [UIView commitAnimations];      
    }
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (selectTitleDialog!=nil&&selectTitleDialog.frame.origin.y<0) {
        [self.selectTitleDialog removeFromSuperview];
        self.selectTitleDialog = nil;
        self.deskTableView.userInteractionEnabled=YES;
    }

}
-(void)dealloc{
    [listDesk removeAllObjects];
    [listDesk release];
    [listDeskType release];
    [super dealloc];
}
@end
