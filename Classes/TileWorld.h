//
//  TileWorld.h
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import <Foundation/Foundation.h>

//global tile size.
#define TILE_SIZE 32

@class Tile;
@class Entity;

@interface TileWorld : NSObject {
	NSMutableArray* tiles;
	NSMutableArray* entities;
	CGRect view; //typically will be the same rect as the screen.  in pixels.  considered to be in opengl coordinates (0, 0 in bottom left)
	int world_width, world_height; //in tiles.  defines the dimensions of ***tiles.
	int camera_x, camera_y; //in pixels, relative to world origin (0, 0).  view will be centered around this point.
}

- (TileWorld*) initWithFrame:(CGRect) frame;
- (void) loadLevel:(NSString*) levelFilename withTiles:(NSString*)imageFilename;
- (void) draw;
- (void) setCamera:(CGPoint)position;
- (Tile*) tileAt:(CGPoint)worldPosition;
- (BOOL) walkable:(CGPoint) point;
- (void) addEntity:(Entity*) entity;
- (void) removeEntity:(Entity*) entity;
- (CGPoint) worldPosition:(CGPoint)screenPosition;

@property (readonly) int world_width, world_height;
@property (nonatomic, retain) NSMutableArray *tiles;

@end
