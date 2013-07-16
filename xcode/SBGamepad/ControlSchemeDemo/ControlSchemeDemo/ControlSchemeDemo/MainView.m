//
//  MainView.m
//  ControlSchemeDemo
//
//  Created by Justin Morgenthau on 12/12/11.
//  Copyright (c) 2011 BunsenTech, LLC. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (void)updateActor
{
	actor.center = position;
	
	CGAffineTransform t = CGAffineTransformMakeRotation(rotation);
	t = CGAffineTransformScale(t, scale, scale);
	actor.transform = t;
	
	actor.backgroundColor = [UIColor colorWithHue:color saturation:1.0 brightness:1.0 alpha:1.0];
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	self.backgroundColor = [UIColor whiteColor];
	
	actor = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 10, self.frame.size.width / 10)];
	actor.backgroundColor = [UIColor redColor];
	[self addSubview:actor];
	scale = 1.0;
	color = 0.0;
	[self updateActor];
	
}

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
	NSLog(@"view frame size %f %f", self.frame.size.width, self.frame.size.height);
	position = CGPointMake(self.frame.size.height / 2, self.frame.size.width / 2);
	[self updateActor];
}

- (void)scale:(CGFloat)amount
{
	scale += amount;
	if (scale < 0.1) scale = 0.1;
	if (scale > 3.0) scale = 3.0;
	[self updateActor];
}

- (void)spin:(CGFloat)amount
{
	rotation += amount;
	[self updateActor];
}

- (void)color:(CGFloat)amount
{
	color += amount;
	while (color > 1.0) color -= 1.0;
	while (color < 0.0) color += 1.0;
	[self updateActor];
}

- (void)moveby:(CGPoint)dp
{
	position = CGPointMake(position.x + dp.x, position.y + dp.y);
	if (position.x < 0) position.x = 0;
	if (position.x > self.frame.size.height) position.x = self.frame.size.height;
	if (position.y < 0) position.y = 0;
	if (position.y > self.frame.size.width) position.y = self.frame.size.width;
	[self updateActor];
}



@end
