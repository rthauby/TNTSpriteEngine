//
//  HUD.h
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/30/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HUD : NSObject {
	CGRect view;
	NSMutableArray *tiles;
	float health, maxHealth;
}

@property (nonatomic, retain) NSMutableArray *tiles;
@property float health, maxHealth;

- (void) tilesFromImage:(NSString*)imageFilename;
- (void) draw;

@end
