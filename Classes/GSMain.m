//
//  GSMain.m
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "GSMain.h"

@implementation GSMain

#define MARGIN_FOR_MIGRATION 16.0
#define DISTANCE_AFTER_MIGRATING 32.0

-(GSMain *)initWithFrame:(CGRect)frame andManager:(GameStateManager *)pManager andMap:(NSString *)mapName {
	if (self = [super initWithFrame:frame andManager:pManager]) {
		// Initializtion code
		migrating = false;
		playerStartingPoint = CGPointMake(0, 0);
		currentMap = [[NSMutableString alloc] init];
		north = [[NSMutableString alloc] init];
		east = [[NSMutableString alloc] init];
		south = [[NSMutableString alloc] init];
		west = [[NSMutableString alloc] init];
		[self setGameStateMap:mapName];
		
		hud = [[HUD alloc] initWithFrame:CGRectMake(16, 528, 162, 32)];
		[hud tilesFromImage:@"hearts.png"];
		
		tileWorld = [[TileWorld alloc] initWithFrame:self.frame];
		[tileWorld loadLevel:[NSString stringWithFormat:@"%@.csv",mapName] withTiles:@"tilemap_32.png"];
		
		Animation* playerAnim = [[Animation alloc] initWithAnim:@"player.png"];
		player = [[Player alloc] initWithPos:playerStartingPoint sprite:[Sprite spriteWithAnimation:playerAnim]];
		[tileWorld addEntity:player];
		
		[tileWorld setCamera:CGPointMake(0, 0)];
	}
	
	return self;
}

- (void) setGameStateMap:(NSString *)map {
	[currentMap setString:map];
	NSDictionary *maps = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Maps" ofType:@"plist"]] valueForKey:map];
	[north setString:[maps valueForKey:@"north"]];
	[east setString:[maps valueForKey:@"east"]];
	[south setString:[maps valueForKey:@"south"]];
	[west setString:[maps valueForKey:@"west"]];
}

- (void)update {
	// Generally, everything should go in here
	if (!migrating) {
		
		float time = 0.033f;
		[player update:time];
		[tileWorld setCamera:[player originPos]];
		
		if (player.worldPos.x < MARGIN_FOR_MIGRATION && ![west isEqualToString:@""]) {
			
			[self prepareNewLevel:west];
			playerStartingPoint = CGPointMake((self.frame.size.width - DISTANCE_AFTER_MIGRATING), player.worldPos.y);
			
		} else if(player.worldPos.x > (self.frame.size.width - MARGIN_FOR_MIGRATION) && ![east isEqualToString:@""]) {
			
			[self prepareNewLevel:east];
			playerStartingPoint = CGPointMake(DISTANCE_AFTER_MIGRATING, player.worldPos.y);
			
		} else if (player.worldPos.y < MARGIN_FOR_MIGRATION && ![south isEqualToString:@""]) {
			
			[self prepareNewLevel:south];
			playerStartingPoint = CGPointMake(player.worldPos.x, (self.frame.size.height - DISTANCE_AFTER_MIGRATING));
			
		} else if(player.worldPos.y > (self.frame.size.height - MARGIN_FOR_MIGRATION) && ![north isEqualToString:@""]) {
			
			[self prepareNewLevel:north];
			playerStartingPoint = CGPointMake(player.worldPos.x, DISTANCE_AFTER_MIGRATING);
			
		}
	}
}

- (void)prepareNewLevel:(NSString *)level {
	migrating = true;
	[self setGameStateMap:level];
	[self fadeOut];
}

- (void)doneMigrating {
	migrating = false;
}

- (void)fadeIn {
	[player forceToPos:playerStartingPoint];
	[tileWorld loadLevel:[NSString stringWithFormat:@"%@.csv",currentMap] withTiles:@"tilemap_32.png"];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:YES];
	[UIView setAnimationDidStopSelector:@selector(doneMigrating)];
	
	self.alpha = 1.0;
	
	[UIView commitAnimations];
}

- (void)fadeOut {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:YES];
	[UIView setAnimationDidStopSelector:@selector(fadeIn)];
	
	self.alpha = 0.0;
	
	[UIView commitAnimations];
}

- (void)render {
	//clear anything left over from the last frame, and set background color.
	//glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	glClearColor(0xff/256.0f, 0x66/256.0f, 0x00/256.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);

	[tileWorld draw];
	hud.health = player.health;
	hud.maxHealth = player.maxHealth;
	[hud draw];
	
	//you get a nice boring white screen if you forget to swap buffers.
	[self swapBuffers];
}

- (void) moveTo:(CGPoint)point {
	if(!migrating){
		[player moveToRelativePosition:point];
	}
}

- (void)dealloc {
	[currentMap release];
	[hud release];
	[north, east, south, west release];
	[super dealloc];
}

@end
