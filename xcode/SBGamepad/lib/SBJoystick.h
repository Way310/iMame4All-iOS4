//
//  SixtyBeat.h
//  SixtyBeat
//
//  Created by Justin Morgenthau on 2/12/10.
//  Copyright 2010 BunsenTech, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioUnit/AudioUnit.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SBControlScheme.h"

@class SBJoystick;
@protocol SBJoystickDelegate <NSObject>

- (void)controlUpdated:(SBJoystick *)joystick;
- (void)joystickStatusChanged:(SBJoystick *)joystick;

@optional
- (BOOL)shouldCheckForGamepad:(SBJoystick *)joystick;
- (void)checksumFailed:(SBJoystick *)joystick;

@end

@interface SBJoystick : NSObject <AVAudioSessionDelegate> {

}

////// PUBLIC PROPERTIES //////
@property (nonatomic, retain) id <SBJoystickDelegate,NSObject> delegate;
@property (readonly) BOOL isListening;
@property (readonly) BOOL joystickConnected;
@property (readonly) BOOL headsetConnected;

@property(readonly) CGPoint leftJoystickVector;
@property(readonly) CGPoint rightJoystickVector;

@property(readonly) BOOL button1State;
@property(readonly) BOOL button2State;
@property(readonly) BOOL button3State;
@property(readonly) BOOL button4State;

@property(readonly) BOOL buttonUState;
@property(readonly) BOOL buttonDState;
@property(readonly) BOOL buttonLState;
@property(readonly) BOOL buttonRState;

@property(readonly) BOOL buttonStartState;
@property(readonly) BOOL buttonSelectState;
@property(readonly) BOOL buttonModeState;

@property(readonly) BOOL buttonL1State;
@property(readonly) BOOL buttonL2State;
@property(readonly) BOOL buttonR1State;
@property(readonly) BOOL buttonR2State;

@property(readonly) BOOL buttonRStickState;
@property(readonly) BOOL buttonLStickState;



@property (nonatomic, assign) BOOL allowMixing;
@property (nonatomic, assign) BOOL loggingEnabled;
@property (nonatomic, assign) BOOL enabled;
		   
@property (nonatomic, retain) SBControlScheme *currentControlScheme;

////// PUBLIC METHODS //////
+ (SBJoystick *)sharedInstance;

- (BOOL)buttonStateForControl:(SBCONTROLS_E)control;
- (BOOL)buttonStateForControlTag:(int)tag;
- (CGPoint)analogVectorForControlTag:(int)tag;



@end
