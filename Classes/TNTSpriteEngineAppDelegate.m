//
//  TNTSpriteEngineAppDelegate.m
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright TNTpixel 2010. All rights reserved.
//

#import "TNTSpriteEngineAppDelegate.h"
#import "TNTSpriteEngineViewController.h"

#define LOOP_TIMER_MINIMUM 0.033f
#define IPHONE_HEIGHT 480
#define IPHONE_WIDTH 320
#define IPAD_WIDTH 768
#define IPAD_HEIGHT 1024

@implementation TNTSpriteEngineAppDelegate

@synthesize window;
@synthesize viewController;

#pragma mark -
#pragma mark Game lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    // Override point for customization after app launch    
	
	startMapName = @"lvl1_idx";
	currentMapName = startMapName;
	
	//allocate global resource manager.  This is not strictly necessary, as intialize will be called before anything else when
	//resourceManager is first used, but we put it here to pre-load and setup sound stuff so that we don't get an unexpected lag later.
	[ResourceManager initialize];	
	
	
	//set up main loop
	[NSTimer scheduledTimerWithTimeInterval:LOOP_TIMER_MINIMUM target:self selector:@selector(gameLoop:) userInfo:nil repeats:NO];
	
	m_lastUpdateTime = [[NSDate date] timeIntervalSince1970];
	
	m_FPS_lastSecondStart = m_lastUpdateTime;
	m_FPS_framesThisSecond = 0;	
	
	//set up our first state
	[self doStateChange:[GSMain class]];
}

- (void) gameLoop: (id) sender {
	double currTime = [[NSDate date] timeIntervalSince1970];
	
	[((GameState*)viewController.gameView) update];
	[((GameState*)viewController.gameView) render];
	
	m_FPS_framesThisSecond++;
	float timeThisSecond = currTime - m_FPS_lastSecondStart;
	if( timeThisSecond > 1.0f ) {
		m_estFramesPerSecond = m_FPS_framesThisSecond;
		m_FPS_framesThisSecond = 0;
		m_FPS_lastSecondStart = currTime;
	}
	
	float sleepPeriod = LOOP_TIMER_MINIMUM;	
	[NSTimer scheduledTimerWithTimeInterval:sleepPeriod target:self selector:@selector(gameLoop:) userInfo:nil repeats:NO];	
	m_lastUpdateTime = currTime;
}

- (float) getFramesPerSecond
{
	return m_estFramesPerSecond;
}

- (void)doStateChange: (Class)state {	
	if( viewController.gameView != nil ) {
		[viewController.gameView removeFromSuperview]; //remove view from window's subviews.
		[viewController.gameView release]; //release gamestate 
	}
	
	viewController.gameView = [[state alloc]  initWithFrame:CGRectMake(0, 0, 768, 576) andManager:self andMap:currentMapName];
	[viewController.view setBackgroundColor:[UIColor blackColor]];
	[viewController.view addSubview:viewController.gameView];
	
	// Just to be on the safe side
	if ([viewController.gameView conformsToProtocol:@protocol(DPadDelegate)]){
		[viewController.dpad setDelegate:(<DPadDelegate>)viewController.gameView];
	}
	
	//now set our view as visible
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
