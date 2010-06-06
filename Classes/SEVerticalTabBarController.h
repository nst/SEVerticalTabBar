//
//  SEVerticalTabBarController.h
//  VerticalTabBar
//
//  Created by Nicolas Seriot on 5/8/10.
//  Copyright 2010 seriot.ch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SEVerticalTabBarController;

@protocol SEVerticalTabBarControllerDelegate
- (BOOL)tabBarController:(SEVerticalTabBarController *)vtbc shouldSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(SEVerticalTabBarController *)vtbc didSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(SEVerticalTabBarController *)vtbc didUnselectViewController:(UIViewController *)viewController;
@end

// To change the detail view controller, post kSEChangeDetailViewControllerNotification
// notification with the view controller to display as the notification object, such as:
// [[NSNotificationCenter defaultCenter] postNotificationName:kSEChangeDetailViewControllerNotification object:detailVC userInfo:nil];

@interface SEVerticalTabBarController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	IBOutlet UITableView *tabBarTableView;
	IBOutlet UISplitViewController *splitViewController;

	NSArray *viewControllers;
	UIViewController *selectedViewController;
	
	id <SEVerticalTabBarControllerDelegate> verticalTabBarControllerDelegate;
}

@property (nonatomic, retain) UITableView *tabBarTableView;
@property (nonatomic, retain) UIViewController *selectedViewController;
@property (nonatomic, retain) NSArray *viewControllers;
@property (nonatomic, assign) id <SEVerticalTabBarControllerDelegate> verticalTabBarControllerDelegate;
@property (nonatomic, assign) UISplitViewController *splitViewController;

@end
