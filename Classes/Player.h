//
//  Tom.h
//  Chapter3 Framework
//
//  Created by Joe Hogue on 6/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Entity.h"

@interface Player : Entity {
	CGPoint destPos;
	int last_direction; 
	float dx, dy;
	float health, maxHealth;
}

@property CGPoint destPos;
@property float health, maxHealth;

- (void) moveToAbsolutePosition:(CGPoint) point;
- (void) moveToRelativePosition:(CGPoint) point;
- (id) initWithPos:(CGPoint) pos sprite:(Sprite*)spr;
- (bool) doneMoving;

@end
