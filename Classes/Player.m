//
//  Tom.m
//  Chapter3 Framework
//
//  Created by Joe Hogue on 6/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "TileWorld.h"
#import "Sprite.h"
#import "Animation.h"
#import "pointmath.h"
#import "ResourceManager.h"

@implementation Player
@synthesize destPos;
@synthesize health, maxHealth;

- (id) initWithPos:(CGPoint) pos sprite:(Sprite*)spr 
{
	[super initWithPos:pos sprite:spr];
	destPos = originPos;
	last_direction = 2;
	dx = 0;
	dy = 0;
	health = 3.0;
	maxHealth = 3.0;
	return self;
}

- (void) moveToAbsolutePosition:(CGPoint) point {
	destPos = point;
}

- (void) moveToRelativePosition:(CGPoint) point {
	dx = point.x;
	dy = point.y;
}

- (bool) walkable:(CGPoint) point {
	return [world walkable:point];
}

- (void) update:(CGFloat) time {
	CGPoint revertPos = self.originPos;
	
	originPos.x = originPos.x + dx;
	originPos.y = originPos.y + dy;
	
	if(![self walkable:self.worldPos]){
		if([self walkable:CGPointMake(self.worldPos.x, revertPos.y)]){
			//just revert y, so we can slide along wall.
			self.originPos = CGPointMake(originPos.x, revertPos.y);
			//if we can't progress any further in x or y, then we are as close to dest as we get.
		}
		else if([self walkable:CGPointMake(revertPos.x, self.worldPos.y)]){
			//just revert x, so we can slide along wall.
			self.originPos = CGPointMake(revertPos.x, originPos.y);
			//if we can't progress any further in x or y, then we are as close to dest as we get.
		}
		else {
			//can't move here.
			self.originPos = revertPos;
			//so stop trying.
			destPos = originPos;
		}
	}
//	NSLog(@"%@",NSStringFromCGPoint(self.originPos));
	
	NSString* facing = nil;
	int direction = -1;
	if(dx != 0 || dy != 0){
		if(fabs(dx) > fabs(dy)){
			if(dx < 0) {
				direction = 1;
			} else {
				direction = 3;
			}
		} else {
			if(dy < 0){
				direction = 2;
			} else {
				direction = 0;
			}
		}
		last_direction = direction;
	}
	
	if(direction == -1){
		//idle.
		NSString* idles[] = {
			@"idle-up", @"idle-left", @"idle", @"idle-right"
		};
		facing = idles[last_direction];
	} else {
		//directional walk.
		NSString* walks[] = {
			@"walkup", @"walkleft", @"walkdown", @"walkright"
		};
		facing = walks[direction];
	}
	if(facing && ![sprite.sequence isEqualToString:facing])
	{
		//NSLog(@"facing %@", facing);
		sprite.sequence = facing;
	}
	
	[sprite update:time];
}

- (bool) doneMoving {
	return originPos.x == destPos.x && originPos.y == destPos.y;
}

@end
