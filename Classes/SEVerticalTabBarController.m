//
//  SEVerticalTabBarController.m
//  VerticalTabBar
//
//  Created by Nicolas Seriot on 5/8/10.
//  Copyright 2010 seriot.ch. All rights reserved.
//

#import "SEVerticalTabBarController.h"
#import "SEVerticalTabBarCell.h"

NSString * const kSEChangeDetailViewControllerNotification = @"SEVerticalTabBarController_ChangeDetailViewControllerNotification";

@implementation SEVerticalTabBarController

@synthesize tabBarTableView, selectedViewController, viewControllers, verticalTabBarControllerDelegate, splitViewController;

- (void)loadView {
    [super loadView];

	self.tabBarTableView.separatorStyle = UITableViewCellSelectionStyleNone;
	self.tabBarTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"VerticalTabBarGradient.png"]];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(changeDetailViewController:)
												 name:kSEChangeDetailViewControllerNotification
											   object:nil];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kSEChangeDetailViewControllerNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];	

	NSIndexPath *ip = self.tabBarTableView.indexPathForSelectedRow;
	if(ip) return;
	
	if(selectedViewController) {
		NSUInteger index = [self.viewControllers indexOfObject:selectedViewController];
		if(index != NSNotFound) ip = [NSIndexPath indexPathForRow:index inSection:0];
	}
	
	if(!ip) ip = [NSIndexPath indexPathForRow:0 inSection:0];
	
	[self tableView:tabBarTableView willSelectRowAtIndexPath:ip];
	[self.tabBarTableView selectRowAtIndexPath:ip animated:NO scrollPosition:UITableViewScrollPositionNone];
	[self tableView:tabBarTableView didSelectRowAtIndexPath:ip];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)dealloc {
	[splitViewController release];
	[selectedViewController release];
	[tabBarTableView release];
	[viewControllers release];
    [super dealloc];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [viewControllers count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SEVerticalTabBarCell";
    
    SEVerticalTabBarCell *cell = (SEVerticalTabBarCell *)[aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = (SEVerticalTabBarCell *)[[[NSBundle mainBundle] loadNibNamed:@"SEVerticalTabBarCell" owner:self options:nil] lastObject];
	}
	
	UIViewController *vc = [viewControllers objectAtIndex:indexPath.row];
	
	cell.representedViewController = vc;
	
    return cell;
}

#pragma mark UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UIViewController *vc = [viewControllers objectAtIndex:indexPath.row];
	if(verticalTabBarControllerDelegate && ![verticalTabBarControllerDelegate tabBarController:self shouldSelectViewController:vc]) return nil;	
	return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[selectedViewController viewWillDisappear:NO];
	[selectedViewController.view removeFromSuperview];
	[selectedViewController viewDidDisappear:NO];
		
	self.selectedViewController = [viewControllers objectAtIndex:indexPath.row];
	
	[verticalTabBarControllerDelegate tabBarController:self didUnselectViewController:selectedViewController];
	
	CGRect rect = CGRectMake(tabBarTableView.bounds.size.width,
							 0,
							 self.view.bounds.size.width - tabBarTableView.bounds.size.width,
							 self.view.bounds.size.height);
	
	selectedViewController.view.frame = rect;
	
	[self.view addSubview:selectedViewController.view];
	[selectedViewController viewWillAppear:NO];
	[selectedViewController viewDidAppear:NO];
	
	self.title = selectedViewController.title;
	
	[verticalTabBarControllerDelegate tabBarController:self didSelectViewController:selectedViewController];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat tabBarHeight = [UIScreen mainScreen].bounds.size.width - 44 - 20 - 35;
	return tabBarHeight / [viewControllers count];
}

#pragma mark notification

- (void)changeDetailViewController:(NSNotification *)aNotification {
	
	UIViewController *newVC = (UIViewController *)[aNotification object];	
	UIViewController *oldVC = [splitViewController.viewControllers lastObject];
	
	if(newVC == oldVC/* && [oldVC representedObject] == [newVC representedObject]*/) return;
	
	UIViewController *leftVC = [splitViewController.viewControllers objectAtIndex:0];

	[oldVC viewWillDisappear:YES];
	[oldVC viewDidDisappear:YES];
	
	[newVC viewWillAppear:YES];
	splitViewController.viewControllers = [NSArray arrayWithObjects:leftVC, newVC, nil];
	[newVC viewDidAppear:YES];
}

@end
