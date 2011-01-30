//
//  Sprite.h
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/25/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Animation;

@interface Sprite : NSObject {
	Animation* anim;
	NSString* sequence;
	float sequence_time;
	int currentFrame;
}

@property (nonatomic, retain) Animation* anim;
@property (nonatomic, retain) NSString* sequence;
@property (nonatomic, readonly) int currentFrame; //made accessible for Rideable
 
+ (Sprite*) spriteWithAnimation:(Animation*) anim;
- (void) drawAtPoint:(CGPoint) point;
- (void) update:(float) time;

@end
