//
//  HUD.m
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/30/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "HUD.h"
#import "Tile.h"
#define TILE_SIZE 18
#define TITLE_WIDTH 96
#define TITLE_HEIGHT 36
#define HEARTS_PER_ROW 9

@implementation HUD

@synthesize tiles, health, maxHealth;

-(HUD*) initWithFrame:(CGRect) frame {
	[super init];
	view = frame;
	health = 0.0;
	maxHealth = 0.0;
	return self;
}

- (void) tilesFromImage:(NSString*)imageFilename {
	tiles = [[NSMutableArray alloc] initWithCapacity:3];
	for (int i=0; i<3; i++) {
		int tileX = i * TILE_SIZE;
		Tile *tile = [[Tile alloc] initWithTexture:imageFilename withFrame:CGRectMake(tileX, 0, TILE_SIZE, TILE_SIZE)];
		[tiles addObject:tile];
		[tile release];
	}
	Tile *title = [[Tile alloc] initWithTexture:@"life_title.png" withFrame:CGRectMake(0, 0, TITLE_WIDTH, TITLE_HEIGHT)];
	[tiles addObject:title];
	[title release];
}

- (void)drawLife {
	float tileX = 0.0;
	float tileY;
	if(maxHealth > HEARTS_PER_ROW) tileY = TILE_SIZE;
	else tileY = TILE_SIZE / 2;
	int i;
	for (i=0; i <= health - 1; i++) {
		if(i >= HEARTS_PER_ROW){
			tileY = 0.0;
		}
		tileX = (i % HEARTS_PER_ROW) * TILE_SIZE;
		CGRect rect = CGRectMake(view.origin.x + tileX + TITLE_WIDTH, view.origin.y + tileY, TILE_SIZE, TILE_SIZE);
		[[tiles objectAtIndex:0] drawInRect:rect];
	}
	for (i; i < maxHealth; i++) {
		int heartShape = 2;
		if(i >= HEARTS_PER_ROW){
			tileY = 0.0;
		}
		if(i - 0.5 <= health - 1) heartShape = 1;
		tileX = (i % HEARTS_PER_ROW) * TILE_SIZE;
		CGRect rect = CGRectMake(view.origin.x + tileX + TITLE_WIDTH, view.origin.y + tileY, TILE_SIZE, TILE_SIZE);
		[[tiles objectAtIndex:heartShape] drawInRect:rect];
	}
	[[tiles objectAtIndex:3] drawInRect:CGRectMake(view.origin.x, view.origin.y, TITLE_WIDTH, TITLE_HEIGHT)];
}

- (void) draw {
	[self drawLife];
}

- (void)dealloc {
	[tiles release];
	
	[super dealloc];
}

@end
