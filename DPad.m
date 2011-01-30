//
//  DPad.m
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/28/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "DPad.h"
#import "pointmath.h"

#define LOOP_TIMER_MINIMUM 0.033f

@implementation DPad

@synthesize delegate, thumb;

- (id) initWithImage:(UIImage *)img andFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
        // Initialization code
		
		radius = self.frame.size.width / 2;
		diameter = 2 * radius;
		thumb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"thumbMarker.png"]];
		thumb.hidden = YES;
		UIImageView *bg = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] autorelease];
		[bg setImage:img];
		[self addSubview:bg];
		self.multipleTouchEnabled = YES;
		bg.multipleTouchEnabled = NO;
		CGFloat yPos = self.frame.size.height / 2;
		CGFloat xPos = self.frame.size.width / 2;
		center = CGPointMake(xPos, yPos);
		pressedPoint = center;
		[self addSubview:thumb];
		[self bringSubviewToFront:thumb];
		
		[NSTimer scheduledTimerWithTimeInterval:LOOP_TIMER_MINIMUM target:self selector:@selector(sendDPadPointLoop) userInfo:nil repeats:NO];
    }
    return self;
}

- (void) sendDPadPointLoop {
	int maxMovement = 16;
	CGPoint travelPoint = CGPointMake(((pressedPoint.x - center.x) / center.x) * maxMovement, ((center.y - pressedPoint.y) / center.y) * maxMovement);
	if (dist(center, pressedPoint) > 8) {
		[delegate moveTo:travelPoint];
		[thumb setCenter:pressedPoint];
	} else {
		[delegate moveTo:CGPointMake(0, 0)];
	}


	[NSTimer scheduledTimerWithTimeInterval:LOOP_TIMER_MINIMUM target:self selector:@selector(sendDPadPointLoop) userInfo:nil repeats:NO];
}

- (void) moveDPadForEvent:(UIEvent *)event {
	CGPoint lastPoint = [[[event touchesForView:self] anyObject] locationInView:self];
	
	// Long time since I've done Trig... as evidenced here
	if (dist(lastPoint,center) > radius) {
		CGPoint origin = CGPointMake(0, 0);
		CGPoint touch = CGPointMake(lastPoint.x - radius, lastPoint.y - radius);
		float touchDist = dist(touch, origin);
		float touchCos = touch.x / touchDist;
		float touchSin = touch.y / touchDist;
		lastPoint.x = radius + (radius * touchCos);
		lastPoint.y = radius + (radius * touchSin);
	}

	pressedPoint = lastPoint;
	[thumb setCenter:pressedPoint];
	thumb.hidden = NO;
}

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	[self moveDPadForEvent:event];
}

-(void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
	[self moveDPadForEvent:event];
}

-(void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
	pressedPoint = center;
	thumb.hidden = YES;
}

- (void)dealloc {
	[delegate release];
	[thumb release];
	
	[super dealloc];
}

@end
