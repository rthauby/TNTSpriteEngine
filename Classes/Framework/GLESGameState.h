//
//  GLESGameState.h
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameState.h"

@interface GLESGameState : GameState {

}

- (void) startDraw;
- (void) swapBuffers;
- (BOOL) bindLayer;
+ (void) setup2D;

-(id) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager;

@end
