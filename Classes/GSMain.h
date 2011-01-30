//
//  GSMain.h
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLESGameState.h"
#import "TileWorld.h"
#import "ResourceManager.h"
#import "Animation.h"
#import "Sprite.h"
#import "Player.h"
#import "DPad.h"
#import "HUD.h"

@interface GSMain : GLESGameState <DPadDelegate> {
	TileWorld* tileWorld;
	Player *player;
	NSMutableString *currentMap;
	NSMutableString *north, *east, *south, *west;
	CGPoint playerStartingPoint;
	bool migrating;
	NSMutableDictionary *entitiesPerMap;
	HUD *hud;
}

-(id) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager andMap:(NSString *)mapName;
- (void) setGameStateMap:(NSString *)map;
- (void)fadeOut;
- (void)fadeIn;
- (void)prepareNewLevel:(NSString *)level;

@end
