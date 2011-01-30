//
//  Tile.m
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "Tile.h"
#import "ResourceManager.h"

@implementation Tile

@synthesize textureName;
@synthesize frame;
@synthesize flags;

- (Tile*) init {
	[super init];
	flags = 0;
	return self;
}

- (Tile*) initWithTexture:(NSString*)texture withFrame:(CGRect) _frame
{
	[self init];
	self.textureName = texture;
	self.frame = _frame;
	return self;
}

- (void) drawInRect:(CGRect)rect {
	[[g_ResManager getTexture:textureName] drawInRect:rect withClip:frame withRotation:0];
}

- (void) dealloc {
	[super dealloc];
}

@end
