//
//  Animation.h
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

/*
 Animation will hold a set of related animation frames, such as the frames in a single walk cycle.
 Animation does not hold the current state of that animation; this way, more than one Sprite can share the frame information stored in an Animation.
 */

#import <Foundation/Foundation.h>

@interface AnimationSequence : NSObject
{
	@public
	int frameCount;
	float* timeout;
	CGRect* frames;
	bool flipped;
	NSString* next;
}

- (AnimationSequence*) initWithFrames:(NSDictionary*) animData width:(float) width height:(float) height;

@end


@interface Animation : NSObject {
	NSString* image;
	NSMutableDictionary* sequences;
	CGPoint anchor;
	CGSize frameSize;
}

@property (readonly) CGSize frameSize;

//- (Animation*) initWithImage:(NSString*) img frameSize:(int) frameSize frames:(NSArray*) framesData;
//- (void) drawAtPoint:(CGPoint) point withFrame:(int)frame;
- (Animation*) initWithAnim:(NSString*) img;
- (void) drawAtPoint:(CGPoint) point withSequence:(NSString*) sequence withFrame:(int) frame;

-(int) getFrameCount:(NSString*) sequence;
-(NSString*) firstSequence;

-(AnimationSequence*) get:(NSString*) sequence;

@end
