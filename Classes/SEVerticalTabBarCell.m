//
//  VerticalTabBarCell.m
//  VerticalTabBar
//
//  Created by Nicolas Seriot on 5/8/10.
//  Copyright 2010 seriot.ch. All rights reserved.
//

#import "SEVerticalTabBarCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation SEVerticalTabBarCell

@synthesize imageView, titleLabel, representedViewController, gradientLayer;

+ (CAGradientLayer *)gradientLayerWithBounds:(CGRect)rect {
	// same gradient as Apple's UITabBar
	UIColor *backgroundColor = [UIColor colorWithRed:37/255. green:37/255. blue:37/255. alpha:1.0];
	UIColor *inColor = [UIColor colorWithRed:54/255. green:54/255. blue:54/255. alpha:1.0];
	UIColor *outColor = [UIColor colorWithRed:73/255. green:73/255. blue:73/255. alpha:1.0];

	CAGradientLayer *gl = [CAGradientLayer layer];		
	gl.frame = rect;
	gl.backgroundColor = [backgroundColor CGColor];
	gl.colors = [NSArray arrayWithObjects:
				 (id)[backgroundColor CGColor],
				 (id)[backgroundColor CGColor],
				 (id)[inColor CGColor],
				 (id)[outColor CGColor], nil];
	gl.locations = [NSArray arrayWithObjects:
					[NSNumber numberWithDouble:0.0],
					[NSNumber numberWithDouble:0.5],
					[NSNumber numberWithDouble:0.5],
					[NSNumber numberWithDouble:1.0], nil];
	gl.startPoint = CGPointMake(0.0, 0.5);
	gl.endPoint   = CGPointMake(1.0, 0.5);
	gl.masksToBounds = YES;
	gl.cornerRadius = 5.0;
	
	return gl;
}

- (void)setRepresentedViewController:(UIViewController *)vc {
	[representedViewController autorelease];
	representedViewController = [vc retain];
	
	titleLabel.text = representedViewController.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
	NSString *title = [representedViewController.title lowercaseString];
	NSString *imageName = selected ? [title stringByAppendingString:@"_selected"] : title;
	imageName = [imageName stringByAppendingPathExtension:@"png"];
	
	if(selected) {
		if(!gradientLayer) {
			CGFloat xOffset = 6.0;
			CGFloat yOffset = 15.0;
			CGRect rect = CGRectMake(self.bounds.origin.x + xOffset, self.bounds.origin.y + yOffset, self.bounds.size.width - 2*xOffset, self.bounds.size.height - 2*yOffset);
			self.gradientLayer = [SEVerticalTabBarCell gradientLayerWithBounds:rect];
		}
		
		[self.layer insertSublayer:gradientLayer atIndex:0];
	} else {
		[gradientLayer removeFromSuperlayer];
		
		self.layer.backgroundColor = NULL;
		self.layer.masksToBounds = NO;
		self.layer.cornerRadius = 0.0;			
	}
	
	imageView.image = [UIImage imageNamed:imageName];
}

- (void)dealloc {
	[gradientLayer release];
	[representedViewController release];
	[imageView release];
	[titleLabel release];
    [super dealloc];
}

@end
