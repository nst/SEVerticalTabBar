//
//  CountryDetailVC.h
//  VerticalTabBar
//
//  Created by Nicolas Seriot on 5/8/10.
//  Copyright 2010 seriot.ch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailVC : UIViewController <UISplitViewControllerDelegate> {	
	IBOutlet UILabel *label;
	NSObject *representedObject;
}

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) NSObject *representedObject;

@end
