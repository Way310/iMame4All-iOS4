//
//  MainView.h
//  ControlSchemeDemo
//
//  Created by Justin Morgenthau on 12/12/11.
//  Copyright (c) 2011 BunsenTech, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView : UIView
{
	CGFloat color;
	
	UIView *actor;
	
	CGFloat rotation;
	CGFloat scale;
	CGPoint position;
}

- (void)scale:(CGFloat)amount;
- (void)spin:(CGFloat)amount;
- (void)color:(CGFloat)amount;
- (void)moveby:(CGPoint)dp;



@end
