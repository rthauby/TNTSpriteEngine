//
//  GameStateManager.m
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "GameStateManager.h"


@implementation GameStateManager

@synthesize currentMapName, startMapName;

- (void) doStateChange: (Class) state
{
	
}

- (void) gameLoop: (id) sender {

}

- (float) getFramesPerSecond
{
	return m_estFramesPerSecond;
}

- (void)dealloc {
	[currentMapName, startMapName release];
	[super dealloc];
}

@end
