//
//  joystickViewController.h
//
//  Created by Justin Morgenthau on 2/12/10.
//  Copyright BunsenTech, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJoystick.h"

@interface joystickViewController : UIViewController <SBJoystickDelegate>
{
	IBOutlet UILabel *statusLabel;

	IBOutlet UIImageView *joystickIndicatorViewLeft;
	IBOutlet UIImageView *joystickIndicatorViewRight;

	IBOutlet UIView *Button1IndicatorView;
	IBOutlet UIView *Button2IndicatorView;
	IBOutlet UIView *Button3IndicatorView;
	IBOutlet UIView *Button4IndicatorView;

	IBOutlet UIView *ButtonUIndicatorView;
	IBOutlet UIView *ButtonDIndicatorView;
	IBOutlet UIView *ButtonLIndicatorView;
	IBOutlet UIView *ButtonRIndicatorView;

	IBOutlet UIView *ButtonStartIndicatorView;
	IBOutlet UIView *ButtonSelectIndicatorView;
	IBOutlet UIView *ButtonAnalogIndicatorView;

	IBOutlet UIView *ButtonL1IndicatorView;
	IBOutlet UIView *ButtonL2IndicatorView;
	IBOutlet UIView *ButtonR1IndicatorView;
	IBOutlet UIView *ButtonR2IndicatorView;
	
	UIImage *analogImage;
	UIImage *analogImagePressed;
    
	IBOutlet UISwitch *enabledSwitch;
}

- (IBAction)enableChanged:(id)sender;

- (void)checkGamepadEnabled;

@end

