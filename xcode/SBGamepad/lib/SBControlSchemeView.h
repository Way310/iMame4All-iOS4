//
//  SBControlSchemeView.h
//  joystick
//
//  Created by Justin Morgenthau on 12/9/11.
//  Copyright (c) 2011 BunsenTech, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBControlSchemeView : UIView

/***************************************************************
 * initWithFrame: schemes:
 *   Initializes a Control Scheme View with the specified 
 * schemes.  The view is sized automatically.
 **************************************************************/
- (id)initWithSchemes:(NSArray *)schemes;

/***************************************************************
 * setBackground:
 *   Sets the background color for the view.  Currently 
 * supported values include:
 *	black, blue, dark_blue, gray, green, pink, red, white
 *
 * To use a custom background, modify one of the 
 * window_background_*.png files in SBGamepad.bundle.
 **************************************************************/
- (void)setBackground:(NSString *)background;


/***************************************************************
 * close
 *   Closes the control scheme view, selecting the displayed
 * scheme.
 **************************************************************/
- (void)close;


@end
