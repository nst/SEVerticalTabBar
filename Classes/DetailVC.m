//
//  CountryDetailVC.m
//  VerticalTabBar
//
//  Created by Nicolas Seriot on 5/8/10.
//  Copyright 2010 seriot.ch. All rights reserved.
//

#import "DetailVC.h"


@implementation DetailVC

@synthesize label, representedObject;

- (void)setRepresentedObject:(NSObject *)o {
	[representedObject autorelease];
	representedObject = [o retain];
	
	label.text = [o description];
	
	self.title = [o description];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)dealloc {
	[label release];
	[representedObject release];
    [super dealloc];
}

@end
