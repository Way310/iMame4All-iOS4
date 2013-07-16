//
//  SBControlScheme.h
//  joystick
//
//  Created by Justin Morgenthau on 12/9/11.
//  Copyright (c) 2011 BunsenTech, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// Definitions for all of the controls on the controller
typedef enum
{
	LEFT_STICK,
	RIGHT_STICK,
	
	BUTTON_1,
	BUTTON_2,
	BUTTON_3,
	BUTTON_4,
	
	BUTTON_UP,   //D-Pad Up
	BUTTON_DOWN, //D-Pad Down
	BUTTON_LEFT, //D-Pad Left
	BUTTON_RIGHT,//D-Pad Right
	
	BUTTON_L1, //Top Left Shoulder Button
	BUTTON_L2, //Bottom Left Shoulder Button
	BUTTON_L3, //Pushing in on left stick
	BUTTON_R1, //Top Right Shoulder Button
	BUTTON_R2, //Bottom Right Shoulder Button
	BUTTON_R3, //Pushing in on right stick
	
	BUTTON_START,
	BUTTON_SELECT,
	BUTTON_MODE,
} SBCONTROLS_E;


@interface SBControlAssignment : NSObject
@property(nonatomic,assign) SBCONTROLS_E control;
@property(nonatomic,assign) NSInteger tag;
@property(nonatomic,copy)  NSString *label;
@end

@interface SBControlScheme : NSObject

@property (nonatomic,assign) NSString *name;


/***************************************************************
 * addAssignmentForControl: tag: label:
 *   Adds a control assignment.
 **************************************************************/
- (void)addAssignmentForControl:(SBCONTROLS_E)control tag:(NSInteger)tag label:(NSString*)label;


/***************************************************************
 * assignments
 *   Returns an array of SBControlAssignment objects 
 * representing the control assignments within the scheme.
 **************************************************************/
- (NSArray *)assignments;


/***************************************************************
 * controlNameFromEnum:
 *   Returns the name of the specified control enum. used
 * primarily for debugging purposes.
 **************************************************************/
+ (NSString *)controlNameFromEnum:(SBCONTROLS_E)control;


@end
