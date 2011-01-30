//
//  TileWorld.m
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "TileWorld.h"
#import "Tile.h"
#import "ResourceManager.h"
#import "Entity.h"

@implementation TileWorld

@synthesize world_width;
@synthesize world_height;
@synthesize tiles;

- (void) loadLevel:(NSString*) levelFilename withTiles:(NSString*)imageFilename{
	NSData* filedata = [g_ResManager getBundleData:levelFilename];
	NSString* dush = [[NSString alloc] initWithData:filedata encoding:NSASCIIStringEncoding];
	UIImage *tmp = [UIImage imageNamed:imageFilename];
	int textureWidth = (int)tmp.size.width;

	NSArray* rows = [dush componentsSeparatedByString:@"\n"];
	world_width = [[[rows objectAtIndex:0] componentsSeparatedByString:@","] count];
	world_height = [rows count];
	tiles = [[NSMutableArray alloc] initWithCapacity:world_height];
		
	for(int y=0;y<world_height;y++){
		NSArray* row = [[rows objectAtIndex:y] componentsSeparatedByString:@","];
		NSMutableArray *tileRow = [NSMutableArray arrayWithCapacity:world_width];
		for(int x=0;x<world_width;x++){
			int tileId;
			if ([[row objectAtIndex:x] isEqualToString:@""]) {
				tileId = 0;
			} else {
				tileId = [[row objectAtIndex:x] intValue];
			}

			int tileX = (tileId * (int)TILE_SIZE) % textureWidth;
			int row = ((tileId * TILE_SIZE ) - tileX) / textureWidth;
			int tileY = row * TILE_SIZE;
			Tile *tile = [[Tile alloc] initWithTexture:imageFilename withFrame:CGRectMake(tileX, tileY, TILE_SIZE, TILE_SIZE)];
			
			NSArray *collisionTiles = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Collisions" ofType:@"plist"]];
			if ([collisionTiles containsObject:[NSNumber numberWithInt:tileId]]) {
				tile.flags = UNWALKABLE;
			}
			
			[tileRow addObject:tile];
			[tile release];
		}
		[tiles insertObject:tileRow atIndex:0];
	}
	[dush release];
}

-(TileWorld*) initWithFrame:(CGRect) frame {
	[super init];
	view = frame;
	return self;
}

-(void) draw
{
	CGFloat xoff = -camera_x + view.origin.x + view.size.width/2;
	CGFloat yoff = -camera_y + view.origin.y + view.size.height/2;
	CGRect rect = CGRectMake(0, 0, TILE_SIZE, TILE_SIZE);
	for(int x=0;x<world_width;x++){
		rect.origin.x = x*TILE_SIZE + xoff;

		//optimization: don't draw offscreen tiles.  only useful when world is much larger than screen.
		if(rect.origin.x + rect.size.width < view.origin.x ||
		   rect.origin.x > view.origin.x + view.size.width) {
			continue;
		}
		
		for(int y=0;y<world_height;y++){
			rect.origin.y = y*TILE_SIZE + yoff;
			if(rect.origin.y + rect.size.height < view.origin.y ||
			   rect.origin.y > view.origin.y + view.size.height) {
				continue;
			}
			[[[tiles objectAtIndex:y] objectAtIndex:x] drawInRect:rect];
		}
	}
	if(entities){
		[entities sortUsingSelector:@selector(depthSort:)];
		for(Entity* entity in entities){
			[entity drawAtPoint:CGPointMake(xoff, yoff)];
		}
	}
}

-(void) setCamera:(CGPoint)position {
	camera_x = position.x;
	camera_y = position.y;
	if (camera_x < 0 + view.size.width/2) {
		camera_x = view.size.width/2;
	}
	if (camera_x > TILE_SIZE*world_width - view.size.width/2) {
		camera_x = TILE_SIZE*world_width - view.size.width/2;
	}
	if (camera_y < 0 + view.size.height/2) {
		camera_y = view.size.height/2;
	}
	if (camera_y > TILE_SIZE*world_height - view.size.height/2) {
		camera_y = TILE_SIZE*world_height - view.size.height/2;
	}
}

//used by entities to get the tile they are standing over.
- (Tile*) tileAt:(CGPoint)worldPosition {
	int x = worldPosition.x / TILE_SIZE; //...should be floor.
	int y = worldPosition.y / TILE_SIZE;
	//note that x and y are slightly wrong when negative and near zero, because [-TILE_SIZE..TILESIZE]/TILESIZE == 0, even though [-TILESIZE..0) would be considered out of bounds.
	if(worldPosition.x < 0 || worldPosition.y < 0 || x >= world_width || y >= world_height){
		//NSLog(@"tileat point %d,%d outside of world dimensions %d,%d", x, y, world_width, world_height);
		return nil;
	}
	return [[tiles objectAtIndex:y] objectAtIndex:x];
}

- (BOOL) walkable:(CGPoint) point {
	Tile* overtile = [self tileAt:point];
	return !(overtile == nil || (overtile->flags & UNWALKABLE) != 0);
}

- (void) addEntity:(Entity*) entity {
	if(!entities) entities = [[NSMutableArray alloc] init];
	[entity setWorld:self];
	[entities addObject:entity];
}

- (void) removeEntity:(Entity*) entity {
	[entities removeObject:entity];
}

- (CGPoint) worldPosition:(CGPoint)screenPosition {
	CGFloat xoff = camera_x + view.origin.x - view.size.width/2;
	CGFloat yoff = camera_y + view.origin.y - view.size.height/2;
	return CGPointMake(xoff + screenPosition.x, yoff + screenPosition.y);
}

- (void) dealloc {
	[entities removeAllObjects];
	[entities release];
	[tiles release];
	
	[super dealloc];
}

@end
