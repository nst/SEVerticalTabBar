//
//  CountriesTVC.m
//  VerticalTabBar
//
//  Created by Nicolas Seriot on 5/8/10.
//  Copyright 2010 seriot.ch. All rights reserved.
//

#import "MasterTVC.h"
#import "DetailVC.h"

extern NSString * const kSEChangeDetailViewControllerNotification;

@implementation MasterTVC

@synthesize items, countryDetailVC, selectedIndexPath;

- (void)dealloc {
	[selectedIndexPath release];
	[countryDetailVC release];
	[items release];
    [super dealloc];
}

#pragma mark -
#pragma mark View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.title = @"Countries";
		self.items = [NSArray arrayWithObjects:@"france", @"usa", @"canada", @"china", nil];
		self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	if([self.tableView.delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
		[self.tableView.delegate tableView:self.tableView willSelectRowAtIndexPath:selectedIndexPath];
	}

	[self.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

	if([self.tableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
		[self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:selectedIndexPath];
	}	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {	
	self.selectedIndexPath = indexPath;
	
	[[NSNotificationCenter defaultCenter] postNotificationName:kSEChangeDetailViewControllerNotification object:countryDetailVC userInfo:nil];	
	countryDetailVC.representedObject = [items objectAtIndex:indexPath.row];
}

@end
