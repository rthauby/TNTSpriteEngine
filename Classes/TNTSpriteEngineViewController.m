//
//  TNTSpriteEngineViewController.m
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright TNTpixel 2010. All rights reserved.
//

#import "TNTSpriteEngineViewController.h"

@implementation TNTSpriteEngineViewController

@synthesize gameView, controller, dpad;

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void) viewDidLoad {
	controller = [[UIView alloc] initWithFrame:CGRectMake(0, 576, 768, 448)];
	dpad = [[DPad alloc] initWithImage:[UIImage imageNamed:@"dpad.png"] andFrame:CGRectMake(50, 60, 200, 200)];
	[controller addSubview:dpad];
	[self.view addSubview:controller];
	
	UIColor *bg = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg_controller.png"]];
	[self.controller setBackgroundColor:bg];
	[bg release];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[gameView release];
	[controller release];
	[dpad release];
	
    [super dealloc];
}

@end
