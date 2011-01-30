//
//  TNTSpriteEngineAppDelegate.h
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright TNTpixel 2010. All rights reserved.
//

#import "ResourceManager.h"
#include "GameStateManager.h"
#import "GSMain.h"

@class TNTSpriteEngineViewController;

@interface TNTSpriteEngineAppDelegate : GameStateManager <UIApplicationDelegate> {
    UIWindow *window;
    TNTSpriteEngineViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TNTSpriteEngineViewController *viewController;

@end

