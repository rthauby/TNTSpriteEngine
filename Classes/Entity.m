//
//  Entity.m
//  Chapter3 Framework
//
//  Created by Joe Hogue on 5/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Entity.h"
#import "ResourceManager.h"
#import "Sprite.h"
#import "TileWorld.h"
#import "Tile.h"
#import "Animation.h"

@implementation Entity

@synthesize sprite;
@synthesize originPos;

- (id) initWithPos:(CGPoint) pos sprite:(Sprite*)spr 
{
	[super init];
	self.sprite = spr;
	self.originPos = pos;
	return self;
}

- (void) setWorldPos:(CGPoint)point {
	self.originPos = CGPointMake(point.x - (sprite.anim.frameSize.width / 2), point.y - (sprite.anim.frameSize.height / 2));
}

- (CGPoint) worldPos {
	return CGPointMake(originPos.x + (sprite.anim.frameSize.width / 2), originPos.y + (sprite.anim.frameSize.height / 2));
}

- (void) forceToPos:(CGPoint) pos{
	self.worldPos = pos;
}

- (void) drawAtPoint:(CGPoint)offset {
	offset.x += originPos.x;
	offset.y += originPos.y;
	[sprite drawAtPoint:offset];
}

- (void) update:(CGFloat) time {
	[sprite update:time];
}

- (NSComparisonResult) depthSort:(Entity*) other {
	if (self->originPos.y > other->originPos.y) return NSOrderedAscending;
	if (self->originPos.y < other->originPos.y) return NSOrderedDescending;
	//the logical thing to do at this point is to return NSOrderedSame, but
	//that causes flickering when two items are overlapping at the same y. Instead,
	//one must be drawn over the other deterministically... we use the memory
	//addresses of the entities for a tie-breaker.
	if (self < other) return NSOrderedDescending;
	return NSOrderedAscending;
}

- (void) setWorld:(TileWorld*) newWorld {
	world = newWorld;
}

- (void) dealloc {
	[sprite release];
	[super dealloc];
}

@end
