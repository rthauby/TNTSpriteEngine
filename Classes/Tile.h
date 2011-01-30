//
//  Tile.h
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	UNWALKABLE = 1,
} PhysicsFlags;

@interface Tile : NSObject {
	@public
	PhysicsFlags flags;

	NSString* textureName;
	CGRect frame;
}

@property (nonatomic, retain) NSString* textureName;
@property (nonatomic) CGRect frame;
@property PhysicsFlags flags;

- (void) drawInRect:(CGRect)rect;
- (Tile*) initWithTexture:(NSString*)texture withFrame:(CGRect) _frame;

@end
