//
//  joystickAppDelegate.m
//
//  Created by Justin Morgenthau on 2/12/10.
//  Copyright BunsenTech, LLC 2010. All rights reserved.
//

#import "joystickAppDelegate.h"
#import "joystickViewController.h"
#import "SBJoystick.h"
#import "CocosDenshion.h"
#import "CDAudioManager.h"

@implementation joystickAppDelegate

@synthesize window;
@synthesize viewController;

+ (joystickAppDelegate *)sharedInstance
{
	return (joystickAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {    

	[application setIdleTimerDisabled:YES];
	
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	window.backgroundColor = [UIColor blackColor];
	
	[self initalizeSoundEngine];
}

-(void) loadSoundBuffers:(NSObject*) data {
    //NOTE: This is standard initialization of the cocos-dension sound engine
	
	//Wait for the audio manager if it is not initialised yet
	while ([CDAudioManager sharedManagerState] != kAMStateInitialised) {
		[NSThread sleepForTimeInterval:0.1];
	}	
	
	//Use: afconvert -f caff -d ima4 yourfile.wav to create an ima4 compressed version of a wave file
	CDSoundEngine *sse = [CDAudioManager sharedManager].soundEngine;
	
	NSArray *defs = [NSArray arrayWithObjects:
					 [NSNumber numberWithInt:8],
					 nil];
	[sse defineSourceGroups:defs];
	
	//Load sound buffers asynchrounously
	NSMutableArray *loadRequests = [[[NSMutableArray alloc] init] autorelease];
	for (int i=1; i<=4; i++)
	{
		[loadRequests addObject:[[[CDBufferLoadRequest alloc] init:i filePath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"sound%d.wav", i] ofType:nil]] autorelease]];
	}
	[sse loadBuffersAsynchronously:loadRequests];
	
	//Sound engine is now set up. You can check the functioning property to see if everything worked.
	//In addition the loadBuffer method returns a boolean indicating whether it worked.
	//If your buffers loaded and the functioning = TRUE then you are set to play sounds.
	
    // Now that sound engine init is complete, we can check whether the gamepad is enabled
	[viewController checkGamepadEnabled];
}

- (void)initalizeSoundEngine
{
	//Set up mixer rate for sound engine before CDAudioManager is initialised
	[CDSoundEngine setMixerSampleRate:CD_SAMPLE_RATE_MID];
	
	NSLog(@"init audio.");
	//Initialise audio manager asynchronously as it can take a few seconds
	[CDAudioManager initAsynchronously:kAMM_FxPlusMusicIfNoOtherAudio];
	
	if ([CDAudioManager sharedManagerState] != kAMStateInitialised) {
		//The audio manager is not initialised yet so kick off the sound loading as an NSOperation that will wait for
		//the audio manager
		NSInvocationOperation* bufferLoadOp = [[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadSoundBuffers:) object:nil] autorelease];
		NSOperationQueue *opQ = [[[NSOperationQueue alloc] init] autorelease]; 
		[opQ addOperation:bufferLoadOp];
	} else {
		[self loadSoundBuffers:nil];
	}	
}

- (void)playSound:(int)soundId
{
	[[CDAudioManager sharedManager].soundEngine playSound:soundId sourceGroupId:0 pitch:1.0 pan:0.0 gain:1.0 loop:NO];	
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [SBJoystick sharedInstance].enabled = NO;    
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

@end
