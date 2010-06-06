//
//  VerticalTabBarAppDelegate.m
//  VerticalTabBar
//
//  Created by Nicolas Seriot on 5/8/10.
//  Copyright seriot.ch 2010. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterTVC.h"

@implementation AppDelegate

@synthesize window, splitViewController, verticalTabBarController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    

	// Fill the vertical tab bar controller
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Contents" ofType:@"plist"];
	NSArray *contents = [NSArray arrayWithContentsOfFile:path];
	
	NSMutableArray *viewControllers = [NSMutableArray array];
	
	for(NSDictionary *d in contents) {
		NSString *key = [[d allKeys] lastObject];
		
		MasterTVC *masterTVC = [[[MasterTVC alloc] initWithNibName:@"MasterTVC" bundle:nil] autorelease];
		masterTVC.title = key;
		masterTVC.items = [d objectForKey:key];	
		
		[viewControllers addObject:masterTVC];
	}
	
	verticalTabBarController.viewControllers = viewControllers;	
	
    // Add the split view controller's view to the window and display.
	
	[window addSubview:splitViewController.view];
    [window makeKeyAndVisible];
    
    return YES;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[verticalTabBarController release];
    [splitViewController release];
    [window release];
    [super dealloc];
}

@end

