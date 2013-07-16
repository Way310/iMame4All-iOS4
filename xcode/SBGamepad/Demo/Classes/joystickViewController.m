//
//  joystickViewController.m
//
//  Created by Justin Morgenthau on 2/12/10.
//  Copyright BunsenTech, LLC 2010. All rights reserved.
//

#import "joystickViewController.h"
#import "SBJoystick.h"
#import "joystickAppDelegate.h"

@implementation joystickViewController

#pragma mark -
#pragma mark SBJoystickDelegate methods

#define GAMEPAD_ENABLE_KEY @"SBGAMEPAD_ENABLED"


- (void)controlUpdated:(SBJoystick *)joystick
{
    //Check whether the sticks are pressed in and set image accordingly
	joystickIndicatorViewLeft.image = joystick.buttonLStickState ? analogImagePressed : analogImage;
	joystickIndicatorViewRight.image = joystick.buttonRStickState ? analogImagePressed : analogImage;
	
	
    // Convert the joystickVectors into appropriate screen coordinates
	CGPoint p = joystick.leftJoystickVector;
	joystickIndicatorViewLeft.center = CGPointMake(203 + p.x * 30, 202 + p.y * 30);
	p = joystick.rightJoystickVector;
	joystickIndicatorViewRight.center = CGPointMake(317 + p.x * 30, 202 + p.y * 30);
	

    // Store the previous state of buttons 1-4 so we can detect down events
	static BOOL lastB1Status = NO;
	static BOOL lastB2Status = NO;
	static BOOL lastB3Status = NO;
	static BOOL lastB4Status = NO;
	
	if (joystick.button1State && !lastB1Status)
	{
		[[joystickAppDelegate sharedInstance] playSound:1];
	}

	if (joystick.button2State && !lastB2Status)
	{
		[[joystickAppDelegate sharedInstance] playSound:2];
	}

	if (joystick.button3State && !lastB3Status)
	{
		[[joystickAppDelegate sharedInstance] playSound:3];
	}

	if (joystick.button4State && !lastB4Status)
	{
		[[joystickAppDelegate sharedInstance] playSound:4];
	}

	lastB1Status = joystick.button1State;
	lastB2Status = joystick.button2State;
	lastB3Status = joystick.button3State;
	lastB4Status = joystick.button4State;

	Button1IndicatorView.alpha = joystick.button1State ? 1.0 : 0.0;
	Button2IndicatorView.alpha = joystick.button2State ? 1.0 : 0.0;
	Button3IndicatorView.alpha = joystick.button3State ? 1.0 : 0.0;
	Button4IndicatorView.alpha = joystick.button4State ? 1.0 : 0.0;
	
	ButtonUIndicatorView.alpha = joystick.buttonUState ? 1.0 : 0.0;
	ButtonDIndicatorView.alpha = joystick.buttonDState ? 1.0 : 0.0;
	ButtonLIndicatorView.alpha = joystick.buttonLState ? 1.0 : 0.0;
	ButtonRIndicatorView.alpha = joystick.buttonRState ? 1.0 : 0.0;
	
	ButtonStartIndicatorView.alpha = joystick.buttonStartState ? 1.0 : 0.0;
	ButtonSelectIndicatorView.alpha = joystick.buttonSelectState ? 1.0 : 0.0;
	ButtonAnalogIndicatorView.alpha = joystick.buttonModeState ? 1.0 : 0.0;
	
	ButtonL1IndicatorView.alpha = joystick.buttonL1State ? 1.0 : 0.0;
	ButtonL2IndicatorView.alpha = joystick.buttonL2State ? 1.0 : 0.0;
	ButtonR1IndicatorView.alpha = joystick.buttonR1State ? 1.0 : 0.0;
	ButtonR2IndicatorView.alpha = joystick.buttonR2State ? 1.0 : 0.0;
}

// Set up the view after it loads
- (void)viewDidLoad {
    [super viewDidLoad];
    enabledSwitch.enabled = NO;

	analogImage = [[UIImage imageNamed:@"analog.png"] retain];
	analogImagePressed = [[UIImage imageNamed:@"analog-down.png"] retain];
	
	// Set the delegate to receive joystick events
	[SBJoystick sharedInstance].delegate = self;
	
    //Trigger an update of initial status
	[self joystickStatusChanged:[SBJoystick sharedInstance]];
}

// checkGamepadEnabled - Called after audio engine init complete
- (void)checkGamepadEnabled
{
    enabledSwitch.enabled = YES;
	BOOL enable = NO;
	if ([[NSUserDefaults standardUserDefaults] valueForKey:GAMEPAD_ENABLE_KEY] != nil)
	{
		enable = [[NSUserDefaults standardUserDefaults] boolForKey:GAMEPAD_ENABLE_KEY];
	}
	enabledSwitch.on = enable;
	[SBJoystick sharedInstance].enabled = enable;
}

- (IBAction)enableChanged:(id)sender
{
	[SBJoystick sharedInstance].enabled = enabledSwitch.on;
	[[NSUserDefaults standardUserDefaults] setBool:enabledSwitch.on forKey:GAMEPAD_ENABLE_KEY];
	[[NSUserDefaults standardUserDefaults] synchronize];	  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)joystickStatusChanged:(SBJoystick *)joystick
{
	if (joystick.enabled)
	{
		if (!joystick.joystickConnected)
		{
			statusLabel.text = @"No Hardware Connected.";
		}
		else 
		{
			statusLabel.text = @"Monitoring Gamepad";
		}
	}
	else
	{
		statusLabel.text = @"Disabled";
	}
}

@end
