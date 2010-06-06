//
//  VerticalTabBarCell.h
//  VerticalTabBar
//
//  Created by Nicolas Seriot on 5/8/10.
//  Copyright 2010 seriot.ch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CAGradientLayer;

@interface SEVerticalTabBarCell : UITableViewCell {
	IBOutlet UIImageView *imageView;
	IBOutlet UILabel *titleLabel;
	
	CAGradientLayer *gradientLayer;
	UIViewController *representedViewController;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) CAGradientLayer *gradientLayer;
@property (nonatomic, retain) UIViewController *representedViewController;

@end
