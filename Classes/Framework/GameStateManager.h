//
//  GameStateManager.h
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface GameStateManager : NSObject {
	
	CFTimeInterval m_FPS_lastSecondStart;
	int m_FPS_framesThisSecond;
	
	CFTimeInterval m_lastUpdateTime;
	float m_estFramesPerSecond;	
	
	NSString *currentMapName, *startMapName;
	
}

@property (nonatomic, retain) NSString *currentMapName, *startMapName;

- (void)doStateChange: (Class) state;
- (void)gameLoop: (id) sender;
- (float)getFramesPerSecond;

@end
