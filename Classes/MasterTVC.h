//
//  CountriesTVC.h
//  VerticalTabBar
//
//  Created by Nicolas Seriot on 5/8/10.
//  Copyright 2010 seriot.ch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailVC;

@interface MasterTVC : UITableViewController {
	NSArray *items;
	IBOutlet DetailVC *countryDetailVC;
	NSIndexPath *selectedIndexPath;
}

@property (nonatomic, retain) NSArray *items;
@property (nonatomic, retain) DetailVC *countryDetailVC;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;

@end
