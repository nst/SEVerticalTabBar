//
//  VerticalTabBarAppDelegate.h
//  VerticalTabBar
//
//  Created by Nicolas Seriot on 5/8/10.
//  Copyright seriot.ch 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEVerticalTabBarController.h"

@class SEVerticalTabBarController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    
    UISplitViewController *splitViewController;
    
    SEVerticalTabBarController *verticalTabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet SEVerticalTabBarController *verticalTabBarController;

@end
