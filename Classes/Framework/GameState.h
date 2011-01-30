//
//  GameState.h
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GameStateManager.h"
#import <UIKit/UIView.h>

@interface GameState : UIView {
	GameStateManager* m_pManager;
}
-(id) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager;
-(void) render;
-(void) update;

@end
