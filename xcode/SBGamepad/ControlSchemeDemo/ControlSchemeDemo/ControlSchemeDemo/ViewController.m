//
//  ViewController.m
//  ControlSchemeDemo
//
//  Created by Justin Morgenthau on 12/12/11.
//  Copyright (c) 2011 BunsenTech, LLC. All rights reserved.
//

#import "ViewController.h"
#import "SBJoystick.h"
#import "SBControlSchemeView.h"
#import "MainView.h"

//#import "SBControlScheme.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


//Control Tags
typedef enum
{
	CONTROL_TAG_MOVE,
	CONTROL_TAG_GROW,
	CONTROL_TAG_SHRINK,
	CONTROL_TAG_ROTATE,
	CONTROL_TAG_COLOR,
	CONTROL_TAG_FIRE,
} CONTROL_TAGS_E;

- (void)viewDidLoad
{
    [super viewDidLoad];
	[NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
	
	schemes = [[NSMutableArray arrayWithCapacity:3] retain];
	
	SBControlScheme *scheme;
	scheme = [[[SBControlScheme alloc] init] autorelease];
	scheme.name = @"Default Controls";
	[scheme addAssignmentForControl:LEFT_STICK tag:CONTROL_TAG_MOVE label:@"Move"];
	[scheme addAssignmentForControl:RIGHT_STICK tag:CONTROL_TAG_ROTATE label:@"Rotate"];
	[scheme addAssignmentForControl:BUTTON_1 tag:CONTROL_TAG_GROW label:@"Grow"];
	[scheme addAssignmentForControl:BUTTON_2 tag:CONTROL_TAG_SHRINK label:@"Shrink"];
	[scheme addAssignmentForControl:BUTTON_3 tag:CONTROL_TAG_COLOR label:@"Change Color"];
	[schemes addObject:scheme];
	
	scheme = [[[SBControlScheme alloc] init] autorelease];
	scheme.name = @"Alternate Controls";
	[scheme addAssignmentForControl:RIGHT_STICK tag:CONTROL_TAG_MOVE label:@"Move"];
	[scheme addAssignmentForControl:LEFT_STICK tag:CONTROL_TAG_ROTATE label:@"Rotate"];
	[scheme addAssignmentForControl:BUTTON_UP tag:CONTROL_TAG_GROW label:@"Grow"];
	[scheme addAssignmentForControl:BUTTON_DOWN tag:CONTROL_TAG_SHRINK label:@"Shrink"];
	[scheme addAssignmentForControl:BUTTON_R3 tag:CONTROL_TAG_COLOR label:@"Change Color"];
	[scheme addAssignmentForControl:BUTTON_R2 tag:CONTROL_TAG_GROW label:@"Grow"];
	[scheme addAssignmentForControl:BUTTON_L2 tag:CONTROL_TAG_SHRINK label:@"Shrink"];
	[schemes addObject:scheme];
	
	[SBJoystick sharedInstance].currentControlScheme = [schemes objectAtIndex:0];
	
}

static const CGFloat kScaleRate = 2.0;
static const CGFloat kColorRate = 0.25;
static const CGFloat kMoveRate = 250.0;
static const CGFloat kSpinRate = 5.0;

- (void)update
{
	static NSTimeInterval lastTime = 0;
	NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
	if (lastTime != 0)
	{
		NSTimeInterval dt = now - lastTime;
		
		MainView *mainView = (MainView *)self.view;
		
		BOOL fireButtonIsPressed = [[SBJoystick sharedInstance] buttonStateForControlTag:CONTROL_TAG_FIRE];

		NSLog(@"f%d", fireButtonIsPressed);
		
		if ([[SBJoystick sharedInstance] buttonStateForControlTag:CONTROL_TAG_GROW])
		{
			[mainView scale:kScaleRate * dt];
		}

		if ([[SBJoystick sharedInstance] buttonStateForControlTag:CONTROL_TAG_SHRINK])
		{
			[mainView scale:-kScaleRate * dt];
		}

		if ([[SBJoystick sharedInstance] buttonStateForControlTag:CONTROL_TAG_COLOR])
		{
			[mainView color:kColorRate * dt];
		}

		CGPoint moveVector = [[SBJoystick sharedInstance] analogVectorForControlTag:CONTROL_TAG_MOVE];
		
		[mainView moveby:CGPointMake(kMoveRate * moveVector.x * dt,
									 kMoveRate * moveVector.y * dt)];

		CGPoint rotateVector = [[SBJoystick sharedInstance] analogVectorForControlTag:CONTROL_TAG_ROTATE];
		[mainView spin:rotateVector.x * kSpinRate * dt];
	}
	
	lastTime = now;
		
}

- (IBAction)schemePressed:(id)sender {
		
	SBControlSchemeView *v = [[SBControlSchemeView alloc] initWithSchemes:schemes];
	[v setBackground:@"blue"];
	[self.view addSubview:v];
	[v release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
