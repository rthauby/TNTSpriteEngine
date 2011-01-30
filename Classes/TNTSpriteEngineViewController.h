//
//  TNTSpriteEngineViewController.h
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright TNTpixel 2010. All rights reserved.
//

#import "Controller.h"
#import "DPad.h"

@interface TNTSpriteEngineViewController : UIViewController {
	UIView *gameView;
	UIView *controller;
	DPad *dpad;
}

@property (nonatomic, retain) UIView *gameView;
@property (nonatomic, retain) UIView *controller;
@property (nonatomic, retain) DPad *dpad;

@end

