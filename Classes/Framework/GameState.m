//
//  GameState.m
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "GameState.h"


@implementation GameState


-(id) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager;
{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		m_pManager = pManager;
		self.userInteractionEnabled = true;
    }
    return self;
}

- (void) update 
{
	
}

- (void) render
{
	
}

- (void)dealloc {
    [super dealloc];
}

@end
