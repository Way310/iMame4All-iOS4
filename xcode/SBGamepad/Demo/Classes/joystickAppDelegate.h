//
//  joystickAppDelegate.h
//
//  Created by Justin Morgenthau on 2/12/10.
//  Copyright BunsenTech, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class joystickViewController;

@interface joystickAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    joystickViewController *viewController;
	
	BOOL gamepadWasEnabled;
}

- (void)initalizeSoundEngine;
- (void)playSound:(int)soundId;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet joystickViewController *viewController;

+ (joystickAppDelegate *)sharedInstance;

@end

